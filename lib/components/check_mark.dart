import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/app_colors.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({
    super.key,
    this.radius = 8,
    this.activeColor = AppColors.primaryAppColor,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(2),
  });
  final double radius;
  final Color activeColor, iconColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8,
      backgroundColor: activeColor,
      child: Padding(
        padding: padding,
        child: SvgPicture.asset(
          "assets/icons/Singlecheck.svg",
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}