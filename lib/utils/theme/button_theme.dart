import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(AppConstants.defaultPadding),
    backgroundColor: AppColors.primaryAppColor,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(
    {Color borderColor = AppColors.blackColor10}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      minimumSize: const Size(double.infinity, 32),
      side: BorderSide(width: 1.5, color: borderColor),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
      ),
    ),
  );
}

final textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: AppColors.primaryAppColor),
);