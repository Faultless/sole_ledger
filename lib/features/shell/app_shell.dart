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

/// Width at/above which we show the persistent NavigationRail; below it we use
/// a hamburger drawer so seven destinations don't crowd a phone.
const double kWideBreakpoint = 760;

/// Key on the narrow-layout shell Scaffold so each screen's AppBar hamburger
/// (see [navLeading]) can open the shared navigation drawer despite living in a
/// nested Scaffold.
final GlobalKey<ScaffoldState> shellScaffoldKey = GlobalKey<ScaffoldState>();

/// AppBar `leading` for the top-level screens: a hamburger that opens the nav
/// drawer on phones, and nothing on wide layouts (the rail handles navigation).
Widget? navLeading(BuildContext context) {
  if (MediaQuery.sizeOf(context).width >= kWideBreakpoint) return null;
  return IconButton(
    icon: const Icon(Icons.menu),
    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    onPressed: () => shellScaffoldKey.currentState?.openDrawer(),
  );
}

/// Responsive navigation shell: a rail on wide layouts (desktop/web/tablet),
/// a hamburger drawer on phones.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  int _indexFor(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final i = navDestinations.indexWhere((d) => location.startsWith(d.route));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final index = _indexFor(context);
    final wide = MediaQuery.sizeOf(context).width >= kWideBreakpoint;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (i) =>
                  context.go(navDestinations[i].route),
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

    // Phone: the drawer lives on this shell Scaffold; each screen's AppBar
    // opens it via shellScaffoldKey. No bottom bar (seven items is too many).
    return Scaffold(
      key: shellScaffoldKey,
      drawer: _NavDrawer(selectedIndex: index),
      body: child,
    );
  }
}

class _NavDrawer extends StatelessWidget {
  const _NavDrawer({required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final scheme = Theme.of(context).colorScheme;
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) {
        Navigator.of(context).pop(); // close the drawer
        context.go(navDestinations[i].route);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 16, 12),
          child: Row(
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
              const SizedBox(width: 12),
              Text(l10n.appTitle,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        for (final d in navDestinations)
          NavigationDrawerDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.selectedIcon),
            label: Text(d.label(l10n)),
          ),
      ],
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
