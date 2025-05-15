// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/views/product/components/toglfle_shared_pref.dart';

import '../../components/cart_button.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../components/product/product_card.dart';
import '../../components/review_card.dart';
import '../../components/skeleton/product/product_details_skeleton.dart';
import '../../components/skeleton/product/products_skeleton.dart';
import '../../controllers/cart/product_cart_controller.dart';
import '../../controllers/product/product_details_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/reviews/review_controller.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../resources/web_url.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';
import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import 'product_buy_now_view.dart';
import 'product_returns_view.dart';

class ProductDetailsView extends StatefulWidget {
  final int productId;
  final int categoryId;

  const ProductDetailsView(
      {super.key, required this.productId, required this.categoryId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  ProfileController profileController = Get.put(ProfileController());
  WishlistController wishlistController = Get.put(WishlistController());
  ProductCartController productCartController = Get.put(ProductCartController());
  ReviewController reviewController = Get.put(ReviewController());
  final NotifyMePrefs notifyMePrefs = NotifyMePrefs();
  RxBool toggleButton = false.obs;

  @override
  void initState() {
    super.initState();
    profileController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    wishlistController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await productDetailsController.getSingleProductDataApiResponse(context, widget.productId);
      await productDetailsController.getRelatedProductsApiResponse(context, widget.categoryId, widget.productId);
      await profileController.displayUserData(context, false);

      if(profileController.userId.isNotEmpty) {
        await wishlistController.checkProductInWishlistResponse(profileController.userId.toString(), widget.productId.toString(), context);
        await productCartController.checkProductInCartApiResponse(widget.productId.toString(), context);
        await reviewController.getReviewByProductIDApiResponse(context, widget.productId.toString());
      }
      toggleButton.value = await notifyMePrefs.contains(widget.productId);
    });
  }

  @override
  void dispose() {
    Get.delete<ProductDetailsController>();
    Get.delete<ReviewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productData = productDetailsController.productData;

    return Scaffold(
      bottomNavigationBar: Obx(() => (productData.isNotEmpty)
          ? (productData[0]['stock_status'] == 'instock')
              ? CartButton(
                  price: ParseValues.parsePrice(productData[0]['price']),
                  press: () {

                    if(profileController.userId.isEmpty) {
                      MessageUtils.flushBarErrorMessage('Login required!', context);
                      return;
                    }

                    customModalBottomSheet(
                      context,
                      height: MediaQuery.of(context).size.height * 0.92,
                      child: ProductBuyNowView(
                          productData: productData,
                          isProductInCart:
                              productCartController.isProductInCart.value),
                    );
                  },
                )
              :

              /// If product is not available then show [NotifyMeCard]
              Obx(() {
                  return NotifyMeCard(
                    isNotify: toggleButton.value,
                    onChanged: (value) async {
                      toggleButton.value = value;
                      if (value) {
                        await notifyMePrefs.add(widget.productId);
                        productCartController.notifyMeResponse(
                          context,
                          widget.productId,
                          int.tryParse(profileController.userId.value) ?? 1,
                        );
                      } else {
                        await notifyMePrefs.remove(widget.productId);
                      }
                    },
                  );
                })
          : const SizedBox()),
      body: Obx(() => (productData.isNotEmpty)
          ? SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    actions: [
                      IconButton(
                        onPressed: () {

                          if(profileController.userId.isEmpty) {
                            MessageUtils.flushBarErrorMessage('Login required!', context);
                            return;
                          }

                          wishlistController.isProductWishlist.value =
                              !wishlistController.isProductWishlist.value;
                          (wishlistController.isProductWishlist.value)
                              ? wishlistController.addProductToWishlistResponse(
                                  profileController.userId.toString(),
                                  widget.productId.toString(),
                                  context)
                              : wishlistController
                                  .removeProductToWishlistResponse(
                                      profileController.userId.toString(),
                                      widget.productId.toString(),
                                      context);
                        },
                        icon: SvgPicture.asset(
                          (!wishlistController.isProductWishlist.value)
                              ? "assets/icons/heart.svg"
                              : "assets/icons/heart-filled.svg",
                          color: (!wishlistController.isProductWishlist.value)
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : AppColors.errorColor,
                        ),
                      ),
                    ],
                  ),
                  ProductImages(
                    images: productData[0]['images'].isEmpty
                        ? ['']
                        : [
                            productData[0]['images'][0]['src'] ?? '',
                            productData[0]['images'][0]['src'] ?? '',
                            productData[0]['images'][0]['src'] ?? ''
                          ],
                  ),
                  Obx(() => ProductInfo(
                        brand: "SKU: ${productData[0]['sku']}",
                        title: productData[0]['name'],
                        isAvailable:
                            (productData[0]['stock_status'] == 'instock')
                                ? true
                                : false,
                        description: (productData[0]['description'] != '')
                            ? ParseValues.stripHtml(
                                productData[0]['description'])
                            : 'Product information not found.',
                        rating: reviewController.averageRating.value.isNaN ||
                                reviewController.averageRating.value.isInfinite
                            ? 0.0
                            : reviewController.averageRating.value,
                        numOfReviews: reviewController.totalReviews.value,
                      )),
                  ProductListTile(
                    svgSrc: "assets/icons/Product.svg",
                    title: "Product Details",
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.92,
                        child: ProductDataView(
                          "Product Details",
                          (productData[0]['description'] != '')
                              ? ParseValues.stripHtml(
                                  productData[0]['description'])
                              : 'Product information not found.',
                        ),
                      );
                    },
                  ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Delivery.svg",
                  //   title: "Shipping Information",
                  //   press: () {
                  //     // customModalBottomSheet(
                  //     //   context,
                  //     //   height: MediaQuery.of(context).size.height * 0.92,
                  //     //   child: const BuyFullKit(
                  //     //     images: ["assets/screens/Shipping information.png"],
                  //     //   ),
                  //     // );
                  //   },
                  // ),
                  ProductListTile(
                    svgSrc: "assets/icons/Return.svg",
                    title: "Returns",
                    isShowBottomBorder: true,
                    press: () {
                      profileController.launchWebUrl(WebUrl.termConditionsUrl);
                      // customModalBottomSheet(
                      //   context,
                      //   height: MediaQuery.of(context).size.height * 0.92,
                      //   child: const ProductDataView(
                      //     "Return",
                      //     "Free pre-paid returns and exchanges for orders shipped to the US. Get refunded faster with easy online returns and print a FREE pre-paid return SmartLabel@ online! Return or exchange any unused or defective merchandise by mail or at one of our US or Canada store locations. Made to order items cannot be canceled, exchange or returned."
                      //   ),
                      // );
                    },
                  ),
                  Obx(() => SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppConstants.defaultPadding),
                          child: ReviewCard(
                            rating:
                                reviewController.averageRating.value.isNaN ||
                                        reviewController
                                            .averageRating.value.isInfinite
                                    ? 0.0
                                    : reviewController.averageRating.value,
                            numOfReviews: reviewController.totalReviews.value,
                            numOfFiveStar: reviewController.fiveStarCount.value,
                            numOfFourStar: reviewController.fourStarCount.value,
                            numOfThreeStar:
                                reviewController.threeStarCount.value,
                            numOfTwoStar: reviewController.twoStarCount.value,
                            numOfOneStar: reviewController.oneStarCount.value,
                          ),
                        ),
                      )),
                  ProductListTile(
                    svgSrc: "assets/icons/Chat.svg",
                    title: "Reviews",
                    isShowBottomBorder: true,
                    press: () async {

                      if(profileController.userId.isEmpty) {
                        MessageUtils.flushBarErrorMessage('Login required!', context);
                        return;
                      }

                      await Navigator.pushNamed(
                        context,
                        RoutesName.reviewsScreen,
                        arguments: {
                          'productData': productData,
                        },
                      );
                      Get.delete<ReviewController>();
                      reviewController.getReviewByProductIDApiResponse(
                          context, widget.productId.toString());
                    },
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "You may also like",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Obx(() => (productDetailsController
                            .getRelatedProducts.isNotEmpty)
                        ? SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productDetailsController
                                          .getRelatedProducts.length >
                                      5
                                  ? 5
                                  : productDetailsController
                                      .getRelatedProducts.length,
                              itemBuilder: (context, index) {
                                int itemCount = productDetailsController
                                            .getRelatedProducts.length >
                                        5
                                    ? 5
                                    : productDetailsController
                                        .getRelatedProducts.length;

                                final productData = productDetailsController
                                    .getRelatedProducts[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: AppConstants.defaultPadding,
                                    right: index == itemCount - 1
                                        ? AppConstants.defaultPadding
                                        : 0,
                                  ),
                                  child: ProductCard(
                                    image: productData.image,
                                    brandName: productData.brandName,
                                    title: productData.title,
                                    price: productData.price,
                                    priceAfetDiscount:
                                        productData.priceAfetDiscount,
                                    discountPercent:
                                        productData.discountPercent,
                                    press: () {
                                      Get.delete<ProductDetailsController>();
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.productDetailsScreen,
                                        arguments: {
                                          'productId': productData.productId,
                                          'categoryId': productData.categoryId,
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : (!productDetailsController.isProductNotFound.value)
                            ? const ProductsSkeleton()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? "assets/Illustration/NoResult.png"
                                        : "assets/Illustration/NoResultDarkTheme.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  ),
                                  Text(
                                    "Product not found",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              )),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppConstants.defaultPadding),
                  ),
                ],
              ),
            )
          : const ProductDetailsSkeleton()),
    );
  }
}
