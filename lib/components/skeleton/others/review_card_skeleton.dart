import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../../../views/reviews/components/stars_rating.dart';
import '../skeleton.dart';

class ReviewCardSkeleton extends StatelessWidget {
  const ReviewCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
            child: AspectRatio(
              aspectRatio: 1.99,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade900,
                highlightColor: Colors.grey.shade100,
                period: const Duration(seconds: 2),
                child: Stack(
                  children: [
                    const Skeleton(radius: AppConstants.defaultBorderRadius),
                    Positioned.fill(
                      left: AppConstants.defaultPadding,
                      right: AppConstants.defaultPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Skeleton(
                                width: Get.width * 0.13,
                                height: Get.width * 0.13,
                                radius: 100,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(
                                    width: Get.width * 0.3,
                                    height: 16,
                                  ),
                                  const SizedBox(height: AppConstants.defaultPadding / 3),
                                  ViewRatting().getStarRateView(context, double.parse(0.toString())),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.defaultPadding),
                          const Skeleton(height: 80, radius: AppConstants.defaultBorderRadius),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}