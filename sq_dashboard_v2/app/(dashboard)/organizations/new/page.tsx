'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { api, locationApi, Wilaya, Commune } from '@/lib/api';
import { ArrowLeft, ArrowRight, Check, Building2, User, MapPin, Link } from 'lucide-react';

const orgTypes = [
  { value: 'bank', label: 'Banque', icon: '🏦', color: '#60a5fa' },
  { value: 'hospital', label: 'Hôpital', icon: '🏥', color: '#f87171' },
  { value: 'administration', label: 'Administration', icon: '🏛️', color: '#a78bfa' },
  { value: 'post', label: 'Poste', icon: '📮', color: '#fbbf24' },
  { value: 'insurance', label: 'Assurance', icon: '🛡️', color: '#34d399' },
  { value: 'telecom', label: 'Télécom', icon: '📡', color: '#fb923c' },
  { value: 'other', label: 'Autre', icon: '🏢', color: '#94a3b8' },
];

const inputStyle = {
  width: '100%', padding: '11px 14px',
  background: 'var(--bg-surface2)', border: '1px solid var(--border)',
  borderRadius: '10px', color: 'var(--text)', fontSize: '13px', outline: 'none',
};

const labelStyle = {
  display: 'block', fontSize: '11px', fontWeight: 700,
  color: 'var(--text-muted)', marginBottom: '6px',
  letterSpacing: '0.06em', textTransform: 'uppercase' as const,
};

export default function NewOrganizationPage() {
  const router = useRouter();
  const [step, setStep] = useState(1);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [createdOrgId, setCreatedOrgId] = useState('');

  const [wilayas, setWilayas] = useState<Wilaya[]>([]);
  const [communes, setCommunes] = useState<Commune[]>([]);

  const [form, setForm] = useState({
    name: '', nameAr: '', type: 'bank',
    wilayaId: '', communeId: '',
    address: '', mapsLink: '',
    phone: '', email: '', description: '',
  });

  const [adminForm, setAdminForm] = useState({
    firstName: '', lastName: '', email: '', password: '',
  });

  useEffect(() => { locationApi.wilayas().then(setWilayas); }, []);
  useEffect(() => {
    if (form.wilayaId) {
      locationApi.communes(+form.wilayaId).then(setCommunes);
      setForm(p => ({ ...p, communeId: '' }));
    }
  }, [form.wilayaId]);

  const set = (k: string, v: string) => setForm(p => ({ ...p, [k]: v }));

  const handleCreateOrg = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true); setError('');
    try {
      const slug = form.name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '') + '-' + Date.now();

      // 1. Créer l'organisation
      const orgRes = await api.post('/admin/organizations', {
        name: form.name, nameAr: form.nameAr,
        slug, type: form.type,
        email: form.email, phone: form.phone,
        description: form.description,
        address: form.address,
        website: form.mapsLink,
      });
      const org = orgRes.data.data;

      // 2. Créer la branch automatiquement
      await api.post('/admin/branches', {
        name: form.name,
        address: form.address,
        phone: form.phone,
        email: form.email,
        wilayaId: +form.wilayaId,
        communeId: form.communeId ? +form.communeId : undefined,
        organizationId: org.id,
        mapsLink: form.mapsLink,
      });

      setCreatedOrgId(org.id);
      setStep(2);
    } catch (err: any) {
      setError(err.response?.data?.message || 'Erreur lors de la création');
    } finally { setLoading(false); }
  };

  const handleCreateAdmin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true); setError('');
    try {
      await api.post('/admin/users', {
        ...adminForm,
        role: 'ORG_ADMIN',
        organizationId: createdOrgId,
      });
      router.push('/organizations');
    } catch (err: any) {
      setError(err.response?.data?.message || 'Erreur');
    } finally { setLoading(false); }
  };

  const steps = [
    { n: 1, icon: Building2, label: 'Établissement' },
    { n: 2, icon: User, label: 'Administrateur' },
  ];

  return (
    <div className="animate-in" style={{ maxWidth: '680px' }}>
      {/* Header */}
      <div style={{ marginBottom: '28px' }}>
        <button onClick={() => step === 1 ? router.push('/organizations') : setStep(1)}
          style={{ display: 'flex', alignItems: 'center', gap: '6px', background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: '12px', marginBottom: '16px', padding: 0 }}>
          <ArrowLeft size={14} /> Retour
        </button>
        <h1 style={{ fontSize: '22px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em', marginBottom: '4px' }}>
          Nouvel établissement
        </h1>
        <p style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>
          Étape {step}/2
        </p>
      </div>

      {/* Steps */}
      <div style={{ display: 'flex', gap: '8px', marginBottom: '28px', alignItems: 'center' }}>
        {steps.map(({ n, icon: Icon, label }, i) => (
          <div key={n} style={{ display: 'flex', alignItems: 'center', gap: '8px', flex: 1 }}>
            <div style={{
              display: 'flex', alignItems: 'center', gap: '8px',
              padding: '8px 14px', borderRadius: '10px', flex: 1,
              background: step >= n ? 'var(--accent-glow)' : 'var(--bg-surface)',
              border: `1px solid ${step >= n ? 'rgba(124,111,247,0.3)' : 'var(--border)'}`,
            }}>
              <div style={{
                width: '26px', height: '26px', borderRadius: '8px', flexShrink: 0,
                background: step >= n ? 'var(--accent)' : 'var(--bg-surface2)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                {step > n ? <Check size={13} color="white" /> : <Icon size={13} color={step >= n ? 'white' : 'var(--text-muted)'} />}
              </div>
              <span style={{ fontSize: '12px', fontWeight: 600, color: step >= n ? 'var(--accent2)' : 'var(--text-muted)' }}>{label}</span>
            </div>
            {i === 0 && <ArrowRight size={14} color="var(--text-muted)" style={{ flexShrink: 0 }} />}
          </div>
        ))}
      </div>

      {error && (
        <div style={{ padding: '12px 14px', borderRadius: '10px', marginBottom: '20px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)', color: 'var(--error)', fontSize: '13px' }}>
          ⚠ {error}
        </div>
      )}

      <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '20px', padding: '28px' }}>

        {/* Step 1 */}
        {step === 1 && (
          <form onSubmit={handleCreateOrg} style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>

            {/* Nom */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px' }}>
              <div>
                <label style={labelStyle}>Nom français *</label>
                <input style={inputStyle} required value={form.name}
                  onChange={e => set('name', e.target.value)}
                  placeholder="BNA Alger Centre" />
              </div>
              <div>
                <label style={labelStyle}>Nom arabe</label>
                <input style={{ ...inputStyle, direction: 'rtl' }} value={form.nameAr}
                  onChange={e => set('nameAr', e.target.value)}
                  placeholder="بنك الجزائر" />
              </div>
            </div>

            {/* Type */}
            <div>
              <label style={labelStyle}>Type d'établissement *</label>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '8px' }}>
                {orgTypes.map(t => (
                  <button key={t.value} type="button"
                    onClick={() => set('type', t.value)}
                    style={{
                      padding: '10px 8px', borderRadius: '10px', fontSize: '12px', fontWeight: 600,
                      background: form.type === t.value ? `${t.color}15` : 'var(--bg-surface2)',
                      border: `1px solid ${form.type === t.value ? t.color + '40' : 'var(--border)'}`,
                      color: form.type === t.value ? t.color : 'var(--text-secondary)',
                      cursor: 'pointer', transition: 'all 0.15s', textAlign: 'center',
                    }}>
                    {t.icon} {t.label}
                  </button>
                ))}
              </div>
            </div>

            {/* Wilaya + Commune */}
            <div>
              <label style={{ ...labelStyle, display: 'flex', alignItems: 'center', gap: '6px' }}>
                <MapPin size={11} /> Localisation *
              </label>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px' }}>
                <select style={inputStyle} required value={form.wilayaId}
                  onChange={e => set('wilayaId', e.target.value)}>
                  <option value="">Sélectionner une wilaya</option>
                  {wilayas.map(w => <option key={w.id} value={w.id}>{w.id} - {w.name}</option>)}
                </select>
                <select style={inputStyle} value={form.communeId}
                  onChange={e => set('communeId', e.target.value)}
                  disabled={!communes.length}>
                  <option value="">Sélectionner une commune</option>
                  {communes.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
                </select>
              </div>
            </div>

            {/* Adresse */}
            <div>
              <label style={labelStyle}>Adresse exacte *</label>
              <input style={inputStyle} required value={form.address}
                onChange={e => set('address', e.target.value)}
                placeholder="Rue Didouche Mourad, Alger Centre" />
            </div>

            {/* Maps Link */}
            <div>
              <label style={{ ...labelStyle, display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Link size={11} /> Lien Google Maps
              </label>
              <input style={inputStyle} value={form.mapsLink}
                onChange={e => set('mapsLink', e.target.value)}
                placeholder="https://maps.google.com/..." />
            </div>

            {/* Contact */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px' }}>
              <div>
                <label style={labelStyle}>Téléphone</label>
                <input style={inputStyle} value={form.phone}
                  onChange={e => set('phone', e.target.value)}
                  placeholder="+213 21 XX XX XX" />
              </div>
              <div>
                <label style={labelStyle}>Email</label>
                <input style={inputStyle} type="email" value={form.email}
                  onChange={e => set('email', e.target.value)}
                  placeholder="contact@etablissement.dz" />
              </div>
            </div>

            {/* Description */}
            <div>
              <label style={labelStyle}>Description</label>
              <textarea style={{ ...inputStyle, minHeight: '80px', resize: 'vertical' } as any}
                value={form.description}
                onChange={e => set('description', e.target.value)}
                placeholder="Description courte de l'établissement..." />
            </div>

            <button type="submit" disabled={loading} className="btn-primary"
              style={{ padding: '13px', borderRadius: '12px', fontSize: '14px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
              {loading ? 'Création...' : <><span>Continuer</span><ArrowRight size={16} /></>}
            </button>
          </form>
        )}

        {/* Step 2 */}
        {step === 2 && (
          <form onSubmit={handleCreateAdmin} style={{ display: 'flex', flexDirection: 'column', gap: '18px' }}>
            <div style={{ padding: '14px 16px', borderRadius: '12px', background: 'rgba(52,211,153,0.08)', border: '1px solid rgba(52,211,153,0.2)', display: 'flex', alignItems: 'center', gap: '10px' }}>
              <Check size={16} color="var(--success)" />
              <div>
                <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--success)' }}>Établissement créé !</p>
                <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '2px' }}>Créez le compte administrateur</p>
              </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px' }}>
              <div>
                <label style={labelStyle}>Prénom *</label>
                <input style={inputStyle} required value={adminForm.firstName}
                  onChange={e => setAdminForm(p => ({ ...p, firstName: e.target.value }))}
                  placeholder="Mohammed" />
              </div>
              <div>
                <label style={labelStyle}>Nom *</label>
                <input style={inputStyle} required value={adminForm.lastName}
                  onChange={e => setAdminForm(p => ({ ...p, lastName: e.target.value }))}
                  placeholder="Benali" />
              </div>
            </div>

            <div>
              <label style={labelStyle}>Email *</label>
              <input style={inputStyle} type="email" required value={adminForm.email}
                onChange={e => setAdminForm(p => ({ ...p, email: e.target.value }))}
                placeholder="admin@etablissement.dz" />
            </div>

            <div>
              <label style={labelStyle}>Mot de passe *</label>
              <input style={inputStyle} type="password" required minLength={8}
                value={adminForm.password}
                onChange={e => setAdminForm(p => ({ ...p, password: e.target.value }))}
                placeholder="Minimum 8 caractères" />
            </div>

            <div style={{ display: 'flex', gap: '10px' }}>
              <button type="button" onClick={() => setStep(1)} className="btn-ghost"
                style={{ flex: 1, padding: '12px', borderRadius: '12px', fontSize: '13px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
                <ArrowLeft size={14} /> Retour
              </button>
              <button type="submit" disabled={loading} className="btn-primary"
                style={{ flex: 2, padding: '12px', borderRadius: '12px', fontSize: '14px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
                {loading ? 'Création...' : <><Check size={15} /><span>Créer le compte admin</span></>}
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}