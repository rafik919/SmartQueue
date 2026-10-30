'use client';
import { useEffect, useState, useCallback } from 'react';
import { ticketsApi, queuesApi, statsApi, Ticket, Queue, Stats } from '@/lib/api';
import { Ticket as TicketIcon, Users, CheckCircle, Clock, RefreshCw, PhoneCall, Check } from 'lucide-react';

const statusColors: any = {
  WAITING: { color: '#fbbf24', label: 'En attente', bg: 'rgba(251,191,36,0.1)' },
  CALLED: { color: '#60a5fa', label: 'Appelé', bg: 'rgba(96,165,250,0.1)' },
  IN_SERVICE: { color: '#a78bfa', label: 'En service', bg: 'rgba(167,139,250,0.1)' },
  COMPLETED: { color: '#34d399', label: 'Terminé', bg: 'rgba(52,211,153,0.1)' },
  CANCELLED: { color: '#f87171', label: 'Annulé', bg: 'rgba(248,113,113,0.1)' },
};

export default function TicketsPage() {
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [queues, setQueues] = useState<Queue[]>([]);
  const [stats, setStats] = useState<Stats | null>(null);
  const [loading, setLoading] = useState(true);
  const [calling, setCalling] = useState<string | null>(null);
  const [completing, setCompleting] = useState<string | null>(null);
  const [lastUpdate, setLastUpdate] = useState<Date>(new Date());

  const load = useCallback(async () => {
    try {
      const [t, q, s] = await Promise.all([
        ticketsApi.list(),
        queuesApi.list(),
        statsApi.get(),
      ]);
      setTickets(t);
      setQueues(q);
      setStats(s);
      setLastUpdate(new Date());
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    load();
    const interval = setInterval(load, 10000);
    return () => clearInterval(interval);
  }, [load]);

  const handleCallNext = async (queueId: string) => {
    setCalling(queueId);
    try { await ticketsApi.callNext(queueId); await load(); }
    finally { setCalling(null); }
  };

  const handleComplete = async (ticketId: string) => {
    setCompleting(ticketId);
    try { await ticketsApi.complete(ticketId); await load(); }
    finally { setCompleting(null); }
  };

  const waiting = tickets.filter(t => t.status === 'WAITING');
  const called = tickets.filter(t => t.status === 'CALLED' || t.status === 'IN_SERVICE');

  return (
    <div className="animate-in">
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '4px' }}>
            <div className="live-dot" />
            <h1 style={{ fontSize: '20px', fontWeight: 700, color: 'var(--text)', letterSpacing: '-0.02em' }}>Tickets en temps réel</h1>
          </div>
          <p style={{ fontSize: '12px', color: 'var(--text-muted)' }}>
            Mis à jour à {lastUpdate.toLocaleTimeString('fr-FR')} — auto-refresh 10s
          </p>
        </div>
        <button onClick={load} className="btn-ghost"
          style={{ padding: '8px 14px', borderRadius: '10px', fontSize: '12px', display: 'flex', alignItems: 'center', gap: '6px' }}>
          <RefreshCw size={13} /> Actualiser
        </button>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '12px', marginBottom: '24px' }}>
        {[
          { label: "Total aujourd'hui", value: stats?.totalTickets ?? 0, icon: TicketIcon, color: '#7c6ff7' },
          { label: 'En attente', value: stats?.waitingTickets ?? 0, icon: Users, color: '#fbbf24' },
          { label: 'Complétés', value: stats?.completedTickets ?? 0, icon: CheckCircle, color: '#34d399' },
          { label: 'Temps moy.', value: `${stats?.avgWaitMin ?? 0} min`, icon: Clock, color: '#60a5fa' },
        ].map(({ label, value, icon: Icon, color }) => (
          <div key={label} className="card-hover" style={{ padding: '16px', borderRadius: '14px', background: 'var(--bg-surface)', border: '1px solid var(--border)' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '10px' }}>
              <p style={{ fontSize: '11px', color: 'var(--text-muted)', fontWeight: 600, letterSpacing: '0.04em', textTransform: 'uppercase' }}>{label}</p>
              <div style={{ width: '30px', height: '30px', borderRadius: '8px', background: `${color}15`, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon size={14} color={color} />
              </div>
            </div>
            <p style={{ fontSize: '26px', fontWeight: 700, color: 'var(--text)' }}>{loading ? '—' : value}</p>
          </div>
        ))}
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
        <div>
          <h2 style={{ fontSize: '14px', fontWeight: 700, color: 'var(--text)', marginBottom: '12px', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Users size={15} color="var(--accent2)" /> Files d'attente
          </h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            {loading ? [1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '72px', borderRadius: '12px' }} />) :
            queues.length === 0 ? (
              <div style={{ padding: '32px', textAlign: 'center', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '14px' }}>
                <p style={{ color: 'var(--text-muted)', fontSize: '13px' }}>Aucune file d'attente</p>
              </div>
            ) : queues.map(q => {
              const waitCount = q.tickets?.length ?? 0;
              const isActive = q.status === 'ACTIVE';
              return (
                <div key={q.id} style={{ padding: '14px 16px', borderRadius: '12px', background: 'var(--bg-surface)', border: '1px solid var(--border)', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{
                      width: '38px', height: '38px', borderRadius: '10px',
                      background: isActive ? 'rgba(52,211,153,0.1)' : 'rgba(248,113,113,0.1)',
                      border: `1px solid ${isActive ? 'rgba(52,211,153,0.2)' : 'rgba(248,113,113,0.2)'}`,
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                      fontSize: '14px', fontWeight: 700, color: isActive ? 'var(--success)' : 'var(--error)',
                    }}>{q.prefix}</div>
                    <div>
                      <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{q.name}</p>
                      <p style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{waitCount} en attente • {q.avgServiceTime} min/ticket</p>
                    </div>
                  </div>
                  <button onClick={() => handleCallNext(q.id)} disabled={calling === q.id || waitCount === 0} className="btn-primary"
                    style={{ padding: '7px 12px', borderRadius: '8px', fontSize: '12px', display: 'flex', alignItems: 'center', gap: '5px', opacity: waitCount === 0 ? 0.4 : 1 }}>
                    <PhoneCall size={12} />{calling === q.id ? '...' : 'Appeler'}
                  </button>
                </div>
              );
            })}
          </div>
        </div>

        <div>
          <h2 style={{ fontSize: '14px', fontWeight: 700, color: 'var(--text)', marginBottom: '12px', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <PhoneCall size={15} color="var(--accent2)" /> Tickets appelés
          </h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            {loading ? [1,2].map(i => <div key={i} className="skeleton" style={{ height: '80px', borderRadius: '12px' }} />) :
            called.length === 0 ? (
              <div style={{ padding: '32px', textAlign: 'center', background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '14px' }}>
                <p style={{ color: 'var(--text-muted)', fontSize: '13px' }}>Aucun ticket en cours</p>
              </div>
            ) : called.map(t => {
              const s = statusColors[t.status] || statusColors.WAITING;
              return (
                <div key={t.id} style={{ padding: '14px 16px', borderRadius: '12px', background: 'var(--bg-surface)', border: `1px solid ${s.color}30`, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ width: '38px', height: '38px', borderRadius: '10px', background: s.bg, border: `1px solid ${s.color}30`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '13px', fontWeight: 700, color: s.color }}>
                      {t.queue.prefix}{t.number}
                    </div>
                    <div>
                      <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)' }}>{t.customer.firstName} {t.customer.lastName}</p>
                      <p style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{t.service.name} • <span style={{ color: s.color }}>{s.label}</span></p>
                    </div>
                  </div>
                  <button onClick={() => handleComplete(t.id)} disabled={completing === t.id} className="btn-success"
                    style={{ padding: '7px 12px', borderRadius: '8px', fontSize: '12px', display: 'flex', alignItems: 'center', gap: '5px' }}>
                    <Check size={12} />{completing === t.id ? '...' : 'Terminer'}
                  </button>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      <div style={{ marginTop: '20px' }}>
        <h2 style={{ fontSize: '14px', fontWeight: 700, color: 'var(--text)', marginBottom: '12px', display: 'flex', alignItems: 'center', gap: '8px' }}>
          <Clock size={15} color="var(--warning)" /> File d'attente ({waiting.length})
        </h2>
        <div style={{ background: 'var(--bg-surface)', border: '1px solid var(--border)', borderRadius: '14px', overflow: 'hidden' }}>
          {loading ? (
            <div style={{ padding: '16px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
              {[1,2,3].map(i => <div key={i} className="skeleton" style={{ height: '44px' }} />)}
            </div>
          ) : waiting.length === 0 ? (
            <div style={{ padding: '32px', textAlign: 'center' }}>
              <p style={{ color: 'var(--text-muted)', fontSize: '13px' }}>Aucun ticket en attente 🎉</p>
            </div>
          ) : (
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '1px', background: 'var(--border)' }}>
              {waiting.map(t => (
                <div key={t.id} style={{ padding: '12px 16px', background: 'var(--bg-surface)', display: 'flex', alignItems: 'center', gap: '10px' }}>
                  <span style={{ width: '34px', height: '34px', borderRadius: '8px', flexShrink: 0, background: 'rgba(251,191,36,0.1)', border: '1px solid rgba(251,191,36,0.2)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '12px', fontWeight: 700, color: 'var(--warning)' }}>
                    {t.queue.prefix}{t.number}
                  </span>
                  <div>
                    <p style={{ fontSize: '12px', fontWeight: 600, color: 'var(--text)' }}>{t.customer.firstName} {t.customer.lastName}</p>
                    <p style={{ fontSize: '10px', color: 'var(--text-muted)' }}>{t.service.name}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}