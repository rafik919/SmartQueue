'use client';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { authApi } from '@/lib/api';
import { Zap, Mail, Lock, ArrowRight } from 'lucide-react';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    try {
      const user = await authApi.login(email, password);
      if (user.role !== 'SUPER_ADMIN') {
        authApi.logout();
        setError('Accès réservé aux Super Admins');
        return;
      }
      router.push('/organizations');
    } catch {
      setError('Email ou mot de passe incorrect');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{
      minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center',
      background: 'var(--bg)', position: 'relative', overflow: 'hidden',
    }}>
      {/* Background glow */}
      <div style={{
        position: 'absolute', width: '600px', height: '600px', borderRadius: '50%',
        background: 'radial-gradient(circle, rgba(124,111,247,0.08) 0%, transparent 70%)',
        top: '50%', left: '50%', transform: 'translate(-50%, -50%)',
        pointerEvents: 'none',
      }} />

      <div style={{ width: '100%', maxWidth: '420px', padding: '0 20px', position: 'relative' }}>

        {/* Card */}
        <div style={{
          background: 'var(--bg-surface)', border: '1px solid var(--border)',
          borderRadius: '20px', padding: '40px', boxShadow: '0 24px 64px rgba(0,0,0,0.5)',
        }}>
          {/* Logo */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '32px' }}>
            <div style={{
              width: '44px', height: '44px', borderRadius: '14px',
              background: 'linear-gradient(135deg, var(--accent), #6457e8)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 20px rgba(124,111,247,0.4)',
            }}>
              <Zap size={20} color="white" fill="white" />
            </div>
            <div>
              <p style={{ fontWeight: 700, fontSize: '18px', color: 'var(--text)', letterSpacing: '-0.02em' }}>SmartQueue</p>
              <p style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Admin Console</p>
            </div>
          </div>

          <h1 style={{ fontSize: '22px', fontWeight: 700, color: 'var(--text)', marginBottom: '6px', letterSpacing: '-0.02em' }}>
            Connexion
          </h1>
          <p style={{ fontSize: '13px', color: 'var(--text-secondary)', marginBottom: '28px' }}>
            Accès réservé aux administrateurs
          </p>

          {error && (
            <div style={{
              padding: '12px 14px', borderRadius: '10px', marginBottom: '20px',
              background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)',
              color: 'var(--error)', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '8px',
            }}>
              ⚠ {error}
            </div>
          )}

          <form onSubmit={handleSubmit}>
            {/* Email */}
            <div style={{ marginBottom: '16px' }}>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 600, color: 'var(--text-secondary)', marginBottom: '8px', letterSpacing: '0.02em' }}>
                EMAIL
              </label>
              <div style={{ position: 'relative' }}>
                <Mail size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)' }} />
                <input type="email" required value={email} onChange={e => setEmail(e.target.value)}
                  placeholder="admin@smartqueue.app"
                  style={{
                    width: '100%', padding: '12px 14px 12px 40px',
                    background: 'var(--bg-surface2)', border: '1px solid var(--border)',
                    borderRadius: '10px', color: 'var(--text)', fontSize: '14px', outline: 'none',
                    transition: 'border-color 0.2s',
                  }} />
              </div>
            </div>

            {/* Password */}
            <div style={{ marginBottom: '24px' }}>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 600, color: 'var(--text-secondary)', marginBottom: '8px', letterSpacing: '0.02em' }}>
                MOT DE PASSE
              </label>
              <div style={{ position: 'relative' }}>
                <Lock size={15} color="var(--text-muted)" style={{ position: 'absolute', left: '14px', top: '50%', transform: 'translateY(-50%)' }} />
                <input type="password" required value={password} onChange={e => setPassword(e.target.value)}
                  placeholder="••••••••"
                  style={{
                    width: '100%', padding: '12px 14px 12px 40px',
                    background: 'var(--bg-surface2)', border: '1px solid var(--border)',
                    borderRadius: '10px', color: 'var(--text)', fontSize: '14px', outline: 'none',
                    transition: 'border-color 0.2s',
                  }} />
              </div>
            </div>

            <button type="submit" disabled={loading} className="btn-primary"
              style={{
                width: '100%', padding: '13px',
                borderRadius: '12px', fontSize: '14px',
                display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px',
              }}>
              {loading ? (
                <span style={{ opacity: 0.8 }}>Connexion en cours...</span>
              ) : (
                <><span>Se connecter</span><ArrowRight size={16} /></>
              )}
            </button>
          </form>
        </div>

        <p style={{ textAlign: 'center', marginTop: '20px', fontSize: '12px', color: 'var(--text-muted)' }}>
          SmartQueue © 2026 — Tous droits réservés
        </p>
      </div>
    </div>
  );
}