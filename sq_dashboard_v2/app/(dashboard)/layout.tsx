'use client';
import { useEffect, useState } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import Link from 'next/link';
import { authApi } from '@/lib/api';
import { LayoutDashboard, Building2, BarChart3, LogOut, Zap, ChevronRight } from 'lucide-react';

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const [user, setUser] = useState<any>(null);

  useEffect(() => {
    const u = authApi.getUser();
    if (!u || u.role !== 'SUPER_ADMIN') router.push('/login');
    else setUser(u);
  }, []);

  if (!user) return null;

  const nav = [
    { href: '/', icon: LayoutDashboard, label: 'Vue générale', desc: 'KPIs & aperçu' },
    { href: '/organizations', icon: Building2, label: 'Organisations', desc: 'Gérer les établissements' },
    { href: '/stats', icon: BarChart3, label: 'Statistiques', desc: 'Analytics & charts' },
  ];

  return (
    <div className="flex min-h-screen" style={{ background: 'var(--bg)' }}>

      {/* Sidebar */}
      <aside style={{
        width: '260px', background: 'var(--bg-surface)',
        borderRight: '1px solid var(--border)',
        display: 'flex', flexDirection: 'column',
        position: 'fixed', height: '100vh', zIndex: 50,
      }}>

        {/* Logo */}
        <div style={{ padding: '24px 20px', borderBottom: '1px solid var(--border)' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            <div style={{
              width: '38px', height: '38px', borderRadius: '12px',
              background: 'linear-gradient(135deg, var(--accent), #6457e8)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 16px rgba(124,111,247,0.4)',
            }}>
              <Zap size={18} color="white" fill="white" />
            </div>
            <div>
              <p style={{ fontWeight: 700, fontSize: '15px', color: 'var(--text)', letterSpacing: '-0.02em' }}>SmartQueue</p>
              <p style={{ fontSize: '11px', color: 'var(--text-muted)', fontWeight: 500 }}>Admin Console</p>
            </div>
          </div>
        </div>

        {/* Nav */}
        <nav style={{ flex: 1, padding: '12px 10px', display: 'flex', flexDirection: 'column', gap: '2px' }}>
          <p style={{ fontSize: '10px', fontWeight: 700, color: 'var(--text-muted)', letterSpacing: '0.08em', padding: '8px 10px 4px', textTransform: 'uppercase' }}>Navigation</p>
          {nav.map(({ href, icon: Icon, label }) => {
            const active = pathname === href || (href !== '/' && pathname.startsWith(href));
            return (
              <Link key={href} href={href} style={{ textDecoration: 'none' }}>
                <div style={{
                  display: 'flex', alignItems: 'center', gap: '10px',
                  padding: '10px 12px', borderRadius: '10px',
                  background: active ? 'var(--accent-glow)' : 'transparent',
                  border: active ? '1px solid rgba(124,111,247,0.2)' : '1px solid transparent',
                  transition: 'all 0.15s',
                  cursor: 'pointer',
                }}>
                  <div style={{
                    width: '32px', height: '32px', borderRadius: '8px',
                    background: active ? 'rgba(124,111,247,0.2)' : 'var(--bg-surface2)',
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    flexShrink: 0,
                  }}>
                    <Icon size={15} color={active ? 'var(--accent2)' : 'var(--text-secondary)'} />
                  </div>
                  <span style={{
                    fontSize: '13px', fontWeight: active ? 600 : 500,
                    color: active ? 'var(--accent2)' : 'var(--text-secondary)',
                  }}>{label}</span>
                  {active && <ChevronRight size={13} color="var(--accent2)" style={{ marginLeft: 'auto' }} />}
                </div>
              </Link>
            );
          })}
        </nav>

        {/* User */}
        <div style={{ padding: '12px 10px', borderTop: '1px solid var(--border)' }}>
          <div style={{
            padding: '12px', borderRadius: '12px',
            background: 'var(--bg-surface2)', border: '1px solid var(--border)',
            marginBottom: '8px',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <div style={{
                width: '34px', height: '34px', borderRadius: '10px', flexShrink: 0,
                background: 'linear-gradient(135deg, var(--accent), #6457e8)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: '12px', fontWeight: 700, color: 'white',
              }}>
                {user.firstName?.[0]}{user.lastName?.[0]}
              </div>
              <div style={{ minWidth: 0 }}>
                <p style={{ fontSize: '13px', fontWeight: 600, color: 'var(--text)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  {user.firstName} {user.lastName}
                </p>
                <p style={{ fontSize: '11px', color: 'var(--accent2)', fontWeight: 500 }}>Super Admin</p>
              </div>
            </div>
          </div>
          <button onClick={() => { authApi.logout(); router.push('/login'); }}
            style={{
              width: '100%', padding: '9px 12px', borderRadius: '10px',
              background: 'rgba(248,113,113,0.06)', border: '1px solid rgba(248,113,113,0.15)',
              color: 'var(--error)', fontSize: '13px', fontWeight: 500,
              cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px',
              transition: 'all 0.15s',
            }}>
            <LogOut size={14} /> Se déconnecter
          </button>
        </div>
      </aside>

      {/* Main */}
      <main style={{ marginLeft: '260px', flex: 1, minHeight: '100vh', padding: '32px 36px' }}>
        {children}
      </main>
    </div>
  );
}