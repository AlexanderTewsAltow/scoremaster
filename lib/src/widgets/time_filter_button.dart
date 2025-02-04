import 'package:flutter/material.dart';

import '../config/app_spacing.dart';
import '../config/app_theme.dart';

class TimeFilterButton extends StatelessWidget {
  final String text;
  final bool selected;

  const TimeFilterButton({Key? key, required this.text, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20.0),
    //     color: AppTheme.dark.primaryColor,
    //   ),
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: AppSpacing.L,
    //     vertical: AppSpacing.S,
    //   ),
    //   child: Text(
    //     text,
    //     style: AppTheme.dark.textTheme.headline5,
    //   ),
    // );
    return TextButton(
      onPressed: () {
        print(text + " was pressed");
      },
      child: Text(text),
      style: TextButton.styleFrom(
        backgroundColor: (selected
            ? AppTheme.dark.primaryColor
            : AppTheme.dark.backgroundColor),
        primary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
