'use client';
import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { authApi } from '@/lib/api';

export default function RootPage() {
  const router = useRouter();
  useEffect(() => {
    const user = authApi.getUser();
    if (user && user.organizationId) {
      router.push('/tickets');
    } else {
      router.push('/login');
    }
  }, []);
  return <div style={{ minHeight: '100vh', background: 'var(--bg)' }} />;
}