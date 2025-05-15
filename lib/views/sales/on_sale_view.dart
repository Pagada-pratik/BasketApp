import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/product/product_card.dart';
import '../../components/skeleton/product/wishlist_skeleton.dart';
import '../../controllers/sales/sales_view_controller.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../entry_point_view.dart';
import 'components/sale_offer_and_categories.dart';

class OnSaleView extends StatefulWidget {
  final List subCategory;
  final int categoryIndex;
  final int? categoryId;

  const OnSaleView(this.subCategory, this.categoryIndex,
      {this.categoryId = 0, super.key});

  @override
  State<OnSaleView> createState() => _OnSaleViewState();
}

class _OnSaleViewState extends State<OnSaleView> {
  SalesViewController salesViewController = Get.put(SalesViewController());
  bool isCategoryId = false;

  @override
  void initState() {
    super.initState();
    isCategoryId = (widget.categoryId != 0 && widget.categoryId != '');
    salesViewController.salesProductsApiResponse(
        context,
        isCategoryId
            ? widget.categoryId
            : widget.subCategory[widget.categoryIndex].id);
  }

  @override
  void dispose() {
    Get.delete<SalesViewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("On Sale"),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => const EntryPointView(),
                  arguments: {'initialIndex': 3});
            },
            icon: SvgPicture.asset(
              "assets/icons/Bag.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (widget.subCategory.isNotEmpty)
              SliverToBoxAdapter(
                  child: SaleOffersAndCategories(
                      widget.subCategory, widget.categoryIndex)),
            const SliverToBoxAdapter(
                child: SizedBox(height: AppConstants.defaultPadding / 2)),
            SliverPadding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "On Sale Products",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(height: AppConstants.defaultPadding / 3)),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: AppConstants.defaultPadding,
                right: AppConstants.defaultPadding,
                bottom: AppConstants.defaultPadding,
              ),
              sliver: Obx(() => salesViewController
                      .categoriesBaseSalesProducts.isNotEmpty
                  ? SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: AppConstants.defaultPadding,
                        crossAxisSpacing: AppConstants.defaultPadding,
                        childAspectRatio: 0.66,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final saleData = salesViewController
                              .categoriesBaseSalesProducts[index];
                          return ProductCard(
                            image: saleData.image,
                            brandName: saleData.brandName,
                            title: saleData.title,
                            price: saleData.price,
                            priceAfetDiscount: saleData.priceAfetDiscount,
                            discountPercent: saleData.discountPercent,
                            press: () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.productDetailsScreen,
                                arguments: {
                                  'productId': saleData.productId,
                                  'categoryId': saleData.categoryId,
                                },
                              );
                            },
                          );
                        },
                        childCount: salesViewController
                            .categoriesBaseSalesProducts.length,
                      ),
                    )
                  : (!salesViewController.isProductNotFound.value)
                      ? const WishlistSkeleton()
                      : SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Theme.of(context).brightness == Brightness.light
                                    ? "assets/Illustration/NoResult.png"
                                    : "assets/Illustration/NoResultDarkTheme.png",
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              Text(
                                "Product not found",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
