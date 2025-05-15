import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/app_colors.dart';
import '../resources/constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.rating,
    required this.numOfReviews,
    this.numOfFiveStar = 0,
    this.numOfFourStar = 0,
    this.numOfThreeStar = 0,
    this.numOfTwoStar = 0,
    this.numOfOneStar = 0,
  });

  final double rating;
  final int numOfReviews;
  final int numOfFiveStar,
      numOfFourStar,
      numOfThreeStar,
      numOfTwoStar,
      numOfOneStar;

  @override
  Widget build(BuildContext context) {
    double safeValue(int count) {
      return numOfReviews == 0 ? 0.0 : count / numOfReviews;
    }

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.035),
        borderRadius: const BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "${rating.toStringAsFixed(1)} ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "/5",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Text("Based on $numOfReviews Reviews"),
                const SizedBox(height: AppConstants.defaultPadding),
                RatingBar.builder(
                  initialRating: rating,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.only(right: AppConstants.defaultPadding / 4),
                  unratedColor: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.08),
                  glow: false,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  onRatingUpdate: (value) {},
                  itemBuilder: (context, index) =>
                      SvgPicture.asset("assets/icons/Star_filled.svg"),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding),
          Expanded(
            child: Column(
              children: [
                RateBar(star: 5, value: safeValue(numOfFiveStar)),
                RateBar(star: 4, value: safeValue(numOfFourStar)),
                RateBar(star: 3, value: safeValue(numOfThreeStar)),
                RateBar(star: 2, value: safeValue(numOfTwoStar)),
                RateBar(star: 1, value: safeValue(numOfOneStar)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RateBar extends StatelessWidget {
  const RateBar({
    super.key,
    required this.star,
    required this.value,
  });

  final int star;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: star == 1 ? 0 : AppConstants.defaultPadding / 2),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              "$star Star",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium!.color),
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding / 2),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.defaultBorderRadius),
              ),
              child: LinearProgressIndicator(
                minHeight: 6,
                color: AppColors.warningColor,
                backgroundColor: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.05),
                value: value.isNaN || value.isInfinite ? 0.0 : value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}