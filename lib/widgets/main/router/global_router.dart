part of '../app_persistent_layout.dart';

class GlobalRouter {
  GlobalRouter._();
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SampleScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const SampleScreen(),
      ),
      GoRoute(
        path: '/guide',
        builder: (context, state) => const SampleScreen(),
      ),
    ],
  );
}
