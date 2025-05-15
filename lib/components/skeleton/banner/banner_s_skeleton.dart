import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class BannerSSkeleton extends StatelessWidget {
  const BannerSSkeleton({
    super.key,
    this.isShowCircle = false,
  });

  final bool isShowCircle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 2),
      child: AspectRatio(
        aspectRatio: 2.56,
        child: Stack(
          children: [
            const Skeleton(),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Skeleton(
                          width: 160,
                          height: 24,
                        ),
                        SizedBox(height: AppConstants.defaultPadding / 2),
                        Skeleton(
                          width: 100,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  if (isShowCircle) const CircleSkeleton(size: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}