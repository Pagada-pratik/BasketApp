import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import '../product/secondary_product_skeleton.dart';
import '../skeleton.dart';

class OrderStatusCardSkeleton extends StatelessWidget {
  const OrderStatusCardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Skeleton(height: 12, width: 100),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
          child: Skeleton(width: 160),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => const CircleSkeleton(size: 28),
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding * 0.75),
        const SizedBox(
          height: 86,
          width: double.infinity,
          child: SecondaryProductSkeleton(
            isSmall: true,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}