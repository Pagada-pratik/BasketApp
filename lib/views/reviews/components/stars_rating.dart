import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../resources/app_colors.dart';

class StarsRating extends StatelessWidget {
  final String titleText;
  final double initialValue;
  final void Function(double value)? onValueChanged;

  const StarsRating({
    super.key,
    required this.titleText,
    required this.initialValue,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: [
            Text(titleText,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingStars(
                  axis: Axis.horizontal,
                  value: initialValue,
                  onValueChanged: onValueChanged,
                  starCount: 5,
                  starSize: 26,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                    fontFamily: 'Exo2',
                  ),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 5,
                  valueLabelVisibility: false,
                  valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.08),
                  starColor: AppColors.warningColor,
                  angle: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ViewRatting {
  Widget getStarRateView(BuildContext context, double rateValue) {
    return RatingStars(
      axis: Axis.horizontal,
      value: rateValue,
      starCount: 5,
      starSize: 18,
      valueLabelColor: const Color(0xff9b9b9b),
      valueLabelTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 12.0,
        fontFamily: 'Exo2',
      ),
      valueLabelRadius: 10,
      maxValue: 5,
      valueLabelVisibility: false,
      valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: Theme.of(context)
          .textTheme
          .bodyLarge!
          .color!
          .withOpacity(0.08),
      starColor: AppColors.warningColor,
      angle: 12,
    );
  }
}