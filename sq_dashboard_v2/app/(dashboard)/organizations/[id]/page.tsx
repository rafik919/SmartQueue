'use client';
import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { orgsApi, usersApi, Organization, User } from '@/lib/api';
import { ArrowLeft, Plus, Users, Globe, Mail, Phone, MapPin, X, Check, Building2 } from 'lucide-react';

const inputStyle = {
  width: '100%', padding: '10px 14px',
  background: 'var(--bg-surface2)', border: '1px solid var(--border)',
  borderRadius: '10px', color: 'var(--text)', fontSize: '13px', outline: 'none',
};

const labelStyle = {
  display: 'block', fontSize: '11px', fontWeight: 700,
  color: 'var(--text-muted)', marginBottom: '6px',
  letterSpacing: '0.06em', textTransform: 'uppercase' as const,
};

const roleColors: any = {
  SUPER_ADMIN: { color: '#f87171', label: 'Super Admin' },
  ORG_ADMIN: { color: '#a78bfa', label: 'Org Admin' },
  BRANCH_MANAGER: { color: '#60a5fa', label: 'Branch Manager' },
  AGENT: { color: '#34d399', label: 'Agent' },
  CLIENT: { color: '#94a3b8', label: 'Client' },
};

const typeColors: any = {
  bank: { color: '#60a5fa', label: '🏦 Banque' },
  hospital: { color: '#f87171', label: '🏥 Hôpital' },
  administration: { color: '#a78bfa', label: '🏛️ Administration' },
  post: { color: '#fbbf24', label: '📮 Poste' },
  insurance: { color: '#34d399', label: '🛡️ Assurance' },
  telecom: { color: '#fb923c', label: '📡 Télécom' },
  other: { color: '#94a3b8', label: '🏢 Autre' },
};

export default function OrgDetailPage() {
  const router = useRouter();
  const { id } = useParams<{ id: string }>();
  const [org, setOrg] = useState<Organization | null>(null);
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [tab, setTab] = useState<'overview' | 'staff'>('overview');

  const [showStaffModal, setShowStaffModal] = useState(false);
  const [staffForm, setStaffForm] = useState({ firstName: '', lastName: '', email: '', password: '', role: 'AGENT' });
  const [staffLoading, setStaffLoading] = useState(false);
  const [staffError, setStaffError] = useState('');

  const load = async () => {
    setLoading(true);
    try {
      const [orgData, usersData] = await Promise.all([orgsApi.get(id), usersApi.listByOrg(id)]);
      setOrg(orgData);
      setUsers(usersData);
    } finally { setLoading(false); }
  };

  useEffect(() => { load(); }, [id]);

  const handleCreateStaff = async (e: React.FormEvent) => {
    e.preventDefault();
    setStaffLoading(true); setStaffError('');
    try {
      await usersApi.createUser({ ...staffForm, organizationId: id });
      setShowStaffModal(false);
      setStaffForm({ firstName: '', lastName: '', email: '', password: '', role: 'AGENT' });
      load();
    } catch (err: any) {
      setStaffError(err.response?.data?.message || 'Erreur');
    } finally { setStaffLoading(false); }
  };

  if (loading) return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
      {[1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '80px', borderRadius: '16px' }} />)}
    </div>
  );

  if (!org) return (
    <div style={{ textAlign: 'center', padding: '60px', color: 'var(--error)' }}>Établissement introuvable</div>
  );

  const branch = org.branches?.[0];
  const t = typeColors[org.type] || typeColors.other;
  const location = branch?.commune?.name
    ? `${branch.wilaya?.name} › ${branch.commune.name}`
    : branch?.wilaya?.name || '—';

  const tabs = [
    { key: 'overview', label: 'Informations', icon: Building2 },
    { key: 'staff', label: `Staff (${users.length})`, icon: Users },
  ];

  return (
    <div className="animate-in">
      {/* Header */}
      <div style={{ marginBottom: '28px' }}>
        <button onClick={() => router.push('/organizations')}
          style={{ display: 'flex', alignItems: 'center', gap: '6px', background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: '12px', marginBottom: '16px', padding: 0 }}>
          <ArrowLeft size={14} /> Retour aux établissements
        </button>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
            <div style={{
              width: '48px', height: '48px', borderRadius: '14px', flexShrink: 0,
              background: `${t.color}15`, border: `1px solid ${t.color}30`,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: '20px',
            }}>
              {t.label.split(' ')[0]}
            </div>
            <div>
              <h1 style={{ fontSize: '20px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>{org.name}</h1>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '3px' }}>
                <span className="badge" style={{ background: `${t.color}12`, color: t.color, border: `1px solid ${t.color}25` }}>{t.label}</span>
                <span style={{ fontSize: '12px', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '3px' }}>
                  <MapPin size={11} /> {location}
                </span>
              </div>
            </div>
          </div>
          <span className={`badge ${org.isActive ? 'badge-success' : 'badge-error'}`}>
            {org.isActive ? '● Actif' : '● Inactif'}
          </span>
        </div>
      </div>

      {/* Tabs */}
      <div style={{ display: 'flex', gap: '4px', marginBottom: '24px', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '12px', padding: '4px', width: 'fit-content' }}>
        {tabs.map(({ key, label, icon: Icon }) => (
          <button key={key} onClick={() => setTab(key as any)}
            style={{
              display: 'flex', alignItems: 'center', gap: '6px',
              padding: '8px 16px', borderRadius: '8px', fontSize: '13px', fontWeight: 500,
              background: tab === key ? 'var(--accent)' : 'transparent',
              color: tab === key ? 'white' : 'var(--text-secondary)',
              border: 'none', cursor: 'pointer', transition: 'all 0.15s',
              boxShadow: tab === key ? '0 2px 8px rgba(124,111,247,0.4)' : 'none',
            }}>
            <Icon size={13} /> {label}
          </button>
        ))}
      </div>

      {/* Overview */}
      {tab === 'overview' && (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
          {[
            { icon: Mail, label: 'Email', value: org.email || '—' },
            { icon: Phone, label: 'Téléphone', value: org.phone || '—' },
            { icon: MapPin, label: 'Adresse', value: branch?.address || '—' },
            { icon: MapPin, label: 'Localisation', value: location },
            { icon: Globe, label: 'Lien Maps', value: org.website || '—', link: org.website },
            { icon: Users, label: 'Staff', value: `${users.length} membre${users.length > 1 ? 's' : ''}` },
          ].map(({ icon: Icon, label, value, link }: any) => (
            <div key={label} className="card-hover" style={{ padding: '18px', borderRadius: '14px', background: 'var(--bg-surface)', border: '1px solid var(--border)', display: 'flex', alignItems: 'center', gap: '14px' }}>
              <div style={{ width: '36px', height: '36px', borderRadius: '10px', background: 'var(--accent-glow)', border: '1px solid rgba(124,111,247,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <Icon size={16} color="var(--accent2)" />
              </div>
              <div style={{ minWidth: 0 }}>
                <p style={{ fontSize: '11px', color: 'var(--text-muted)', fontWeight: 600, letterSpacing: '0.04em', textTransform: 'uppercase' }}>{label}</p>
                {link && link !== '—' ? (
                  <a href={link} target="_blank" rel="noreferrer"
                    style={{ fontSize: '13px', fontWeight: 600, color: 'var(--accent2)', textDecoration: 'none' }}>
                    Ouvrir Maps →
                  </a>
                ) : (
                  <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{value}</p>
                )}
              </div>
            </div>
          ))}
          {org.description && (
            <div style={{ gridColumn: '1 / -1', padding: '18px', borderRadius: '14px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
              <p style={{ fontSize: '11px', color: 'var(--text-muted)', fontWeight: 600, letterSpacing: '0.04em', textTransform: 'uppercase', marginBottom: '8px' }}>Description</p>
              <p style={{ fontSize: '13px', color: 'var(--text-secondary)', lineHeight: '1.6' }}>{org.description}</p>
            </div>
          )}
        </div>
      )}

      {/* Staff */}
      {tab === 'staff' && (
        <div>
          <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: '16px' }}>
            <button onClick={() => setShowStaffModal(true)} className="btn-primary"
              style={{ padding: '10px 16px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '6px' }}>
              <Plus size={14} /> Nouveau membre
            </button>
          </div>
          <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '16px', overflow: 'hidden' }}>
            {!users.length ? (
              <div style={{ padding: '48px', textAlign: 'center' }}>
                <Users size={28} color="var(--text-muted)" style={{ margin: '0 auto 10px' }} />
                <p style={{ color: 'var(--text-secondary)', fontSize: '13px' }}>Aucun membre</p>
              </div>
            ) : users.map((u, i) => {
              const role = roleColors[u.role] || roleColors.CLIENT;
              return (
                <div key={u.id} className="table-row" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '14px 20px', borderBottom: i < users.length - 1 ? '1px solid var(--border)' : 'none' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ width: '34px', height: '34px', borderRadius: '10px', background: `${role.color}15`, border: `1px solid ${role.color}25`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '12px', fontWeight: 700, color: role.color }}>
                      {u.firstName[0]}{u.lastName[0]}
                    </div>
                    <div>
                      <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{u.firstName} {u.lastName}</p>
                      <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '2px' }}>{u.email}</p>
                    </div>
                  </div>
                  <span className="badge" style={{ background: `${role.color}12`, color: role.color, border: `1px solid ${role.color}25` }}>
                    {role.label}
                  </span>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Modal Staff */}
      {showStaffModal && (
        <div className="modal-backdrop" style={{ position: 'fixed', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 100 }}>
          <div style={{ width: '100%', maxWidth: '480px', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '20px', padding: '28px', boxShadow: '0 24px 64px rgba(0,0,0,0.6)', margin: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, color: 'var(--text)' }}>Nouveau membre</h2>
              <button onClick={() => setShowStaffModal(false)} style={{ background: 'var(--bg-surface2)', border: '1px solid var(--border)', borderRadius: '8px', padding: '6px', cursor: 'pointer', color: 'var(--text-secondary)', display: 'flex' }}>
                <X size={15} />
              </button>
            </div>
            {staffError && (
              <div style={{ padding: '10px 14px', borderRadius: '10px', marginBottom: '16px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)', color: 'var(--error)', fontSize: '12px' }}>
                ⚠ {staffError}
              </div>
            )}
            <form onSubmit={handleCreateStaff} style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                <div>
                  <label style={labelStyle}>Prénom *</label>
                  <input style={inputStyle} required value={staffForm.firstName} onChange={e => setStaffForm(p => ({ ...p, firstName: e.target.value }))} placeholder="Mohammed" />
                </div>
                <div>
                  <label style={labelStyle}>Nom *</label>
                  <input style={inputStyle} required value={staffForm.lastName} onChange={e => setStaffForm(p => ({ ...p, lastName: e.target.value }))} placeholder="Benali" />
                </div>
              </div>
              <div>
                <label style={labelStyle}>Email *</label>
                <input style={inputStyle} type="email" required value={staffForm.email} onChange={e => setStaffForm(p => ({ ...p, email: e.target.value }))} placeholder="agent@etablissement.dz" />
              </div>
              <div>
                <label style={labelStyle}>Mot de passe *</label>
                <input style={inputStyle} type="password" required minLength={8} value={staffForm.password} onChange={e => setStaffForm(p => ({ ...p, password: e.target.value }))} placeholder="Minimum 8 caractères" />
              </div>
              <div>
                <label style={labelStyle}>Rôle *</label>
                <select style={inputStyle} value={staffForm.role} onChange={e => setStaffForm(p => ({ ...p, role: e.target.value }))}>
                  <option value="AGENT">Agent</option>
                  <option value="BRANCH_MANAGER">Branch Manager</option>
                  <option value="ORG_ADMIN">Org Admin</option>
                </select>
              </div>
              <div style={{ display: 'flex', gap: '10px', marginTop: '4px' }}>
                <button type="button" onClick={() => setShowStaffModal(false)} className="btn-ghost"
                  style={{ flex: 1, padding: '10px', borderRadius: '10px', fontSize: '13px', fontWeight: 500 }}>
                  Annuler
                </button>
                <button type="submit" disabled={staffLoading} className="btn-primary"
                  style={{ flex: 2, padding: '10px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
                  {staffLoading ? 'Création...' : <><Check size={14} /> Créer</>}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}