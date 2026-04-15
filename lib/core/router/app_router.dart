import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/settings_provider.dart';
import '../../presentation/screens/auth/first_setup_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/shell/main_shell.dart';
import '../../presentation/screens/bookings/bookings_screen.dart';
import '../../presentation/screens/bookings/booking_form_screen.dart';
import '../../presentation/screens/trips/trips_screen.dart';
import '../../presentation/screens/trips/trip_form_screen.dart';
import '../../presentation/screens/trips/trip_success_screen.dart';
import '../../data/models/trip.dart';
import '../../presentation/screens/expenses/expenses_screen.dart';
import '../../presentation/screens/expenses/expense_form_screen.dart';
import '../../presentation/screens/payments/payments_screen.dart';
import '../../presentation/screens/payments/payment_form_screen.dart';
import '../../presentation/screens/messages/messages_screen.dart';
import '../../presentation/screens/messages/message_compose_screen.dart';
import '../../presentation/screens/parking/parking_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/cars/car_selection_screen.dart';
import '../../presentation/screens/cars/quick_actions_screen.dart';
import '../../providers/car_provider.dart';
import '../../providers/auth_provider.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// A simple ChangeNotifier used to tell GoRouter to re-evaluate redirects
// without recreating the entire GoRouter instance.
class _RouterNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final notifier = _RouterNotifier();

  // Listen (don't watch) so the provider body never re-runs and the GoRouter
  // is never recreated. Changes instead trigger refreshListenable → redirect.
  ref.listen(authProvider, (_, __) => notifier.notify());
  ref.listen(hasSelectedCarProvider, (_, __) => notifier.notify());
  ref.listen(apiUrlProvider, (_, __) => notifier.notify());
  ref.listen(quickActionsEnabledProvider, (_, __) => notifier.notify());
  ref.onDispose(notifier.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: ref.read(quickActionsEnabledProvider) ? '/quick-actions' : '/trips',
    refreshListenable: notifier,
    redirect: (context, state) {
      final apiUrl = ref.read(apiUrlProvider);
      final authState = ref.read(authProvider);
      final hasSelectedCar = ref.read(hasSelectedCarProvider);
      final quickActionsEnabled = ref.read(quickActionsEnabledProvider);

      final hasApiUrl = apiUrl != null && apiUrl.isNotEmpty;
      final loc = state.matchedLocation;

      if (!hasApiUrl) return loc == '/setup' ? null : '/setup';
      if (authState.isLoading) return null;
      final isLoggedIn = authState.value != null;
      if (!isLoggedIn) return (loc == '/login' || loc == '/setup') ? null : '/login';
      if (loc == '/setup' || loc == '/login') {
        return '/cars';
      }
      if (!hasSelectedCar && loc != '/cars' && loc != '/settings') {
        return '/cars';
      }
      if (!quickActionsEnabled && loc == '/quick-actions') {
        return '/trips';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/setup',
        builder: (context, state) => const FirstSetupScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/cars',
        builder: (context, state) => const CarSelectionScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/quick-actions',
        builder: (context, state) => const QuickActionsScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/bookings',
            builder: (context, state) => const BookingsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const BookingFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (context, state) => BookingFormScreen(
                  bookingId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/trips',
            builder: (context, state) => const TripsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const TripFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (context, state) => TripFormScreen(
                  tripId: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: 'success',
                builder: (context, state) => TripSuccessScreen(
                  trip: state.extra! as Trip,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/expenses',
            builder: (context, state) => const ExpensesScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const ExpenseFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (context, state) => ExpenseFormScreen(
                  expenseId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/payments',
            builder: (context, state) => const PaymentsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const PaymentFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                builder: (context, state) => PaymentFormScreen(
                  paymentId: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/messages',
            builder: (context, state) => const MessagesScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const MessageComposeScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/parking',
            builder: (context, state) => const ParkingScreen(),
          ),
        ],
      ),
    ],
  );
}
