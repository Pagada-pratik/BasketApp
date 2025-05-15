import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/constants.dart';
import 'product_availability_tag.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
  });

  final String title, brand, description;
  final double rating;
  final int numOfReviews;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brand.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppConstants.defaultPadding / 2),
            Text(
              title,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                ProductAvailabilityTag(isAvailable: isAvailable),
                const Spacer(),
                SvgPicture.asset("assets/icons/Star_filled.svg"),
                const SizedBox(width: AppConstants.defaultPadding / 4),
                Text(
                  "${rating.toStringAsFixed(1)} ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text("($numOfReviews Reviews)")
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              "Product info",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppConstants.defaultPadding / 2),
            Text(
              description,
              style: const TextStyle(height: 1.4),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            const SizedBox(height: AppConstants.defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}