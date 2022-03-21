import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/pages/leader_board_page.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const LeaderBoardPage(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Scoremaster',
      theme: AppTheme.dark,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
