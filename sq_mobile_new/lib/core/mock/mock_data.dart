// lib/core/mock/mock_data.dart
// Données de démonstration réalistes pour SmartQueue

import 'package:smartqueue/features/auth/data/auth_models.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';

// ── Utilisateur demo ──────────────────────────────────────────────────────────
final mockUser = UserModel(
  id: 'demo-user-001',
  email: 'demo@smartqueue.app',
  firstName: 'Sara',
  lastName: 'Benali',
  role: 'CLIENT',
  phone: '+213 555 001 122',
  preferredLanguage: 'fr',
);

// ── Organisations ─────────────────────────────────────────────────────────────
final mockOrganizations = [
  OrganizationCard(
    id: 'org-001',
    name: 'Banque Nationale d\'Algérie',
    type: 'bank',
    city: 'Alger',
    slug: 'bna-alger',
    branches: [
      BranchSummary(id: 'br-001', name: 'Agence Didouche Mourad', city: 'Alger', openNow: true),
      BranchSummary(id: 'br-002', name: 'Agence Hussein Dey',    city: 'Alger', openNow: true),
      BranchSummary(id: 'br-003', name: 'Agence Kouba',          city: 'Alger', openNow: false),
    ],
  ),
  OrganizationCard(
    id: 'org-002',
    name: 'CPA — Crédit Populaire d\'Algérie',
    type: 'bank',
    city: 'Alger',
    slug: 'cpa-alger',
    branches: [
      BranchSummary(id: 'br-004', name: 'Agence Centre',    city: 'Alger', openNow: true),
      BranchSummary(id: 'br-005', name: 'Agence Bab Ezzouar', city: 'Alger', openNow: true),
    ],
  ),
  OrganizationCard(
    id: 'org-003',
    name: 'CHU Mustapha Pacha',
    type: 'hospital',
    city: 'Alger',
    slug: 'chu-mustapha',
    branches: [
      BranchSummary(id: 'br-006', name: 'Urgences',       city: 'Alger', openNow: true),
      BranchSummary(id: 'br-007', name: 'Consultations',  city: 'Alger', openNow: true),
    ],
  ),
  OrganizationCard(
    id: 'org-004',
    name: 'APC Alger Centre',
    type: 'administration',
    city: 'Alger',
    slug: 'apc-alger-centre',
    branches: [
      BranchSummary(id: 'br-008', name: 'Mairie Principale', city: 'Alger', openNow: true),
    ],
  ),
  OrganizationCard(
    id: 'org-005',
    name: 'Algérie Poste',
    type: 'post',
    city: 'Oran',
    slug: 'poste-oran',
    branches: [
      BranchSummary(id: 'br-009', name: 'Bureau Principal', city: 'Oran', openNow: false),
      BranchSummary(id: 'br-010', name: 'Bureau Gambetta',  city: 'Oran', openNow: true),
    ],
  ),
];

// ── Favoris ───────────────────────────────────────────────────────────────────
final mockFavorites = [mockOrganizations[0], mockOrganizations[2]];

// ── Détail agence ─────────────────────────────────────────────────────────────
final mockBranchDetail = BranchDetail(
  id: 'br-001',
  name: 'Agence Didouche Mourad',
  address: '12 Rue Didouche Mourad, Alger Centre',
  city: 'Alger',
  phone: '+213 21 73 45 67',
  latitude: 36.7372,
  longitude: 3.0862,
  openNow: true,
  openUntil: '17h00',
  queues: [
    QueueSummary(
      id: 'q-001',
      name: 'File Virements',
      status: 'ACTIVE',
      waitingCount: 12,
      avgWaitMin: 14,
      service: ServiceSummary(id: 'svc-001', name: 'Virements', icon: 'swap_horiz', color: '#4F6EF7'),
    ),
    QueueSummary(
      id: 'q-002',
      name: 'File Dépôts / Retraits',
      status: 'ACTIVE',
      waitingCount: 5,
      avgWaitMin: 7,
      service: ServiceSummary(id: 'svc-002', name: 'Dépôts / Retraits', icon: 'savings', color: '#22C87A'),
    ),
    QueueSummary(
      id: 'q-003',
      name: 'File Crédits',
      status: 'ACTIVE',
      waitingCount: 3,
      avgWaitMin: 22,
      service: ServiceSummary(id: 'svc-003', name: 'Crédits & Prêts', icon: 'credit_score', color: '#F5A623'),
    ),
    QueueSummary(
      id: 'q-004',
      name: 'File Renseignements',
      status: 'PAUSED',
      waitingCount: 0,
      avgWaitMin: 4,
      service: ServiceSummary(id: 'svc-004', name: 'Renseignements', icon: 'info', color: '#2DD4BF'),
    ),
  ],
);

// ── Ticket actif ──────────────────────────────────────────────────────────────
TicketModel buildMockTicket({
  int position = 4,
  TicketStatus status = TicketStatus.waiting,
}) {
  return TicketModel(
    id: 'ticket-demo-001',
    code: 'B-0047',
    number: 47,
    status: status,
    position: position,
    estimatedWaitMin: position > 0 ? position * 3 : null,
    queue: const QueueInfo(
      id: 'q-001',
      name: 'File Virements',
      prefix: 'B',
      waitingCount: 12,
    ),
    service: const ServiceInfo(
      id: 'svc-001',
      name: 'Virements',
    ),
    branch: const BranchInfo(
      id: 'br-001',
      name: 'Agence Didouche Mourad',
      address: '12 Rue Didouche Mourad',
      city: 'Alger',
    ),
    counter: status == TicketStatus.called
        ? const CounterInfo(id: 'c-003', name: 'Guichet 03', number: 3)
        : null,
    createdAt: DateTime.now().subtract(const Duration(minutes: 14)),
  );
}

// ── Historique tickets ────────────────────────────────────────────────────────
final mockTicketHistory = [
  TicketModel(
    id: 'ticket-h-001', code: 'A-0023', number: 23,
    status: TicketStatus.completed,
    waitDurationSec: 720,
    queue: const QueueInfo(id: 'q-002', name: 'Dépôts', prefix: 'A'),
    service: const ServiceInfo(id: 'svc-002', name: 'Dépôts / Retraits'),
    branch: const BranchInfo(id: 'br-001', name: 'Agence Didouche Mourad', address: '12 Rue Didouche Mourad'),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    completedAt: DateTime.now().subtract(const Duration(days: 2, minutes: -20)),
  ),
  TicketModel(
    id: 'ticket-h-002', code: 'B-0089', number: 89,
    status: TicketStatus.cancelled,
    queue: const QueueInfo(id: 'q-001', name: 'Virements', prefix: 'B'),
    service: const ServiceInfo(id: 'svc-001', name: 'Virements'),
    branch: const BranchInfo(id: 'br-004', name: 'Agence Centre CPA', address: 'Rue des Trois Frères Bouaddou'),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    cancelledAt: DateTime.now().subtract(const Duration(days: 5, minutes: -10)),
  ),
  TicketModel(
    id: 'ticket-h-003', code: 'C-0012', number: 12,
    status: TicketStatus.completed,
    waitDurationSec: 1260,
    queue: const QueueInfo(id: 'q-003', name: 'Crédits', prefix: 'C'),
    service: const ServiceInfo(id: 'svc-003', name: 'Crédits & Prêts'),
    branch: const BranchInfo(id: 'br-001', name: 'Agence Didouche Mourad', address: '12 Rue Didouche Mourad'),
    createdAt: DateTime.now().subtract(const Duration(days: 12)),
  ),
  TicketModel(
    id: 'ticket-h-004', code: 'A-0067', number: 67,
    status: TicketStatus.missed,
    queue: const QueueInfo(id: 'q-002', name: 'Dépôts', prefix: 'A'),
    service: const ServiceInfo(id: 'svc-002', name: 'Dépôts / Retraits'),
    branch: const BranchInfo(id: 'br-002', name: 'Agence Hussein Dey', address: 'Avenue de l\'ALN, Hussein Dey'),
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
  ),
];
