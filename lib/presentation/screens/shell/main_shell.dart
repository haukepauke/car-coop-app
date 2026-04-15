import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/car_provider.dart';
import '../../../providers/settings_provider.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _tabPaths = [
    '/trips',
    '/expenses',
    '/parking',
    '/messages',
    '/payments',
    '/bookings',
  ];

  static const _tabIcons = [
    Icons.route_outlined,
    Icons.receipt_long_outlined,
    Icons.local_parking_outlined,
    Icons.forum_outlined,
    Icons.payments_outlined,
    Icons.calendar_month_outlined,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (var i = 0; i < _tabPaths.length; i++) {
      if (location.startsWith(_tabPaths[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCar = ref.watch(selectedCarProvider);
    final quickActionsEnabled = ref.watch(quickActionsEnabledProvider);
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;

    final tabLabels = [
      l10n.navTripsShort,
      l10n.navExpensesShort,
      l10n.navParkingShort,
      l10n.navMessagesShort,
      l10n.navPaymentsShort,
      l10n.navBookingsShort,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCar?.name ?? l10n.appTitle),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bolt_outlined,
              color: quickActionsEnabled ? null : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            tooltip: l10n.quickActionsTitle,
            onPressed: () => context.push('/quick-actions'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_tabPaths[index]),
        destinations: List.generate(
          _tabPaths.length,
          (i) => NavigationDestination(
            icon: Icon(_tabIcons[i]),
            label: tabLabels[i],
          ),
        ),
      ),
    );
  }
}
