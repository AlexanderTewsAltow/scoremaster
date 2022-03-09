import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_spacing.dart';

import '../../config/app_colors.dart';
import '../top_score/top_scorer_card.dart';

class ScoreListElement extends StatelessWidget {
  final int index;
  final ScoreDirection scoreDirection;
  final String username;
  final String imgUrl;
  final int score;

  const ScoreListElement({
    Key? key,
    required this.index,
    required this.scoreDirection,
    required this.username,
    required this.imgUrl,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text((index + 3).toString()),
            Icon(
              _getIconFromScoreDirection(scoreDirection),
              size: 20.0,
              color: scoreDirection == ScoreDirection.rise
                  ? AppColors.accent
                  : AppColors.onPrimary,
            ),
          ],
        ),
        const SizedBox(
          width: AppSpacing.XL,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.onBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.only(right: AppSpacing.L),
            height: 40.0,
            child: Row(
              children: [
                // TODO : dynamic image
                CircleAvatar(
                  backgroundImage: AssetImage(imgUrl),
                ),
                const SizedBox(
                  width: AppSpacing.L,
                ),
                Expanded(
                  child: Text('@' + username),
                ),
                Text(
                  score.toString(),
                  style: const TextStyle(
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconFromScoreDirection(ScoreDirection scoredirection) {
    switch (scoredirection) {
      case ScoreDirection.rise:
        return Icons.arrow_drop_up;
      case ScoreDirection.descent:
        return Icons.arrow_drop_down;
      default:
        return Icons.remove;
    }
  }
}
