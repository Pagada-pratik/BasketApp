import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class BannerMWithCounterSkeleton extends StatelessWidget {
  const BannerMWithCounterSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 2),
      child: AspectRatio(
        aspectRatio: 1.87,
        child: Stack(
          children: [
            const Skeleton(radius: 0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Skeleton(
                  width: 200,
                  height: 24,
                ),
                const SizedBox(height: AppConstants.defaultPadding / 2),
                const Skeleton(
                  width: 160,
                  height: 24,
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (_) => const Padding(
                      padding: EdgeInsets.only(right: AppConstants.defaultPadding / 2),
                      child: Skeleton(
                        height: 40,
                        width: 40,
                        radius: AppConstants.defaultPadding / 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}