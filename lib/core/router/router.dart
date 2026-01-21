import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:backsystem_desktop_app/features/login/login.dart';
import 'package:backsystem_desktop_app/features/home/home.dart';
import 'package:backsystem_desktop_app/features/splash/splash.dart';

final ValueNotifier<RoutingConfig> _routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return SplashPage();
        },
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomePage();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          
        },
        branches: branches
      ),
    ]
  ),
);

final router = GoRouter.routingConfig(
  routingConfig: _routingConfig,
  initialLocation: '/splash',
);