import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/pages/leader_board_page.dart';

void main() {
  runApp(const ScoremasterApp());
}

class ScoremasterApp extends StatelessWidget {
  const ScoremasterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoremaster',
      theme: AppTheme.dark,
      home: const LeaderBoardPage(),
    );
  }
}
