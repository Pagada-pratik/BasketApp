import 'package:flutter/material.dart';

import '../../../resources/constants.dart';
import 'sale_categories.dart';
import 'sale_offer_banner.dart';

class SaleOffersAndCategories extends StatelessWidget {
  final List subCategory;
  final int categoryIndex;
  const SaleOffersAndCategories(this.subCategory, this.categoryIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SaleOfferBanner(),
        const SizedBox(height: AppConstants.defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SaleCategories(subCategory, categoryIndex),
      ],
    );
  }
}