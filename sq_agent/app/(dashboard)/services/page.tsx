'use client';
import { useEffect, useState } from 'react';
import { servicesApi, queuesApi, Service, Queue } from '@/lib/api';
import { Plus, Pencil, Trash2, Settings, X, Check, Clock, GitBranch } from 'lucide-react';

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

export default function ServicesPage() {
  const [services, setServices] = useState<Service[]>([]);
  const [queues, setQueues] = useState<Queue[]>([]);
  const [loading, setLoading] = useState(true);

  const [showServiceModal, setShowServiceModal] = useState(false);
  const [editService, setEditService] = useState<Service | null>(null);
  const [serviceForm, setServiceForm] = useState({ name: '', nameAr: '', description: '', avgServiceTime: 10 });
  const [serviceLoading, setServiceLoading] = useState(false);
  const [serviceError, setServiceError] = useState('');

  const [showQueueModal, setShowQueueModal] = useState(false);
  const [queueForm, setQueueForm] = useState({ name: '', prefix: 'A', serviceId: '', avgServiceTime: 10 });
  const [queueLoading, setQueueLoading] = useState(false);
  const [queueError, setQueueError] = useState('');

  const load = async () => {
    setLoading(true);
    try {
      const [s, q] = await Promise.all([servicesApi.list(), queuesApi.list()]);
      setServices(s);
      setQueues(q);
    } finally { setLoading(false); }
  };

  useEffect(() => { load(); }, []);

  const openCreateService = () => {
    setEditService(null);
    setServiceForm({ name: '', nameAr: '', description: '', avgServiceTime: 10 });
    setServiceError('');
    setShowServiceModal(true);
  };

  const openEditService = (s: Service) => {
    setEditService(s);
    setServiceForm({ name: s.name, nameAr: s.nameAr || '', description: s.description || '', avgServiceTime: s.avgServiceTime });
    setServiceError('');
    setShowServiceModal(true);
  };

  const handleSaveService = async (e: React.FormEvent) => {
    e.preventDefault();
    setServiceLoading(true); setServiceError('');
    try {
      if (editService) await servicesApi.update(editService.id, serviceForm);
      else await servicesApi.create(serviceForm);
      setShowServiceModal(false);
      load();
    } catch (err: any) {
      setServiceError(err.response?.data?.message || 'Erreur');
    } finally { setServiceLoading(false); }
  };

  const handleDeleteService = async (id: string) => {
    if (!confirm('Supprimer ce service ?')) return;
    await servicesApi.delete(id);
    load();
  };

  const handleCreateQueue = async (e: React.FormEvent) => {
    e.preventDefault();
    setQueueLoading(true); setQueueError('');
    try {
      await queuesApi.create(queueForm);
      setShowQueueModal(false);
      setQueueForm({ name: '', prefix: 'A', serviceId: '', avgServiceTime: 10 });
      load();
    } catch (err: any) {
      setQueueError(err.response?.data?.message || 'Erreur');
    } finally { setQueueLoading(false); }
  };

  const handleToggleQueue = async (q: Queue) => {
    if (q.status === 'ACTIVE') await queuesApi.pause(q.id);
    else await queuesApi.resume(q.id);
    load();
  };

  return (
    <div className="animate-in">
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '28px' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '4px' }}>
            <Settings size={20} color="var(--accent2)" />
            <h1 style={{ fontSize: '20px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>Services & Files</h1>
          </div>
          <p style={{ fontSize: '13px', color: 'var(--text-secondary)' }}>
            {services.length} service{services.length > 1 ? 's' : ''} • {queues.length} file{queues.length > 1 ? 's' : ''}
          </p>
        </div>
        <div style={{ display: 'flex', gap: '8px' }}>
          <button onClick={() => { setShowQueueModal(true); setQueueError(''); }} className="btn-ghost"
            style={{ padding: '9px 14px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '6px' }}>
            <GitBranch size={14} /> Nouvelle file
          </button>
          <button onClick={openCreateService} className="btn-primary"
            style={{ padding: '9px 14px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '6px' }}>
            <Plus size={14} /> Nouveau service
          </button>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
        <div>
          <h2 style={{ fontSize: '13px', fontWeight: 700, color: 'var(--text-secondary)', marginBottom: '12px', letterSpacing: '0.04em', textTransform: 'uppercase' }}>Services</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            {loading ? [1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '76px', borderRadius: '12px' }} />) :
            services.length === 0 ? (
              <div style={{ padding: '40px', textAlign: 'center', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '14px' }}>
                <Settings size={24} color="var(--text-muted)" style={{ margin: '0 auto 10px' }} />
                <p style={{ color: 'var(--text-secondary)', fontSize: '13px' }}>Aucun service</p>
              </div>
            ) : services.map(s => (
              <div key={s.id} className="card-hover" style={{ padding: '14px 16px', borderRadius: '12px', background: 'var(--bg-surface)', border: '1px solid var(--border)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                  <div style={{ width: '36px', height: '36px', borderRadius: '10px', background: 'var(--accent-glow)', border: '1px solid rgba(124,111,247,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '13px', fontWeight: 700, color: 'var(--accent2)' }}>
                    {s.name[0].toUpperCase()}
                  </div>
                  <div>
                    <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{s.name}</p>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginTop: '2px' }}>
                      <Clock size={10} color="var(--text-muted)" />
                      <p style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{s.avgServiceTime} min/ticket</p>
                    </div>
                  </div>
                </div>
                <div style={{ display: 'flex', gap: '6px' }}>
                  <button onClick={() => openEditService(s)} style={{ padding: '6px 8px', borderRadius: '8px', background: 'var(--bg-surface2)', border: '1px solid var(--border)', color: 'var(--text-secondary)', cursor: 'pointer', display: 'flex' }}>
                    <Pencil size={13} />
                  </button>
                  <button onClick={() => handleDeleteService(s.id)} style={{ padding: '6px 8px', borderRadius: '8px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.15)', color: 'var(--error)', cursor: 'pointer', display: 'flex' }}>
                    <Trash2 size={13} />
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div>
          <h2 style={{ fontSize: '13px', fontWeight: 700, color: 'var(--text-secondary)', marginBottom: '12px', letterSpacing: '0.04em', textTransform: 'uppercase' }}>Files d'attente</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            {loading ? [1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '76px', borderRadius: '12px' }} />) :
            queues.length === 0 ? (
              <div style={{ padding: '40px', textAlign: 'center', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '14px' }}>
                <GitBranch size={24} color="var(--text-muted)" style={{ margin: '0 auto 10px' }} />
                <p style={{ color: 'var(--text-secondary)', fontSize: '13px' }}>Aucune file d'attente</p>
              </div>
            ) : queues.map(q => {
              const isActive = q.status === 'ACTIVE';
              const waitCount = q.tickets?.length ?? 0;
              return (
                <div key={q.id} className="card-hover" style={{ padding: '14px 16px', borderRadius: '12px', background: 'var(--bg-surface)', border: `1px solid ${isActive ? 'rgba(52,211,153,0.2)' : 'var(--border)'}`, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ width: '36px', height: '36px', borderRadius: '10px', background: isActive ? 'rgba(52,211,153,0.1)' : 'rgba(248,113,113,0.1)', border: `1px solid ${isActive ? 'rgba(52,211,153,0.2)' : 'rgba(248,113,113,0.2)'}`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '13px', fontWeight: 700, color: isActive ? 'var(--success)' : 'var(--error)' }}>
                      {q.prefix}
                    </div>
                    <div>
                      <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{q.name}</p>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '2px' }}>
                        <span style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{q.service?.name}</span>
                        <span style={{ fontSize: '11px', color: isActive ? 'var(--success)' : 'var(--error)', fontWeight: 600 }}>{isActive ? '● Actif' : '● Pausé'}</span>
                        <span style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{waitCount} en attente</span>
                      </div>
                    </div>
                  </div>
                  <button onClick={() => handleToggleQueue(q)} style={{ padding: '6px 12px', borderRadius: '8px', fontSize: '12px', fontWeight: 600, background: isActive ? 'rgba(248,113,113,0.08)' : 'rgba(52,211,153,0.08)', border: `1px solid ${isActive ? 'rgba(248,113,113,0.2)' : 'rgba(52,211,153,0.2)'}`, color: isActive ? 'var(--error)' : 'var(--success)', cursor: 'pointer' }}>
                    {isActive ? 'Pause' : 'Reprendre'}
                  </button>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      {showServiceModal && (
        <div className="modal-backdrop" style={{ position: 'fixed', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 100 }}>
          <div style={{ width: '100%', maxWidth: '460px', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '20px', padding: '28px', boxShadow: '0 24px 64px rgba(0,0,0,0.6)', margin: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, color: 'var(--text)' }}>{editService ? 'Modifier le service' : 'Nouveau service'}</h2>
              <button onClick={() => setShowServiceModal(false)} style={{ background: 'var(--bg-surface2)', border: '1px solid var(--border)', borderRadius: '8px', padding: '6px', cursor: 'pointer', color: 'var(--text-secondary)', display: 'flex' }}><X size={15} /></button>
            </div>
            {serviceError && <div style={{ padding: '10px 14px', borderRadius: '10px', marginBottom: '16px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)', color: 'var(--error)', fontSize: '12px' }}>⚠ {serviceError}</div>}
            <form onSubmit={handleSaveService} style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
              <div>
                <label style={labelStyle}>Nom *</label>
                <input style={inputStyle} required value={serviceForm.name} onChange={e => setServiceForm(p => ({ ...p, name: e.target.value }))} placeholder="Ex: Virements..." />
              </div>
              <div>
                <label style={labelStyle}>Nom en arabe</label>
                <input style={{ ...inputStyle, direction: 'rtl' }} value={serviceForm.nameAr} onChange={e => setServiceForm(p => ({ ...p, nameAr: e.target.value }))} placeholder="اسم الخدمة" />
              </div>
              <div>
                <label style={labelStyle}>Description</label>
                <input style={inputStyle} value={serviceForm.description} onChange={e => setServiceForm(p => ({ ...p, description: e.target.value }))} placeholder="Description courte..." />
              </div>
              <div>
                <label style={labelStyle}>Temps moyen (min) *</label>
                <input style={inputStyle} type="number" required min={1} max={120} value={serviceForm.avgServiceTime} onChange={e => setServiceForm(p => ({ ...p, avgServiceTime: +e.target.value }))} />
              </div>
              <div style={{ display: 'flex', gap: '10px', marginTop: '4px' }}>
                <button type="button" onClick={() => setShowServiceModal(false)} className="btn-ghost" style={{ flex: 1, padding: '10px', borderRadius: '10px', fontSize: '13px' }}>Annuler</button>
                <button type="submit" disabled={serviceLoading} className="btn-primary" style={{ flex: 2, padding: '10px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
                  {serviceLoading ? 'Enregistrement...' : <><Check size={14} /> {editService ? 'Modifier' : 'Créer'}</>}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {showQueueModal && (
        <div className="modal-backdrop" style={{ position: 'fixed', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 100 }}>
          <div style={{ width: '100%', maxWidth: '460px', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '20px', padding: '28px', boxShadow: '0 24px 64px rgba(0,0,0,0.6)', margin: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
              <h2 style={{ fontSize: '16px', fontWeight: 700, color: 'var(--text)' }}>Nouvelle file d'attente</h2>
              <button onClick={() => setShowQueueModal(false)} style={{ background: 'var(--bg-surface2)', border: '1px solid var(--border)', borderRadius: '8px', padding: '6px', cursor: 'pointer', color: 'var(--text-secondary)', display: 'flex' }}><X size={15} /></button>
            </div>
            {queueError && <div style={{ padding: '10px 14px', borderRadius: '10px', marginBottom: '16px', background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)', color: 'var(--error)', fontSize: '12px' }}>⚠ {queueError}</div>}
            <form onSubmit={handleCreateQueue} style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
              <div>
                <label style={labelStyle}>Nom de la file *</label>
                <input style={inputStyle} required value={queueForm.name} onChange={e => setQueueForm(p => ({ ...p, name: e.target.value }))} placeholder="File principale..." />
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '12px' }}>
                <div>
                  <label style={labelStyle}>Préfixe *</label>
                  <input style={inputStyle} required maxLength={2} value={queueForm.prefix} onChange={e => setQueueForm(p => ({ ...p, prefix: e.target.value.toUpperCase() }))} placeholder="A" />
                </div>
                <div>
                  <label style={labelStyle}>Service *</label>
                  <select style={inputStyle} required value={queueForm.serviceId} onChange={e => setQueueForm(p => ({ ...p, serviceId: e.target.value }))}>
                    <option value="">Sélectionner...</option>
                    {services.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
                  </select>
                </div>
              </div>
              <div>
                <label style={labelStyle}>Temps moyen (min)</label>
                <input style={inputStyle} type="number" min={1} max={120} value={queueForm.avgServiceTime} onChange={e => setQueueForm(p => ({ ...p, avgServiceTime: +e.target.value }))} />
              </div>
              <div style={{ display: 'flex', gap: '10px', marginTop: '4px' }}>
                <button type="button" onClick={() => setShowQueueModal(false)} className="btn-ghost" style={{ flex: 1, padding: '10px', borderRadius: '10px', fontSize: '13px' }}>Annuler</button>
                <button type="submit" disabled={queueLoading} className="btn-primary" style={{ flex: 2, padding: '10px', borderRadius: '10px', fontSize: '13px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
                  {queueLoading ? 'Création...' : <><Check size={14} /> Créer</>}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}