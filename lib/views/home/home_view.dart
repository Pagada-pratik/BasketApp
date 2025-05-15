import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/routes/routes_name.dart';

import '../../components/banner/S/banner_s_style_5.dart';
import '../../components/skeleton/banner/banner_s_skeleton.dart';
import '../../controllers/home/section_products_controller.dart';
import '../../resources/constants.dart';
import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SectionProductsController sectionProductsController =
      Get.put(SectionProductsController());

  @override
  void initState() {
    super.initState();
    sectionProductsController.sectionBaseHomeBannerApiResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            const SliverToBoxAdapter(child: PopularProducts()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                  vertical: AppConstants.defaultPadding * 1.5),
              sliver: SliverToBoxAdapter(child: FlashSale()),
            ),
            Obx(() => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.defaultPadding / 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => (sectionProductsController
                                    .productBannerData.isNotEmpty)
                                ? BannerSStyle5(
                                    image: sectionProductsController
                                        .productBannerData[index].bannerImage,
                                    title: sectionProductsController
                                        .productBannerData[index].bannerTitle!,
                                    subtitle: "50% Off",
                                    bottomText: sectionProductsController
                                        .productBannerData[index]
                                        .bannerSubTitle,
                                    press: () {
                                      // Navigator.pushNamed(context, RoutesName.onSaleScreen);
                                    },
                                  )
                                : const BannerSSkeleton()),
                            const SizedBox(
                                height: AppConstants.defaultPadding / 4),
                            BestSellers(
                              sectionProductsController
                                  .productBannerData[index].bannerTitle!,
                              sectionProductsController.productBannerData[index]
                                  .productCategory!.first,
                            ),
                            if (index !=
                                sectionProductsController
                                        .productBannerData.length -
                                    1)
                              const SizedBox(
                                  height: AppConstants.defaultPadding),
                          ],
                        ),
                      );
                    },
                    childCount:
                        sectionProductsController.productBannerData.length,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
