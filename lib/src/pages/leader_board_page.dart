import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_spacing.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/services/score_service.dart';
import 'package:scoremaster/src/services/user_service.dart';
import 'package:scoremaster/src/widgets/time_filter_button.dart';
import 'package:scoremaster/src/widgets/top_score/top_score_ladder.dart';

import '../models/user/user_model.dart';
import '../widgets/score_list/score_list.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  bool _initialized = false;

  Map<String, UserModel> users = {};
  List<MapEntry<String, int>> userScoresList = [];

  void getData() async {
    users = await UserService.instance.asMap();
    Map<String, int> scoresMappedToUId =
        await ScoreService.instance.mappedToUid();

    userScoresList = scoresMappedToUId.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );

    setState(() => _initialized = true);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // If data has not yet been retrieved by the service, then display a loader
    // to provide the user with visual feedback
    if (!_initialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
          backgroundColor: AppTheme.dark.backgroundColor,
          elevation: AppSpacing.ZERO,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    // Data is available, render the leaderboard
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
              child: TopScoreLadder(
                users: users,
                userScoreList: userScoresList,
              ),
            ),
            ScoreList(
              users: users,
              userScoreList: userScoresList,
            ),
          ], // Slivers
        ),
      ),
    );
  }
}
