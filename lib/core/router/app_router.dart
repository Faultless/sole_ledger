import 'package:go_router/go_router.dart';

import '../../features/clients/client_detail_screen.dart';
import '../../features/clients/clients_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/expenses/expenses_screen.dart';
import '../../features/invoices/invoice_detail_screen.dart';
import '../../features/invoices/invoice_editor_screen.dart';
import '../../features/invoices/invoices_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/shell/app_shell.dart';
import '../../features/time/time_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (c, s) => const NoTransitionPage(child: DashboardScreen()),
        ),
        GoRoute(
          path: '/time',
          pageBuilder: (c, s) => const NoTransitionPage(child: TimeScreen()),
        ),
        GoRoute(
          path: '/clients',
          pageBuilder: (c, s) => const NoTransitionPage(child: ClientsScreen()),
        ),
        GoRoute(
          path: '/clients/:id',
          pageBuilder: (c, s) => NoTransitionPage(
            child: ClientDetailScreen(clientId: s.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/invoices',
          pageBuilder: (c, s) => const NoTransitionPage(child: InvoicesScreen()),
        ),
        GoRoute(
          path: '/invoices/new',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: InvoiceEditorScreen()),
        ),
        GoRoute(
          path: '/invoices/:id',
          pageBuilder: (c, s) => NoTransitionPage(
            child: InvoiceDetailScreen(invoiceId: s.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/reports',
          pageBuilder: (c, s) => const NoTransitionPage(child: ReportsScreen()),
        ),
        GoRoute(
          path: '/expenses',
          pageBuilder: (c, s) => const NoTransitionPage(child: ExpensesScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (c, s) => const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
  ],
);
