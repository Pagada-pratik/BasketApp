import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/constants.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = AppColors.primaryAppColor,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.defaultDuration,
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? AppColors.primaryMaterialAppColor.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultPadding)),
      ),
    );
  }
}