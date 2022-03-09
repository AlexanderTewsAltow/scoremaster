import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_spacing.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/widgets/score_list/score_list.dart';
import 'package:scoremaster/src/widgets/time_filter_button.dart';
import 'package:scoremaster/src/widgets/top_score/top_score_ladder.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: AppTheme.dark.backgroundColor,
        elevation: AppSpacing.ZERO,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.XL),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.M),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TimeFilterButton(text: 'Today', selected: false),
                  const TimeFilterButton(text: 'Week', selected: true),
                  const TimeFilterButton(text: 'Month', selected: false),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.L),
              child: TopScoreLadder(),
            ),
            ScoreList(),
          ], // Slivers
        ),
      ),
    );
  }
}
