import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_spacing.dart';

import '../../config/app_colors.dart';
import '../top_score/top_scorer_card.dart';

class ScoreListElement extends StatelessWidget {
  final int index;
  final ScoreDirection scoreDirection;
  final String username;
  final int score;

  const ScoreListElement({
    Key? key,
    required this.index,
    required this.scoreDirection,
    required this.username,
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
        // SizedBox(
        //   width: 240.0,
        //   child: Stack(
        //     children: [
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(20.0),
        //         child: Container(
        //           color: AppColors.onBackground,
        //           width: 240.0,
        //           height: 40.0,
        //         ),
        //       ),
        //       const Positioned(
        //         child: CircleAvatar(
        //           backgroundImage:
        //               AssetImage('assets/mock/pictures/profile-4.jpg'),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: AppSpacing.XL, top: 10.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Text('@' + username),
        //             Text(
        //               score.toString(),
        //               style: const TextStyle(
        //                 color: AppColors.accent,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.XL),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Expanded(
              child: Container(
                color: AppColors.onBackground,
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/mock/pictures/profile-4.jpg'),
                    ),
                    Text('@' + username),
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.XL),
                      child: Text(
                        score.toString(),
                        style: const TextStyle(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
