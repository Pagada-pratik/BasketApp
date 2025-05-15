import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class DiscoverCategoriesSkeleton extends StatelessWidget {
  const DiscoverCategoriesSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 2),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const DiscoverCategorySkeleton(),
      ),
    );
  }
}

class DiscoverCategorySkeleton extends StatelessWidget {
  const DiscoverCategorySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding * 0.75),
      child: Row(
        children: [
          Skeleton(
            height: 32,
            width: 32,
            radius: 8,
          ),
          SizedBox(width: AppConstants.defaultPadding),
          Expanded(
            flex: 2,
            child: Skeleton(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}