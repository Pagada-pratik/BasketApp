import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import 'product_card_skeleton.dart';

class WishlistSkeleton extends StatelessWidget {
  const WishlistSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: AppConstants.defaultPadding,
        crossAxisSpacing: AppConstants.defaultPadding,
        childAspectRatio: 0.66,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return const ProductCardSkeleton();
        },
        childCount: 6,
      ),
    );
  }
}