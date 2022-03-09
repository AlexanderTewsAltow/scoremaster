import 'package:flutter/material.dart';
import 'package:scoremaster/src/config/app_colors.dart';
import 'package:scoremaster/src/config/app_spacing.dart';
import 'package:scoremaster/src/widgets/top_score/top_scorer_card.dart';

class TopScoreLadder extends StatelessWidget {
  const TopScoreLadder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      height: 240.0,
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Positioned(
            bottom: 0.0,
            left: AppSpacing.XL,
            child: TopScorerCard(
              place: 2,
              scoreDirection: ScoreDirection.rise,
              imageUrl: 'assets/mock/pictures/profile-2.jpg',
              username: 'dorisklein',
              score: 8032,
            ),
          ),
          const Positioned(
            bottom: 0.0,
            right: AppSpacing.XL,
            child: TopScorerCard(
              place: 3,
              scoreDirection: ScoreDirection.descent,
              imageUrl: 'assets/mock/pictures/profile-3.jpg',
              username: 'lord_0980',
              score: 7884,
            ),
          ),
          const TopScorerCard(
            place: 1,
            scoreDirection: ScoreDirection.rise,
            imageUrl: 'assets/mock/pictures/profile-1.jpg',
            username: 'sher234',
            score: 8122,
          ),
        ],
      ),
    );
  }
}
