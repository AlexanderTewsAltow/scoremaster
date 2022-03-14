import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/pages/leader_board_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoremaster',
      theme: AppTheme.dark,
      home: const LeaderBoardPage(),
    );
  }
}
