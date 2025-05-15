import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: AppColors.blackColor),
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  ),
);

const AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: AppColors.blackColor,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(AppColors.primaryAppColor),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: WidgetStateProperty.all(Colors.black12),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
    border: Border.all(color: Colors.black12),
  ),
  dataTextStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  ),
);

DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: WidgetStateProperty.all(Colors.white10),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
    border: Border.all(color: Colors.white10),
  ),
  dataTextStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 12,
  ),
);