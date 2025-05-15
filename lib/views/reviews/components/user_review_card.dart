import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import 'stars_rating.dart';

class UserReviewCard extends StatelessWidget {
  final String name, review, rating;
  const UserReviewCard({
    super.key,
    required this.name,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.035),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultBorderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Get.width * 0.13,
                      height: Get.width * 0.13,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor40,
                        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                        border: Border.all(
                          color: AppColors.greyColor,
                          width: 1.0,
                        ),
                      ),
                      child: const NetworkImageWithLoader("https://i.imgur.com/AkzWQuJ.png", radius: 100),
                    ),
                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ViewRatting().getStarRateView(context, double.parse(rating.toString())),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                Text('"$review"', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}