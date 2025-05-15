import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import 'product_card_skeleton.dart';

class ProductsSkeleton extends StatelessWidget {
  const ProductsSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: index == 4 ? AppConstants.defaultPadding : 0,
          ),
          child: const ProductCardSkeleton(),
        ),
      ),
    );
  }
}