import 'package:backsystem_desktop_app/features/ticket_unissued.dart/ticket_unissued.dart';
import 'package:flutter/material.dart';
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
      
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  destinations: [
                    NavigationRailDestination(

                      icon: const Icon(Icons.home),
                      label: const Text('首页'),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.unarchive),
                      label: const Text('项目未出票'),
                    ),
                  ],
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (value) {
                    navigationShell.goBranch(value);
                  },
                ),
                VerticalDivider(width: 1, thickness: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return HomePage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ticket-unissued',
                builder: (context, state) {
                  return TicketUnissuedPage();
                },
              ),
            ],
          ),
        ]
      ),
    ]
  ),
);

final router = GoRouter.routingConfig(
  routingConfig: _routingConfig,
  initialLocation: '/splash',
);