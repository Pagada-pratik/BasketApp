import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

const InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.lightGreyColor,
  filled: true,
  hintStyle: TextStyle(color: AppColors.greyColor),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

const InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.darkGreyColor,
  filled: true,
  hintStyle: TextStyle(color: AppColors.whileColor40),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

const OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
  borderSide: BorderSide(color: AppColors.primaryAppColor),
);

const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
  borderSide: BorderSide(
    color: AppColors.errorColor,
  ),
);

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
    borderSide: BorderSide(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.15),
    ),
  );
}