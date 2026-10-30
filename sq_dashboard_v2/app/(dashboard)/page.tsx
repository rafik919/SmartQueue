'use client';
import { useEffect, useState } from 'react';
import { api } from '@/lib/api';
import { Building2, GitBranch, Ticket, Users, TrendingUp, ArrowUpRight } from 'lucide-react';

export default function OverviewPage() {
  const [stats, setStats] = useState<any>(null);
  const [orgs, setOrgs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      api.get('/admin/stats').catch(() => ({ data: { data: null } })),
      api.get('/organizations?limit=6').catch(() => ({ data: { data: { items: [] } } })),
    ]).then(([s, o]) => {
      setStats(s.data.data);
      setOrgs(o.data.data?.items || []);
    }).finally(() => setLoading(false));
  }, []);

  const cards = [
    { label: 'Organisations', value: stats?.totalOrgs ?? 0, icon: Building2, color: '#7c6ff7', bg: 'rgba(124,111,247,0.1)', border: 'rgba(124,111,247,0.2)', trend: '+2 ce mois' },
    { label: 'Agences', value: stats?.totalBranches ?? 0, icon: GitBranch, color: '#60a5fa', bg: 'rgba(96,165,250,0.1)', border: 'rgba(96,165,250,0.2)', trend: 'Total actives' },
    { label: 'Tickets aujourd\'hui', value: stats?.ticketsToday ?? 0, icon: Ticket, color: '#34d399', bg: 'rgba(52,211,153,0.1)', border: 'rgba(52,211,153,0.2)', trend: 'En temps réel' },
    { label: 'Agents & Staff', value: stats?.totalAgents ?? 0, icon: Users, color: '#fbbf24', bg: 'rgba(251,191,36,0.1)', border: 'rgba(251,191,36,0.2)', trend: 'Tous rôles' },
  ];

  const orgTypeColors: any = {
    bank: { color: '#60a5fa', label: 'Banque' },
    hospital: { color: '#f87171', label: 'Hôpital' },
    administration: { color: '#a78bfa', label: 'Administration' },
    post: { color: '#fbbf24', label: 'Poste' },
    insurance: { color: '#34d399', label: 'Assurance' },
    telecom: { color: '#fb923c', label: 'Télécom' },
    other: { color: '#94a3b8', label: 'Autre' },
  };

  return (
    <div className="animate-in">
      {/* Header */}
      <div style={{ marginBottom: '32px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '6px' }}>
          <TrendingUp size={20} color="var(--accent2)" />
          <h1 style={{ fontSize: '22px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>Vue générale</h1>
        </div>
        <p style={{ color: 'var(--text-secondary)', fontSize: '13px' }}>Bienvenue sur le dashboard SmartQueue</p>
      </div>

      {/* KPI Cards */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '32px' }}>
        {cards.map(({ label, value, icon: Icon, color, bg, border, trend }) => (
          <div key={label} className="card-hover" style={{
            background: 'var(--bg-surface)', border: '1px solid var(--border)',
            borderRadius: '16px', padding: '20px',
          }}>
            <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '16px' }}>
              <div style={{ width: '40px', height: '40px', borderRadius: '12px', background: bg, border: `1px solid ${border}`, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon size={18} color={color} />
              </div>
              <span style={{ fontSize: '11px', color: 'var(--text-muted)', background: 'var(--bg-surface2)', padding: '3px 8px', borderRadius: '6px', border: '1px solid var(--border)' }}>
                {trend}
              </span>
            </div>
            <p style={{ fontSize: '28px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em', marginBottom: '4px' }}>
              {loading ? '—' : value}
            </p>
            <p style={{ fontSize: '12px', color: 'var(--text-secondary)', fontWeight: 500 }}>{label}</p>
          </div>
        ))}
      </div>

      {/* Dernières orgs */}
      <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '16px', overflow: 'hidden' }}>
        <div style={{ padding: '20px 24px', borderBottom: '1px solid var(--border)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <div>
            <h2 style={{ fontWeight: 600, color: 'var(--text)', fontSize: '14px' }}>Dernières organisations</h2>
            <p style={{ fontSize: '12px', color: 'var(--text-muted)', marginTop: '2px' }}>{orgs.length} établissements affichés</p>
          </div>
          <a href="/organizations" style={{ display: 'flex', alignItems: 'center', gap: '4px', fontSize: '12px', color: 'var(--accent2)', textDecoration: 'none', fontWeight: 500 }}>
            Voir tout <ArrowUpRight size={13} />
          </a>
        </div>

        {loading ? (
          <div style={{ padding: '40px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
            {[1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '52px' }} />)}
          </div>
        ) : orgs.length === 0 ? (
          <div style={{ padding: '48px', textAlign: 'center', color: 'var(--text-muted)', fontSize: '13px' }}>
            Aucune organisation
          </div>
        ) : orgs.map((org: any, i: number) => {
          const typeInfo = orgTypeColors[org.type] || orgTypeColors.other;
          return (
            <div key={org.id} className="table-row" style={{
              display: 'flex', alignItems: 'center', justifyContent: 'space-between',
              padding: '14px 24px',
              borderBottom: i < orgs.length - 1 ? '1px solid var(--border)' : 'none',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                <div style={{
                  width: '36px', height: '36px', borderRadius: '10px', flexShrink: 0,
                  background: `${typeInfo.color}18`, border: `1px solid ${typeInfo.color}30`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: '13px', fontWeight: 700, color: typeInfo.color,
                }}>
                  {org.name[0].toUpperCase()}
                </div>
                <div>
                  <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{org.name}</p>
                  <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '1px' }}>
                    {org.branches?.length ?? 0} agence{(org.branches?.length ?? 0) > 1 ? 's' : ''}
                  </p>
                </div>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <span className="badge badge-muted">{typeInfo.label}</span>
                <span className={`badge ${org.isActive ? 'badge-success' : 'badge-error'}`}>
                  {org.isActive ? 'Actif' : 'Inactif'}
                </span>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}