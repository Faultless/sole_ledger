import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

/// One destination in the primary navigation.
class NavDestination {
  const NavDestination(this.route, this.icon, this.selectedIcon, this.label);
  final String route;
  final IconData icon;
  final IconData selectedIcon;
  final String Function(L10n) label;
}

final navDestinations = <NavDestination>[
  NavDestination('/dashboard', Icons.dashboard_outlined, Icons.dashboard, (l) => l.navDashboard),
  NavDestination('/time', Icons.schedule_outlined, Icons.schedule, (l) => l.navTime),
  NavDestination('/clients', Icons.people_outline, Icons.people, (l) => l.navClients),
  NavDestination('/invoices', Icons.receipt_long_outlined, Icons.receipt_long, (l) => l.navInvoices),
  NavDestination('/reports', Icons.insights_outlined, Icons.insights, (l) => l.navReports),
  NavDestination('/expenses', Icons.payments_outlined, Icons.payments, (l) => l.navExpenses),
  NavDestination('/settings', Icons.settings_outlined, Icons.settings, (l) => l.navSettings),
];

/// Responsive navigation shell: a rail on wide layouts (desktop/web/tablet),
/// a bottom bar on phones.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  int _indexFor(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final i = navDestinations.indexWhere((d) => location.startsWith(d.route));
    return i < 0 ? 0 : i;
  }

  void _go(BuildContext context, int index) =>
      context.go(navDestinations[index].route);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final index = _indexFor(context);
    final wide = MediaQuery.sizeOf(context).width >= 760;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (i) => _go(context, i),
              extended: MediaQuery.sizeOf(context).width >= 1100,
              minExtendedWidth: 200,
              leading: const _RailBrand(),
              destinations: [
                for (final d in navDestinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label(l10n)),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => _go(context, i),
        destinations: [
          for (final d in navDestinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label(l10n),
            ),
        ],
      ),
    );
  }
}

class _RailBrand extends StatelessWidget {
  const _RailBrand();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.account_balance_wallet_outlined,
                color: scheme.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
