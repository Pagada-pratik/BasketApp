import 'package:flutter/material.dart';

import '../../../components/banner/L/banner_l_style_1.dart';

class SaleOfferBanner extends StatefulWidget {
  const SaleOfferBanner({super.key});

  @override
  State<SaleOfferBanner> createState() => _SaleOfferBannerState();
}

class _SaleOfferBannerState extends State<SaleOfferBanner> {
  @override
  Widget build(BuildContext context) {
    return BannerLStyle1(
      title: "Products\nOn Sale",
      subtitle: "Special Offer",
      discountPercent: 20,
      press: () {
        // Navigator.pushNamed(context, onSaleScreenRoute);
      },
    );
  }
}