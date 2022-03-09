import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/pages/leader_board_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoremaster',
      theme: AppTheme.dark,
      home: const LeaderBoardPage(),
    );
  }
}
