import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/config/app_spacing.dart';
import 'package:scoremaster/src/config/app_theme.dart';
import 'package:scoremaster/src/models/game/game_model.dart';
import 'package:scoremaster/src/services/game_service.dart';
import 'package:scoremaster/src/services/score_service.dart';
import 'package:scoremaster/src/services/user_service.dart';
import 'package:scoremaster/src/widgets/time_filter_button.dart';
import 'package:scoremaster/src/widgets/top_score/top_score_ladder.dart';

import '../models/user/user_model.dart';
import '../widgets/score_edit_form.dart';
import '../widgets/score_list/score_list.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  bool _initilized = false;

  Map<String, UserModel> users = {};
  List<MapEntry<String, int>> userScoresList = [];
  List<GameModel> games = [];

  Future<void> getData() async {
    users = await UserService.instance.asMap();
    Map<String, int> scoresMappedToUId =
        await ScoreService.instance.mappedToUid();

    userScoresList = scoresMappedToUId.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );

    games = await GameService.instance.all();

    setState(() {});

    _initilized = true;
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
    if (!_initilized) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: ScoreEditForm(
                users: users.values.toList(),
                games: games,
              ),
            );
          },
        ),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.accent,
        color: AppColors.primary,
        onRefresh: () => getData(),
        child: Padding(
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
      ),
    );
  }
}
