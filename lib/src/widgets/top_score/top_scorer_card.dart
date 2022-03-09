import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_spacing.dart';

enum ScoreDirection {
  rise,
  same,
  descent,
}

class TopScorerCard extends StatefulWidget {
  final int place;
  final ScoreDirection scoreDirection;
  final String imageUrl;
  final String username;
  final int score;

  const TopScorerCard({
    Key? key,
    required this.place,
    required this.scoreDirection,
    required this.imageUrl,
    required this.username,
    required this.score,
  }) : super(key: key);

  @override
  State<TopScorerCard> createState() => _TopScorerCardState();
}

class _TopScorerCardState extends State<TopScorerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _animationController.repeat(reverse: true);
    _animation = Tween(
      begin: 2.0,
      end: 10.0,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(widget.place.toString()),
          widget.place == 1
              ? const Text(
                  '👑',
                  style: TextStyle(fontSize: 30.0),
                )
              : Icon(
                  _getIconFromScoreDirection(widget.scoreDirection),
                  size: 30.0,
                  color: widget.scoreDirection == ScoreDirection.rise
                      ? AppColors.accent
                      : AppColors.onPrimary,
                ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.L),
            height: widget.place == 1 ? 100.0 : 80.0,
            width: widget.place == 1 ? 100.0 : 80.0,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                widget.place == 1
                    ? BoxShadow(
                        offset: const Offset(0.0, 0.0),
                        blurRadius: _animation.value,
                        spreadRadius: _animation.value,
                        color: AppColors.accent.withOpacity(0.4),
                      )
                    : const BoxShadow(),
              ],
            ),
            child: CircleAvatar(
              radius: widget.place == 1 ? 80.0 : 60.0,
              backgroundColor: AppColors.accent,
              child: CircleAvatar(
                radius: widget.place == 1 ? 46.0 : 38.0,
                backgroundColor: Colors.grey[200],
                backgroundImage: AssetImage(widget.imageUrl),
              ),
            ),
          ),
          Text(
            '@' + widget.username,
            style: TextStyle(color: Colors.grey[500]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.XS),
            child: Text(
              widget.score.toString(),
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
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
