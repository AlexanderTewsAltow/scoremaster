import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/config/app_spacing.dart';
import 'package:scoremaster/src/widgets/top_score/top_scorer_card.dart';

import '../../models/user/user_model.dart';

class TopScoreLadder extends StatelessWidget {
  final Map<String, UserModel> users;
  final List<MapEntry<String, int>> userScoreList;

  const TopScoreLadder({
    Key? key,
    required this.users,
    required this.userScoreList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      height: 240.0,
      child: Stack(
        children: [
          if (userScoreList.length >= 3)
            Positioned(
              bottom: 0.0,
              right: AppSpacing.XL,
              child: TopScorerCard(
                place: 3,
                scoreDirection: ScoreDirection.descent,
                username: getUsernameByUid(userScoreList[2].key),
                imageUrl: getUserImageByUid(userScoreList[2].key),
                score: userScoreList[2].value,
              ),
            ),
          if (userScoreList.length >= 2)
            Positioned(
              bottom: 0.0,
              left: AppSpacing.XL,
              child: TopScorerCard(
                place: 2,
                scoreDirection: ScoreDirection.rise,
                imageUrl: getUserImageByUid(userScoreList[1].key),
                username: getUsernameByUid(userScoreList[1].key),
                score: userScoreList[1].value,
              ),
            ),
          if (userScoreList.isNotEmpty)
            TopScorerCard(
              place: 1,
              scoreDirection: ScoreDirection.rise,
              imageUrl: getUserImageByUid(userScoreList[0].key),
              username: getUsernameByUid(userScoreList[0].key),
              score: userScoreList.first.value,
            ),
        ],
      ),
    );
  }

  String getUsernameByUid(String userId) => users[userId]?.username ?? 'Anon';

  String getUserImageByUid(String userId) =>
      users[userId]?.imageUrl ?? 'assets/mock/pictures/default.jpg';
}
