import axios from 'axios';

const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://192.168.1.34:3000/api/v1';

export const api = axios.create({
  baseURL: API_URL,
  headers: { 'Content-Type': 'application/json' },
});

api.interceptors.request.use((config) => {
  if (typeof window !== 'undefined') {
    const token = localStorage.getItem('agent_access_token');
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
  organizationId?: string;
  organization?: Organization;
}

export interface Organization {
  id: string;
  name: string;
  type: string;
  email?: string;
  phone?: string;
  isActive: boolean;
  branches: Branch[];
}

export interface Branch {
  id: string;
  name: string;
  address: string;
  phone?: string;
  isActive: boolean;
  wilaya?: { id: number; name: string };
  commune?: { id: number; name: string };
  openingHours?: OpeningHours[];
  queues?: Queue[];
}

export interface OpeningHours {
  id?: string;
  dayOfWeek: number;
  openTime: string;
  closeTime: string;
  isClosed: boolean;
}

export interface Service {
  id: string;
  name: string;
  nameAr?: string;
  description?: string;
  avgServiceTime: number;
  isActive: boolean;
}

export interface Queue {
  id: string;
  name: string;
  prefix: string;
  status: string;
  avgServiceTime: number;
  tickets?: any[];
  service: Service;
}

export interface Ticket {
  id: string;
  code: string;
  number: number;
  status: string;
  position?: number;
  estimatedWaitMin?: number;
  createdAt: string;
  calledAt?: string;
  customer: { firstName: string; lastName: string; phone?: string };
  queue: { name: string; prefix: string };
  service: { name: string };
}

export interface Stats {
  totalTickets: number;
  completedTickets: number;
  waitingTickets: number;
  avgWaitMin: number;
}

export const authApi = {
  login: async (email: string, password: string) => {
    const res = await api.post('/auth/login', { email, password });
    const { user, tokens } = res.data.data;
    localStorage.setItem('agent_access_token', tokens.accessToken);
    localStorage.setItem('agent_refresh_token', tokens.refreshToken);
    localStorage.setItem('agent_user', JSON.stringify(user));
    return user as User;
  },
  logout: () => {
    localStorage.removeItem('agent_access_token');
    localStorage.removeItem('agent_refresh_token');
    localStorage.removeItem('agent_user');
  },
  getUser: (): User | null => {
    if (typeof window === 'undefined') return null;
    const u = localStorage.getItem('agent_user');
    return u ? JSON.parse(u) : null;
  },
};

export const meApi = {
  get: async () => {
    const res = await api.get('/admin/agent/me');
    return res.data.data as User;
  },
};

export const ticketsApi = {
  list: async (status?: string) => {
    const res = await api.get('/admin/agent/tickets', { params: { status } });
    return res.data.data as Ticket[];
  },
  callNext: async (queueId: string) => {
    const res = await api.post('/admin/agent/tickets/call-next', { queueId });
    return res.data.data as Ticket;
  },
  complete: async (ticketId: string) => {
    await api.post(`/tickets/${ticketId}/complete`);
  },
};

export const servicesApi = {
  list: async () => {
    const res = await api.get('/admin/agent/services');
    return res.data.data as Service[];
  },
  create: async (data: Partial<Service>) => {
    const res = await api.post('/admin/agent/services', data);
    return res.data.data as Service;
  },
  update: async (id: string, data: Partial<Service>) => {
    const res = await api.patch(`/admin/agent/services/${id}`, data);
    return res.data.data as Service;
  },
  delete: async (id: string) => {
    await api.delete(`/admin/agent/services/${id}`);
  },
};

export const queuesApi = {
  list: async () => {
    const res = await api.get('/admin/agent/queues');
    return res.data.data as Queue[];
  },
  create: async (data: any) => {
    const res = await api.post('/admin/agent/queues', data);
    return res.data.data as Queue;
  },
  pause: async (id: string) => {
    await api.post(`/queues/${id}/pause`);
  },
  resume: async (id: string) => {
    await api.post(`/queues/${id}/resume`);
  },
};

export const hoursApi = {
  update: async (branchId: string, hours: OpeningHours[]) => {
    const res = await api.patch(`/admin/agent/branches/${branchId}/hours`, { hours });
    return res.data.data;
  },
};

export const statsApi = {
  get: async () => {
    const res = await api.get('/admin/agent/stats');
    return res.data.data as Stats;
  },
};