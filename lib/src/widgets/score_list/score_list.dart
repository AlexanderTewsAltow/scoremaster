import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/widgets/score_list/score_list_element.dart';
import 'package:scoremaster/src/widgets/top_score/top_scorer_card.dart';

import '../../config/app_spacing.dart';
import '../../models/user/user_model.dart';

class ScoreList extends StatelessWidget {
  final Map<String, UserModel> users;
  final List<MapEntry<String, int>> userScoreList;

  const ScoreList({Key? key, required this.users, required this.userScoreList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: _bottomShadeOut,
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          itemCount: userScoreList.length > 3 ? userScoreList.length - 3 : 0,
          padding: const EdgeInsets.only(
            top: AppSpacing.XL,
            left: AppSpacing.XL,
            right: AppSpacing.XL,
          ),
          separatorBuilder: (BuildContext context, int index) => Container(
            height: AppSpacing.L,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ScoreListElement(
              index: index,
              scoreDirection: ScoreDirection.rise,
              username: getUsernameByUid(userScoreList[index + 3].key),
              imageUrl: getUserImageByUid(userScoreList[index + 3].key),
              score: userScoreList[index + 3].value,
            );
          },
        ),
      ),
    );
  }

  Shader _bottomShadeOut(rect) {
    return const LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [AppColors.background, Colors.transparent],
    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
  }

  String getUsernameByUid(String userId) => users[userId]?.username ?? 'Anon';

  String getUserImageByUid(String userId) =>
      users[userId]?.imageUrl ?? 'assets/mock/pictures/default.jpg';
}
