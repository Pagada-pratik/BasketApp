import 'package:flutter/material.dart';
import '../../resources/app_colors.dart';

class TextRich extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final double fontSizeOne;
  final double fontSizeTwo;
  final Color textColor;

  const TextRich({
    super.key,
    required this.textOne,
    required this.textTwo,
    this.fontSizeOne = 16,
    this.fontSizeTwo = 16,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textOne,
          style: TextStyle(
            color: AppColors.primaryAppColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSizeOne,
          ),
        ),
        Flexible(
          child: Text(
            textTwo,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSizeTwo,
            ),
          ),
        ),
      ],
    );
  }
}