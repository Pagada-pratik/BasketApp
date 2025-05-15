import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import 'secondary_product_skeleton.dart';

class SecondaryProductsSkeleton extends StatelessWidget {
  const SecondaryProductsSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade900,
        highlightColor: Colors.grey.shade100,
        period: const Duration(seconds: 2),
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              bottom: AppConstants.defaultPadding,
            ),
            child: SecondaryProductSkeleton(),
          ),
        ),
      ),
    );
  }
}