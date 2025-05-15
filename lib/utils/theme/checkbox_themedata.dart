import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.white),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppConstants.defaultBorderRadius / 2),
    ),
  ),
  side: const BorderSide(color: AppColors.whileColor40),
);