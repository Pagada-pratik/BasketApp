import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(right: AppConstants.defaultPadding),
        child: Row(
          children: List.generate(5, (_) => Padding(
            padding: const EdgeInsets.only(left: AppConstants.defaultPadding),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade900,
              highlightColor: Colors.grey.shade100,
              period: const Duration(seconds: 2),
              child: const Skeleton(
                height: 36,
                width: 96,
                radius: 30,
              ),
            ),
          )),
        ),
      ),
    );
  }
}