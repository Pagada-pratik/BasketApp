import 'package:flutter/material.dart';

import '../../../components/check_mark.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    required this.color,
    this.isActive = false,
    this.press,
  });
  final Color color;
  final bool isActive;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedContainer(
        duration: AppConstants.defaultDuration,
        padding: EdgeInsets.all(isActive ? AppConstants.defaultPadding / 4 : 0),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isActive ? AppColors.primaryAppColor : Colors.transparent),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
            ),
            AnimatedOpacity(
              opacity: isActive ? 1 : 0,
              duration: AppConstants.defaultDuration,
              child: const CheckMark(),
            ),
          ],
        ),
      ),
    );
  }
}