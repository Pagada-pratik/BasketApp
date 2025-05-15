import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 2),
      child: const SizedBox(
        height: 220,
        width: 140,
        child: Padding(
          padding: EdgeInsets.all(AppConstants.defaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Skeleton(),
              ),
              Spacer(flex: 2),
              Skeleton(height: 12, width: 64),
              Spacer(flex: 2),
              Skeleton(),
              Spacer(),
              Skeleton(),
              Spacer(flex: 2),
              Skeleton(height: 12, width: 80),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}