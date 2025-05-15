import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import '../skeleton.dart';

class BannerMSkeleton extends StatelessWidget {
  const BannerMSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 2.56,
      child: Stack(
        children: [
          Skeleton(radius: 0),
          Padding(
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Skeleton(
                  height: 24,
                  width: 200,
                ),
                SizedBox(height: AppConstants.defaultPadding / 2),
                Skeleton(
                  height: 24,
                  width: 160,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}