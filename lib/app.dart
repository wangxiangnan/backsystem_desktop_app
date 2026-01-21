import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import 'package:backsystem_desktop_app/features/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (_) => UserRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
          userRepository: context.read<UserRepository>(),
        )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({ super.key });

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I.get<GoRouter>();
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primaryColor: Color(0xff605bff),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff605bff)),
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                router.replace('/');
              case AuthenticationStatus.unauthenticated:
                router.replace('/login');
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },

      // onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}