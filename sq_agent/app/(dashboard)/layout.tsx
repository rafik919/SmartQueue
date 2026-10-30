'use client';
import { useEffect, useState } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import Link from 'next/link';
import { authApi } from '@/lib/api';
import { Ticket, Settings, Clock, BarChart3, LogOut, Zap, ChevronRight } from 'lucide-react';

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const [user, setUser] = useState<any>(null);

  useEffect(() => {
    const u = authApi.getUser();
    if (!u || !u.organizationId) {
      router.push('/login');
    } else {
      setUser(u);
    }
  }, []);

  if (!user) return null;

  const nav = [
    { href: '/tickets', icon: Ticket, label: 'Tickets Live' },
    { href: '/services', icon: Settings, label: 'Services' },
    { href: '/horaires', icon: Clock, label: 'Horaires' },
    { href: '/stats', icon: BarChart3, label: 'Statistiques' },
  ];

  const roleLabel: any = {
    ORG_ADMIN: { label: 'Org Admin', color: '#a78bfa' },
    BRANCH_MANAGER: { label: 'Branch Manager', color: '#60a5fa' },
    AGENT: { label: 'Agent', color: '#34d399' },
  };
  const role = roleLabel[user.role] || { label: user.role, color: '#94a3b8' };

  return (
    <div style={{ display: 'flex', minHeight: '100vh', background: 'var(--bg)' }}>
      <aside style={{
        width: '250px', background: 'var(--bg-surface)',
        borderRight: '1px solid var(--border)',
        display: 'flex', flexDirection: 'column',
        position: 'fixed', height: '100vh', zIndex: 50,
      }}>
        <div style={{ padding: '20px 18px', borderBottom: '1px solid var(--border)' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{
              width: '36px', height: '36px', borderRadius: '10px',
              background: 'linear-gradient(135deg, var(--accent), #6457e8)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 12px rgba(124,111,247,0.4)',
            }}>
              <Zap size={16} color="white" fill="white" />
            </div>
            <div>
              <p style={{ fontWeight: 700, fontSize: '14px', color: 'var(--text)' }}>SmartQueue</p>
              <p style={{ fontSize: '10px', color: 'var(--text-muted)' }}>Espace Agent</p>
            </div>
          </div>
        </div>

        <nav style={{ flex: 1, padding: '10px 8px', display: 'flex', flexDirection: 'column', gap: '2px' }}>
          <p style={{ fontSize: '10px', fontWeight: 700, color: 'var(--text-muted)', letterSpacing: '0.08em', padding: '8px 10px 4px', textTransform: 'uppercase' }}>Menu</p>
          {nav.map(({ href, icon: Icon, label }) => {
            const active = pathname === href;
            return (
              <Link key={href} href={href} style={{ textDecoration: 'none' }}>
                <div style={{
                  display: 'flex', alignItems: 'center', gap: '10px',
                  padding: '9px 10px', borderRadius: '10px',
                  background: active ? 'var(--accent-glow)' : 'transparent',
                  border: active ? '1px solid rgba(124,111,247,0.2)' : '1px solid transparent',
                  transition: 'all 0.15s', cursor: 'pointer',
                }}>
                  <div style={{
                    width: '30px', height: '30px', borderRadius: '8px',
                    background: active ? 'rgba(124,111,247,0.2)' : 'var(--bg-surface2)',
                    display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
                  }}>
                    <Icon size={14} color={active ? 'var(--accent2)' : 'var(--text-secondary)'} />
                  </div>
                  <span style={{ fontSize: '13px', fontWeight: active ? 600 : 500, color: active ? 'var(--accent2)' : 'var(--text-secondary)' }}>{label}</span>
                  {active && <ChevronRight size={12} color="var(--accent2)" style={{ marginLeft: 'auto' }} />}
                </div>
              </Link>
            );
          })}
        </nav>

        <div style={{ padding: '10px 8px', borderTop: '1px solid var(--border)' }}>
          <div style={{ padding: '10px', borderRadius: '10px', background: 'var(--bg-surface2)', border: '1px solid var(--border)', marginBottom: '6px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <div style={{
                width: '32px', height: '32px', borderRadius: '8px', flexShrink: 0,
                background: `${role.color}20`, border: `1px solid ${role.color}40`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: '11px', fontWeight: 700, color: role.color,
              }}>
                {user.firstName?.[0]}{user.lastName?.[0]}
              </div>
              <div style={{ minWidth: 0 }}>
                <p style={{ fontSize: '12px', fontWeight: 600, color: 'var(--text)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  {user.firstName} {user.lastName}
                </p>
                <p style={{ fontSize: '10px', color: role.color, fontWeight: 600 }}>{role.label}</p>
              </div>
            </div>
          </div>
          <button onClick={() => { authApi.logout(); router.push('/login'); }}
            style={{
              width: '100%', padding: '8px 10px', borderRadius: '8px',
              background: 'rgba(248,113,113,0.06)', border: '1px solid rgba(248,113,113,0.15)',
              color: 'var(--error)', fontSize: '12px', fontWeight: 500,
              cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px',
            }}>
            <LogOut size={13} /> Se déconnecter
          </button>
        </div>
      </aside>

      <main style={{ marginLeft: '250px', flex: 1, minHeight: '100vh', padding: '28px 32px' }}>
        {children}
      </main>
    </div>
  );
}