// lib/features/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/home/presentation/providers/home_provider.dart';
import 'package:smartqueue/features/home/presentation/widgets/home_widgets.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchCtrl = TextEditingController();
  String? _selType;
  bool _searchActive = false;

  static const _types = [
    ('bank',           'Banques',        Icons.account_balance_outlined),
    ('hospital',       'Hôpitaux',       Icons.local_hospital_outlined),
    ('administration', 'Administration', Icons.business_outlined),
    ('post',           'Poste',          Icons.local_post_office_outlined),
  ];

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  void _search() {
    ref.read(searchNotifierProvider.notifier).search(
      query: _searchCtrl.text.trim().isEmpty ? null : _searchCtrl.text.trim(),
      type: _selType);
    setState(() => _searchActive = true);
  }

  void _clearSearch() {
    _searchCtrl.clear();
    setState(() => _searchActive = false);
    ref.read(searchNotifierProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final user        = ref.watch(authStateNotifierProvider).value?.user;
    final searchState = ref.watch(searchNotifierProvider);
    final favAsync    = ref.watch(favoritesProvider);
    final activeAsync = ref.watch(myTicketsProvider(status: 'WAITING,CALLED,IN_SERVICE'));

    // Liste des IDs favoris pour savoir si une org est favorite
    final favIds = favAsync.value?.map((o) => o.id).toSet() ?? {};

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: _Header(name: user?.firstName ?? '')),
        if (activeAsync.value?.isNotEmpty == true)
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: _ActiveBanner(ticket: activeAsync.value!.first),
          ).animate().fadeIn().slideY(begin: -.05)),
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: _SearchBar(ctrl: _searchCtrl, onSearch: _search, onClear: _clearSearch))),
        SliverToBoxAdapter(child: SizedBox(height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _types.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final (key, lbl, icon) = _types[i];
              return OrgTypeChip(
                label: lbl, icon: icon, selected: _selType == key,
                onTap: () {
                  setState(() => _selType = _selType == key ? null : key);
                  _search();
                });
            }))),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        if (_searchActive)
          ..._buildSearch(searchState, favIds)
        else
          ..._buildHome(favAsync, favIds),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ]),
    );
  }

  List<Widget> _buildSearch(
    AsyncValue<List<OrganizationCard>> state,
    Set<String> favIds,
  ) => [
    SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text('Résultats', style: Theme.of(context).textTheme.titleMedium))),
    state.when(
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator())),
      error: (e, _) => SliverToBoxAdapter(
        child: Center(child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(e.toString(),
            style: const TextStyle(color: AppColors.textSecondary))))),
      data: (orgs) => orgs.isEmpty
        ? const SliverToBoxAdapter(child: _EmptyState(
            icon: Icons.search_off, msg: 'Aucun établissement trouvé.'))
        : SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: orgs.length,
              itemBuilder: (_, i) => OrgCard(
                org: orgs[i],
                isFavorite: favIds.contains(orgs[i].id),
                onTap: () => _onTap(orgs[i]),
              ).animate(delay: (i * 40).ms).fadeIn().slideY(begin: .05))),
    ),
  ];

  List<Widget> _buildHome(
    AsyncValue<List<OrganizationCard>> favAsync,
    Set<String> favIds,
  ) => [
    SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text('Mes établissements', style: Theme.of(context).textTheme.titleMedium))),
    favAsync.when(
      loading: () => const SliverToBoxAdapter(child: _FavSkeleton()),
      error:   (_, __) => const SliverToBoxAdapter(child: SizedBox()),
      data: (favs) => favs.isEmpty
        ? const SliverToBoxAdapter(child: _EmptyState(
            icon: Icons.favorite_border,
            msg: 'Aucun favori.\nRecherchez un établissement pour en ajouter.'))
        : SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: favs.length,
              itemBuilder: (_, i) => OrgCard(
                org: favs[i],
                isFavorite: true,
                onTap: () => _onTap(favs[i]),
              ).animate(delay: (i * 60).ms).fadeIn().slideX(begin: -.03))),
    ),
  ];

  void _onTap(OrganizationCard org) {
    if (org.branches.isNotEmpty) {
      context.push('/branch/${org.branches.first.id}');
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 20),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name.isNotEmpty ? 'Bonjour, $name 👋' : 'Bonjour 👋',
            style: const TextStyle(color: AppColors.textPrimary,
              fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -.3)),
          const SizedBox(height: 2),
          const Text('Où souhaitez-vous aller ?',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ]),
        const Spacer(),
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(
            color: AppColors.bgSurface, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border)),
          child: const Icon(Icons.notifications_outlined,
            color: AppColors.textSecondary, size: 20)),
      ]),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -.05);
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.ctrl, required this.onSearch, required this.onClear});
  final TextEditingController ctrl;
  final VoidCallback onSearch, onClear;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.bgSurface, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border)),
      child: Row(children: [
        const SizedBox(width: 14),
        const Icon(Icons.search, color: AppColors.textMuted, size: 18),
        const SizedBox(width: 10),
        Expanded(child: TextField(
          controller: ctrl, onSubmitted: (_) => onSearch(),
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Banque, hôpital, ville...',
            border: InputBorder.none, isDense: true,
            contentPadding: EdgeInsets.zero))),
        if (ctrl.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close, size: 16, color: AppColors.textMuted),
            onPressed: onClear,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36))
        else
          TextButton(
            onPressed: onSearch,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12)),
            child: const Text('Chercher', style: TextStyle(fontSize: 13))),
      ]),
    );
  }
}

class _ActiveBanner extends StatelessWidget {
  const _ActiveBanner({required this.ticket});
  final TicketModel ticket;
  @override
  Widget build(BuildContext context) {
    final called = ticket.status == TicketStatus.called;
    return GestureDetector(
      onTap: () => context.push('/ticket/${ticket.id}'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: called
              ? [const Color(0xFF2A1F00), const Color(0xFF382900)]
              : [const Color(0xFF0D1A40), const Color(0xFF122050)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: called
              ? AppColors.warning.withOpacity(.4)
              : AppColors.accent.withOpacity(.3))),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: (called ? AppColors.warning : AppColors.accent).withOpacity(.15),
              borderRadius: BorderRadius.circular(10)),
            child: Icon(
              called ? Icons.campaign_outlined : Icons.confirmation_num_outlined,
              color: called ? AppColors.warning : AppColors.accent, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(called ? "C'est votre tour !" : 'Ticket actif',
              style: TextStyle(
                color: called ? AppColors.warning : AppColors.accent,
                fontSize: 13, fontWeight: FontWeight.w700)),
            Text(called
              ? 'Rendez-vous au ${ticket.counter?.name ?? "guichet"}'
              : '${ticket.code} · Position ${ticket.position ?? "—"}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ])),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18),
        ]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.msg});
  final IconData icon;
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Center(child: Column(children: [
        Icon(icon, size: 40, color: AppColors.textMuted),
        const SizedBox(height: 16),
        Text(msg, textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textSecondary, fontSize: 14, height: 1.5)),
      ])));
  }
}

class _FavSkeleton extends StatelessWidget {
  const _FavSkeleton();
  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(3, (_) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(height: 100,
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(16))))));
  }
}