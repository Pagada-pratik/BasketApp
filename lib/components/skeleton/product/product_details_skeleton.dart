import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade900,
          highlightColor: Colors.grey.shade100,
          period: const Duration(seconds: 2),
          child: const Padding(
            padding: EdgeInsets.all(AppConstants.defaultPadding / 0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Skeleton(height: 40, width: 40, radius: 100),
                    Skeleton(height: 40, width: 40, radius: 100),
                  ],
                ),
                SizedBox(height: AppConstants.defaultBorderRadius * 1.5),
                AspectRatio(
                  aspectRatio: 0.93,
                  child: Skeleton(
                    radius: AppConstants.defaultBorderRadius * 2,
                  ),
                ),
                SizedBox(height: AppConstants.defaultBorderRadius * 1.5),
                Skeleton(height: 18, width: 150),
                SizedBox(height: AppConstants.defaultBorderRadius * 1.5),
                Skeleton(height: 18),
                SizedBox(height: AppConstants.defaultBorderRadius * 1.5),
                Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Skeleton(height: 33, width: 130, radius: AppConstants.defaultBorderRadius / 2),
                ),
                SizedBox(height: AppConstants.defaultBorderRadius * 2.3),
                Skeleton(height: 18, width: 150),
                SizedBox(height: AppConstants.defaultBorderRadius * 0.8),
                Skeleton(height: 8),
                SizedBox(height: AppConstants.defaultBorderRadius * 0.5),
                Skeleton(height: 8),
                SizedBox(height: AppConstants.defaultBorderRadius * 0.5),
                Skeleton(height: 8, width: 120),
                SizedBox(height: AppConstants.defaultBorderRadius * 2.3),
                Skeleton(height: 40, radius: AppConstants.defaultBorderRadius / 2),
                SizedBox(height: AppConstants.defaultBorderRadius * 0.3),
                Skeleton(height: 40, radius: AppConstants.defaultBorderRadius / 2),
                SizedBox(height: AppConstants.defaultBorderRadius * 0.3),
                Skeleton(height: 40, radius: AppConstants.defaultBorderRadius / 2),
                SizedBox(height: AppConstants.defaultBorderRadius * 2),
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  child: Skeleton(height: 150, radius: AppConstants.defaultBorderRadius / 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}