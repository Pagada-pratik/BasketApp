import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/product/product_card.dart';
import '../../components/skeleton/product/wishlist_skeleton.dart';
import '../../controllers/search/search_controller.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../entry_point_view.dart';
import 'components/search_form.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchProductController searchProductController =
  Get.put(SearchProductController());

  @override
  void initState() {
    super.initState();

    searchProductController.getAllProductsApiResponse(context, 100);
  }

  @override
  void dispose() {
    Get.delete<SearchProductController>();
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
        title: const Text("Search Product"),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: SearchForm(
                  controller: searchProductController.searchController,
                  focusNode: searchProductController.searchFocusNode,
                  onChanged: (query) =>
                      searchProductController.filterProducts(query ?? ''),
                  isFilterAvailable: true,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Our Products",
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
              sliver: Obx(() => searchProductController
                  .filteredProducts.isNotEmpty
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
                    final saleData =
                    searchProductController.filteredProducts[index];
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
                  childCount:
                  searchProductController.filteredProducts.length,
                ),
              )
                  : (!searchProductController.isProductNotFound.value)
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
