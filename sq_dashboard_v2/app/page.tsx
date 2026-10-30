'use client';
import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { authApi } from '@/lib/api';

export default function RootPage() {
  const router = useRouter();
  useEffect(() => {
    const user = authApi.getUser();
    if (user?.role === 'SUPER_ADMIN') {
      router.push('/organizations');
    } else {
      router.push('/login');
    }
  }, []);
  return null;
}