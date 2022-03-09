import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/widgets/score_list/score_list_element.dart';
import 'package:scoremaster/src/widgets/top_score/top_scorer_card.dart';

import '../../config/app_spacing.dart';

class ScoreList extends StatelessWidget {
  const ScoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: _bottomShadeOut,
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          itemCount: 8,
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
              username: 'nancy',
              score: 1337,
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
}
