import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/services/onboarding_service.dart';
import '../features/home/presentation/home_page.dart';
import '../features/inventory/presentation/inventory_page.dart';
import '../features/inventory/presentation/item_detail_page.dart';
import '../features/bins/presentation/bins_page.dart';
import '../features/bins/presentation/bin_detail_page.dart';
import '../features/scan/presentation/scan_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/onboarding/presentation/onboarding_page.dart';
import '../features/workspace/presentation/locations_page.dart';
import '../features/pick/presentation/pick_list_page.dart';
import '../features/pick/presentation/pick_session_page.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final onboardingCompleted =
        await OnboardingService().isOnboardingCompleted();
    final isOnboardingRoute = state.uri.path == '/onboarding';

    if (!onboardingCompleted && !isOnboardingRoute) {
      return '/onboarding';
    }
    if (onboardingCompleted && isOnboardingRoute) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/locations',
      builder: (context, state) => const LocationsPage(),
    ),
    GoRoute(
      path: '/pick',
      builder: (context, state) => const PickListPage(),
    ),
    GoRoute(
      path: '/pick/session',
      builder: (context, state) => const PickSessionPage(),
    ),
    GoRoute(
      path: '/bins/:id',
      builder: (context, state) {
        final binId = state.pathParameters['id']!;
        return BinDetailPage(binId: binId);
      },
    ),
    GoRoute(
      path: '/items/:id',
      builder: (context, state) {
        final itemId = state.pathParameters['id']!;
        return ItemDetailPage(itemId: itemId);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => _Shell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/inventory',
          builder: (context, state) => const InventoryPage(),
        ),
        GoRoute(
          path: '/scan',
          builder: (context, state) => const ScanPage(),
        ),
        GoRoute(
          path: '/bins',
          builder: (context, state) => const BinsPage(),
        ),
        GoRoute(
          path: '/more',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  int _currentIndex(String path) {
    if (path == '/') return 0;
    if (path.startsWith('/inventory')) return 1;
    if (path.startsWith('/scan')) return 2;
    if (path.startsWith('/bins')) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(path),
        onDestinationSelected: (i) => context.go([
          '/',
          '/inventory',
          '/scan',
          '/bins',
          '/more',
        ][i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.all_inbox_outlined),
            label: 'Bins',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
