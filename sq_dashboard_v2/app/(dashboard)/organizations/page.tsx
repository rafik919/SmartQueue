'use client';
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { orgsApi, locationApi, Organization, Wilaya, Commune } from '@/lib/api';
import { Plus, Search, ChevronRight, Trash2, Building2, MapPin } from 'lucide-react';

const orgTypes = [
  { value: '', label: 'Tous les types' },
  { value: 'bank', label: '🏦 Banque' },
  { value: 'hospital', label: '🏥 Hôpital' },
  { value: 'administration', label: '🏛️ Administration' },
  { value: 'post', label: '📮 Poste' },
  { value: 'insurance', label: '🛡️ Assurance' },
  { value: 'telecom', label: '📡 Télécom' },
  { value: 'other', label: '🏢 Autre' },
];

const typeColors: any = {
  bank: { color: '#60a5fa', label: '🏦 Banque' },
  hospital: { color: '#f87171', label: '🏥 Hôpital' },
  administration: { color: '#a78bfa', label: '🏛️ Admin' },
  post: { color: '#fbbf24', label: '📮 Poste' },
  insurance: { color: '#34d399', label: '🛡️ Assurance' },
  telecom: { color: '#fb923c', label: '📡 Télécom' },
  other: { color: '#94a3b8', label: '🏢 Autre' },
};

const selectStyle = {
  padding: '10px 14px',
  background: 'var(--bg-surface)', border: '1px solid var(--border)',
  borderRadius: '10px', color: 'var(--text)', fontSize: '13px', outline: 'none', cursor: 'pointer',
};

export default function OrganizationsPage() {
  const router = useRouter();
  const [orgs, setOrgs] = useState<Organization[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [type, setType] = useState('');
  const [wilayaId, setWilayaId] = useState('');
  const [communeId, setCommuneId] = useState('');
  const [wilayas, setWilayas] = useState<Wilaya[]>([]);
  const [communes, setCommunes] = useState<Commune[]>([]);
  const [deleting, setDeleting] = useState<string | null>(null);

  useEffect(() => { locationApi.wilayas().then(setWilayas); }, []);

  useEffect(() => {
    if (wilayaId) {
      locationApi.communes(+wilayaId).then(setCommunes);
      setCommuneId('');
    } else {
      setCommunes([]);
      setCommuneId('');
    }
  }, [wilayaId]);

  const load = async () => {
    setLoading(true);
    try {
      const res = await orgsApi.list({
        q: search || undefined,
        type: type || undefined,
        wilayaId: wilayaId ? +wilayaId : undefined,
        communeId: communeId ? +communeId : undefined,
      });
      setOrgs(res.items);
      setTotal(res.total);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, [search, type, wilayaId, communeId]);

  const handleDelete = async (id: string, name: string) => {
    if (!confirm(`Supprimer "${name}" ?`)) return;
    setDeleting(id);
    try {
      await orgsApi.delete(id);
      setOrgs(prev => prev.filter(o => o.id !== id));
      setTotal(t => t - 1);
    } finally { setDeleting(null); }
  };

  return (
    <div className="animate-in">
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: '28px' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '4px' }}>
            <Building2 size={20} color="var(--accent2)" />
            <h1 style={{ fontSize: '22px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>Établissements</h1>
          </div>
          <p style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>
            {total} établissement{total > 1 ? 's' : ''} enregistré{total > 1 ? 's' : ''}
          </p>
        </div>
        <button onClick={() => router.push('/organizations/new')} className="btn-primary"
          style={{ padding: '10px 18px', borderRadius: '12px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '8px' }}>
          <Plus size={15} /> Nouvel établissement
        </button>
      </div>

      <div style={{ display: 'flex', gap: '10px', marginBottom: '20px', flexWrap: 'wrap' }}>
        <div style={{ flex: 1, minWidth: '200px', position: 'relative' }}>
          <Search size={14} color="var(--text-muted)" style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)' }} />
          <input value={search} onChange={e => setSearch(e.target.value)}
            placeholder="Rechercher un établissement..."
            style={{
              width: '100%', padding: '10px 14px 10px 38px',
              background: 'var(--bg-surface)', border: '1px solid var(--border)',
              borderRadius: '10px', color: 'var(--text)', fontSize: '13px', outline: 'none',
            }} />
        </div>

        <select value={wilayaId} onChange={e => setWilayaId(e.target.value)} style={selectStyle}>
          <option value="">📍 Toutes les wilayas</option>
          {wilayas.map(w => <option key={w.id} value={w.id}>{w.id} - {w.name}</option>)}
        </select>

        {communes.length > 0 && (
          <select value={communeId} onChange={e => setCommuneId(e.target.value)} style={selectStyle}>
            <option value="">🏘️ Toutes les communes</option>
            {communes.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
        )}

        <select value={type} onChange={e => setType(e.target.value)} style={selectStyle}>
          {orgTypes.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
        </select>
      </div>

      <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '16px', overflow: 'hidden' }}>
        <div style={{
          display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 100px 120px',
          padding: '12px 20px', borderBottom: '1px solid var(--border)',
          background: 'var(--bg-surface2)',
        }}>
          {['Établissement', 'Type', 'Localisation', 'Statut', 'Actions'].map(h => (
            <span key={h} style={{ fontSize: '11px', fontWeight: 700, color: 'var(--text-muted)', letterSpacing: '0.06em', textTransform: 'uppercase' }}>{h}</span>
          ))}
        </div>

        {loading ? (
          <div style={{ padding: '20px', display: 'flex', flexDirection: 'column', gap: '10px' }}>
            {[1,2,3,4].map(i => <div key={i} className="skeleton" style={{ height: '56px' }} />)}
          </div>
        ) : orgs.length === 0 ? (
          <div style={{ padding: '60px', textAlign: 'center' }}>
            <Building2 size={32} color="var(--text-muted)" style={{ margin: '0 auto 12px' }} />
            <p style={{ color: 'var(--text-secondary)', fontSize: '14px', fontWeight: 500 }}>Aucun établissement trouvé</p>
            <p style={{ color: 'var(--text-muted)', fontSize: '12px', marginTop: '4px' }}>Créez votre premier établissement</p>
          </div>
        ) : orgs.map((org, i) => {
          const t = typeColors[org.type] || typeColors.other;
          const branch = org.branches?.[0];
          const location = branch?.commune?.name
            ? `${branch.wilaya?.name} › ${branch.commune.name}`
            : branch?.wilaya?.name || '—';

          return (
            <div key={org.id} className="table-row" style={{
              display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 100px 120px',
              padding: '14px 20px', alignItems: 'center',
              borderBottom: i < orgs.length - 1 ? '1px solid var(--border)' : 'none',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                <div style={{
                  width: '36px', height: '36px', borderRadius: '10px', flexShrink: 0,
                  background: `${t.color}15`, border: `1px solid ${t.color}25`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: '13px', fontWeight: 700, color: t.color,
                }}>
                  {org.name[0].toUpperCase()}
                </div>
                <div>
                  <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{org.name}</p>
                  {org.nameAr && <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '1px' }}>{org.nameAr}</p>}
                </div>
              </div>

              <span className="badge" style={{ background: `${t.color}12`, color: t.color, border: `1px solid ${t.color}25`, width: 'fit-content' }}>
                {t.label}
              </span>

              <div style={{ display: 'flex', alignItems: 'center', gap: '5px' }}>
                <MapPin size={11} color="var(--text-muted)" />
                <span style={{ fontSize: '12px', color: 'var(--text-secondary)' }}>{location}</span>
              </div>

              <span className={`badge ${org.isActive ? 'badge-success' : 'badge-error'}`}>
                {org.isActive ? '● Actif' : '● Inactif'}
              </span>

              <div style={{ display: 'flex', gap: '6px' }}>
                <button onClick={() => router.push(`/organizations/${org.id}`)}
                  style={{
                    display: 'flex', alignItems: 'center', gap: '4px',
                    padding: '6px 10px', borderRadius: '8px', fontSize: '12px', fontWeight: 500,
                    background: 'var(--bg-surface2)', border: '1px solid var(--border)',
                    color: 'var(--text-secondary)', cursor: 'pointer',
                  }}>
                  <ChevronRight size={13} /> Détail
                </button>
                <button onClick={() => handleDelete(org.id, org.name)} disabled={deleting === org.id}
                  style={{
                    padding: '6px 8px', borderRadius: '8px',
                    background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.15)',
                    color: 'var(--error)', cursor: 'pointer',
                    opacity: deleting === org.id ? 0.5 : 1,
                  }}>
                  <Trash2 size={13} />
                </button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}