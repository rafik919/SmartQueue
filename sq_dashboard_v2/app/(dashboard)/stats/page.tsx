'use client';
import { useEffect, useState } from 'react';
import { api } from '@/lib/api';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts';
import { BarChart3, Building2, GitBranch, TrendingUp } from 'lucide-react';

const TYPE_COLORS: any = {
  bank: '#60a5fa', hospital: '#f87171', administration: '#a78bfa',
  post: '#fbbf24', insurance: '#34d399', telecom: '#fb923c', other: '#94a3b8',
};
const TYPE_LABELS: any = {
  bank: 'Banque', hospital: 'Hôpital', administration: 'Administration',
  post: 'Poste', insurance: 'Assurance', telecom: 'Télécom', other: 'Autre',
};

const CustomTooltip = ({ active, payload, label }: any) => {
  if (!active || !payload?.length) return null;
  return (
    <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '10px', padding: '10px 14px', fontSize: '12px' }}>
      <p style={{ color: 'var(--text-muted)', marginBottom: '4px' }}>{label}</p>
      <p style={{ color: 'var(--text)', fontWeight: 700 }}>{payload[0].value}</p>
    </div>
  );
};

export default function StatsPage() {
  const [orgs, setOrgs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/organizations?limit=50').then(res => {
      setOrgs(res.data.data?.items || []);
    }).finally(() => setLoading(false));
  }, []);

  const byType = orgs.reduce((acc: any, o: any) => {
    acc[o.type] = (acc[o.type] || 0) + 1;
    return acc;
  }, {});
  const typeData = Object.entries(byType).map(([name, value]) => ({ name: TYPE_LABELS[name] || name, value, color: TYPE_COLORS[name] || '#94a3b8' }));

  const branchData = [...orgs]
    .sort((a, b) => (b.branches?.length ?? 0) - (a.branches?.length ?? 0))
    .slice(0, 6)
    .map(o => ({ name: o.name.length > 14 ? o.name.slice(0, 14) + '…' : o.name, agences: o.branches?.length ?? 0 }));

  const activeCount = orgs.filter(o => o.isActive).length;
  const totalBranches = orgs.reduce((s, o) => s + (o.branches?.length ?? 0), 0);

  const kpis = [
    { label: 'Total organisations', value: orgs.length, icon: Building2, color: '#7c6ff7' },
    { label: 'Organisations actives', value: activeCount, icon: TrendingUp, color: '#34d399' },
    { label: 'Total agences', value: totalBranches, icon: GitBranch, color: '#60a5fa' },
  ];

  return (
    <div className="animate-in">
      {/* Header */}
      <div style={{ marginBottom: '28px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '4px' }}>
          <BarChart3 size={20} color="var(--accent2)" />
          <h1 style={{ fontSize: '22px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>Statistiques</h1>
        </div>
        <p style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>Vue analytique du système SmartQueue</p>
      </div>

      {/* KPIs */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '16px', marginBottom: '24px' }}>
        {kpis.map(({ label, value, icon: Icon, color }) => (
          <div key={label} className="card-hover" style={{ padding: '22px', borderRadius: '16px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '14px' }}>
              <div style={{ width: '38px', height: '38px', borderRadius: '11px', background: `${color}15`, border: `1px solid ${color}25`, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon size={17} color={color} />
              </div>
            </div>
            <p style={{ fontSize: '32px', fontWeight: 800, color: 'var(--text)', letterSpacing: '-0.03em', marginBottom: '4px' }}>
              {loading ? '—' : value}
            </p>
            <p style={{ fontSize: '12px', color: 'var(--text-secondary)', fontWeight: 500 }}>{label}</p>
          </div>
        ))}
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '16px' }}>

        {/* Pie par type */}
        <div style={{ padding: '24px', borderRadius: '16px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
          <h2 style={{ fontWeight: 700, color: 'var(--text)', fontSize: '14px', marginBottom: '4px' }}>Par type</h2>
          <p style={{ fontSize: '12px', color: 'var(--text-muted)', marginBottom: '20px' }}>Répartition des établissements</p>
          {loading ? (
            <div className="skeleton" style={{ height: '200px', borderRadius: '12px' }} />
          ) : (
            <>
              <ResponsiveContainer width="100%" height={180}>
                <PieChart>
                  <Pie data={typeData} dataKey="value" cx="50%" cy="50%" innerRadius={50} outerRadius={80}>
                    {typeData.map((entry, i) => <Cell key={i} fill={entry.color} />)}
                  </Pie>
                  <Tooltip content={<CustomTooltip />} />
                </PieChart>
              </ResponsiveContainer>
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginTop: '12px' }}>
                {typeData.map(({ name, value, color }) => (
                  <div key={name} style={{ display: 'flex', alignItems: 'center', gap: '6px', padding: '4px 10px', borderRadius: '8px', background: `${color}12`, border: `1px solid ${color}25` }}>
                    <div style={{ width: '6px', height: '6px', borderRadius: '50%', background: color, flexShrink: 0 }} />
                    <span style={{ fontSize: '11px', fontWeight: 600, color }}>{name} ({value})</span>
                  </div>
                ))}
              </div>
            </>
          )}
        </div>

        {/* Statut */}
        <div style={{ padding: '24px', borderRadius: '16px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
          <h2 style={{ fontWeight: 700, color: 'var(--text)', fontSize: '14px', marginBottom: '4px' }}>Statut</h2>
          <p style={{ fontSize: '12px', color: 'var(--text-muted)', marginBottom: '20px' }}>Actifs vs Inactifs</p>
          {loading ? (
            <div className="skeleton" style={{ height: '200px', borderRadius: '12px' }} />
          ) : (
            <>
              <ResponsiveContainer width="100%" height={180}>
                <PieChart>
                  <Pie data={[{ name: 'Actifs', value: activeCount }, { name: 'Inactifs', value: orgs.length - activeCount }]} dataKey="value" cx="50%" cy="50%" innerRadius={50} outerRadius={80}>
                    <Cell fill="#34d399" />
                    <Cell fill="#f87171" />
                  </Pie>
                  <Tooltip content={<CustomTooltip />} />
                </PieChart>
              </ResponsiveContainer>
              <div style={{ display: 'flex', gap: '10px', marginTop: '12px' }}>
                <div style={{ flex: 1, padding: '12px', borderRadius: '10px', background: 'rgba(52,211,153,0.08)', border: '1px solid rgba(52,211,153,0.2)', textAlign: 'center' }}>
                  <p style={{ fontSize: '22px', fontWeight: 800, color: 'var(--success)' }}>{activeCount}</p>
                  <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '2px' }}>Actifs</p>
                </div>
                <div style={{ flex: 1, padding: '12px', borderRadius: '10px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)', textAlign: 'center' }}>
                  <p style={{ fontSize: '22px', fontWeight: 800, color: 'var(--error)' }}>{orgs.length - activeCount}</p>
                  <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '2px' }}>Inactifs</p>
                </div>
              </div>
            </>
          )}
        </div>
      </div>

      {/* Bar chart agences */}
      <div style={{ padding: '24px', borderRadius: '16px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
        <h2 style={{ fontWeight: 700, color: 'var(--text)', fontSize: '14px', marginBottom: '4px' }}>Top organisations</h2>
        <p style={{ fontSize: '12px', color: 'var(--text-muted)', marginBottom: '20px' }}>Classement par nombre d'agences</p>
        {loading ? (
          <div className="skeleton" style={{ height: '200px', borderRadius: '12px' }} />
        ) : (
          <ResponsiveContainer width="100%" height={200}>
            <BarChart data={branchData} barSize={32}>
              <XAxis dataKey="name" tick={{ fill: 'var(--text-muted)', fontSize: 11 }} axisLine={false} tickLine={false} />
              <YAxis tick={{ fill: 'var(--text-muted)', fontSize: 11 }} axisLine={false} tickLine={false} />
              <Tooltip content={<CustomTooltip />} />
              <Bar dataKey="agences" radius={[6, 6, 0, 0]}>
                {branchData.map((_, i) => (
                  <Cell key={i} fill={i === 0 ? 'var(--accent)' : 'var(--bg-surface3)'} />
                ))}
              </Bar>
            </BarChart>
          </ResponsiveContainer>
        )}
      </div>
    </div>
  );
}