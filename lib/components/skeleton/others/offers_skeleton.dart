import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class OffersSkeleton extends StatelessWidget {
  const OffersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade900,
        highlightColor: Colors.grey.shade100,
        period: const Duration(seconds: 2),
        child: Stack(
          children: [
            const Skeleton(),
            const Positioned.fill(
              left: AppConstants.defaultPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    width: 140,
                    height: 20,
                  ),
                  SizedBox(height: AppConstants.defaultPadding / 2),
                  Skeleton(
                    width: 200,
                    height: 20,
                  ),
                ],
              ),
            ),
            Positioned(
              right: AppConstants.defaultPadding,
              bottom: AppConstants.defaultPadding,
              child: Row(
                children: List.generate(
                  4, (index) => const Padding(
                    padding: EdgeInsets.only(left: AppConstants.defaultPadding / 4),
                    child: CircleSkeleton(size: 8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}