import axios from 'axios';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://192.168.1.36:3000/api/v1';

export const api = axios.create({
  baseURL: API_URL,
  headers: { 'Content-Type': 'application/json' },
});

api.interceptors.request.use((config) => {
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('sq_access_token');
    if (token) config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

api.interceptors.response.use(
  (res) => res,
  (err) => {
    if (err.response?.status === 401 && typeof window !== 'undefined') {
      localStorage.clear();
      window.location.href = '/login';
    }
    return Promise.reject(err);
  }
);

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  isActive: boolean;
  createdAt: string;
  organizationId?: string;
}

export interface Organization {
  id: string;
  name: string;
  nameAr?: string;
  slug: string;
  type: string;
  logoUrl?: string;
  email?: string;
  phone?: string;
  address?: string;
  website?: string;
  description?: string;
  isActive: boolean;
  isVerified: boolean;
  branches: Branch[];
  createdAt: string;
}

export interface Branch {
  id: string;
  name: string;
  nameAr?: string;
  address: string;
  addressAr?: string;
  phone?: string;
  email?: string;
  latitude?: number;
  longitude?: number;
  isActive: boolean;
  wilayaId: number;
  communeId?: number;
  wilaya?: { id: number; name: string; code: string };
  commune?: { id: number; name: string };
}

export interface Wilaya {
  id: number;
  name: string;
  nameAr: string;
  code: string;
}

export interface Commune {
  id: number;
  name: string;
  wilayaId: number;
}

export interface Stats {
  totalOrgs: number;
  totalBranches: number;
  totalTickets: number;
  totalAgents: number;
  ticketsToday: number;
}

export const authApi = {
  login: async (email: string, password: string) => {
    const res = await api.post('/auth/login', { email, password });
    const { user, tokens } = res.data.data;
    localStorage.setItem('sq_access_token', tokens.accessToken);
    localStorage.setItem('sq_refresh_token', tokens.refreshToken);
    localStorage.setItem('sq_user', JSON.stringify(user));
    return user as User;
  },
  logout: () => {
    localStorage.removeItem('sq_access_token');
    localStorage.removeItem('sq_refresh_token');
    localStorage.removeItem('sq_user');
  },
  getUser: (): User | null => {
    if (typeof window === 'undefined') return null;
    const u = localStorage.getItem('sq_user');
    return u ? JSON.parse(u) : null;
  },
};

export const orgsApi = {
  list: async (params?: {
    q?: string; type?: string; page?: number;
    wilayaId?: number; communeId?: number;
  }) => {
    const res = await api.get('/organizations', { params: { ...params, limit: 50 } });
    return res.data.data as { items: Organization[]; total: number };
  },
  get: async (id: string) => {
    const res = await api.get(`/organizations/${id}`);
    return res.data.data as Organization;
  },
  create: async (data: Partial<Organization>) => {
    const res = await api.post('/admin/organizations', data);
    return res.data.data as Organization;
  },
  update: async (id: string, data: Partial<Organization>) => {
    const res = await api.patch(`/admin/organizations/${id}`, data);
    return res.data.data as Organization;
  },
  delete: async (id: string) => {
    await api.delete(`/admin/organizations/${id}`);
  },
};

export const branchesApi = {
  create: async (data: Partial<Branch> & { organizationId: string }) => {
    const res = await api.post('/admin/branches', data);
    return res.data.data as Branch;
  },
  update: async (id: string, data: Partial<Branch>) => {
    const res = await api.patch(`/admin/branches/${id}`, data);
    return res.data.data as Branch;
  },
  delete: async (id: string) => {
    await api.delete(`/admin/branches/${id}`);
  },
};

export const locationApi = {
  wilayas: async () => {
    const res = await api.get('/organizations/wilayas');
    return res.data.data as Wilaya[];
  },
  communes: async (wilayaId: number) => {
    const res = await api.get('/organizations/communes', { params: { wilayaId } });
    return res.data.data as Commune[];
  },
};

export const usersApi = {
  createUser: async (data: {
    email: string; password: string;
    firstName: string; lastName: string;
    role: string; organizationId: string;
  }) => {
    const res = await api.post('/admin/users', data);
    return res.data.data as User;
  },
  listByOrg: async (orgId: string) => {
    const res = await api.get(`/admin/organizations/${orgId}/users`);
    return res.data.data as User[];
  },
};

export const statsApi = {
  global: async () => {
    const res = await api.get('/admin/stats');
    return res.data.data as Stats;
  },
};