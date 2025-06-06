import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/cart_button.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../components/network_image_with_loader.dart';
import '../../controllers/cart/product_cart_controller.dart';
import '../../controllers/product/product_details_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/wishlist/wishlist_controller.dart';
import '../../models/product_guest_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../resources/product_colors.dart';
import '../../resources/web_url.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/parse_values.dart';
import 'added_to_cart_message_view.dart';
import 'components/product_list_tile.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/unit_price.dart';

class ProductBuyNowView extends StatefulWidget {
  final List<dynamic> productData;
  final bool isProductInCart;
  const ProductBuyNowView({super.key, required this.productData, required this.isProductInCart});

  @override
  _ProductBuyNowViewState createState() => _ProductBuyNowViewState();
}

class _ProductBuyNowViewState extends State<ProductBuyNowView> {
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  ProfileController profileController = Get.put(ProfileController());
  WishlistController wishlistController = Get.put(WishlistController());
  ProductCartController productCartController = Get.put(ProductCartController());
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    productCartController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> colorOptions = ProductColors().getColorOptions(widget.productData[0]);
    List<Color> availableColors = ProductColors().getMappedColors(colorOptions);

    return Scaffold(
      bottomNavigationBar: Obx(() => CartButton(
        price: ParseValues.parsePrice(widget.productData[0]['price'])*productDetailsController.quantityCount.value,
        title: "Add to cart",
        subTitle: "Total price",
        press: () async {
          if(profileController.userId.isEmpty){
            await { userController.addProductToList(ProductGuestModel(id: widget.productData[0]['id'].toString(), quantity: productDetailsController.quantityCount.value)),
              customModalBottomSheet(
                context,
                isDismissible: false,
                child: const AddedToCartMessageView(),
                )
            };
          } else {
            await productCartController.addProductToCartApiResponse(
                widget.productData[0]['id'].toString(),
                productDetailsController.quantityCount.value.toString(),
                context);
          }
        },
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding / 2, vertical: AppConstants.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Flexible(
                  child: Text(
                    widget.productData[0]['name'],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    wishlistController.isProductWishlist.value = !wishlistController.isProductWishlist.value;
                    (wishlistController.isProductWishlist.value)
                        ? wishlistController.addProductToWishlistResponse(profileController.userId.toString(), widget.productData[0]['id'].toString(), context)
                        : wishlistController.removeProductToWishlistResponse(profileController.userId.toString(), widget.productData[0]['id'].toString(), context);
                  },
                  icon: Obx(() => SvgPicture.asset(
                    (!wishlistController.isProductWishlist.value) ? "assets/icons/heart.svg" : "assets/icons/heart-filled.svg",
                    color: (!wishlistController.isProductWishlist.value) ? Theme.of(context).textTheme.bodyLarge!.color : AppColors.errorColor,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(widget.productData[0]['images'][0]['src']),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: ParseValues.parsePrice(widget.productData[0]['regular_price']),
                            priceAfterDiscount: ParseValues.parsePrice(widget.productData[0]['price']),
                          ),
                        ),
                        Obx(() => ProductQuantity(
                          numOfItem: productDetailsController.quantityCount.value,
                          onIncrement: () {
                            productDetailsController.incrementQuantityCount(widget.productData[0]['stock_quantity']);
                          },
                          onDecrement: () {
                            productDetailsController.decrementQuantityCount();
                          },
                        )),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                if (colorOptions.isNotEmpty)
                SliverToBoxAdapter(
                  child: Obx(() => SelectedColors(
                    colors: availableColors,
                    selectedColorIndex: productDetailsController.selectedColorsIndex.value,
                    press: (value) {
                      productDetailsController.selectedColors(value);
                      Get.delete<ProductDetailsController>();
                      Navigator.pushNamed(
                        context,
                        RoutesName.productDetailsScreen,
                        arguments: {
                          'productId': widget.productData[0]['variations'][value],
                          'categoryId': widget.productData[0]['categories'][value]['id'],
                        },
                      );
                    },
                  )),
                ),

                // SliverToBoxAdapter(
                //   child: SelectedSize(
                //     sizes: const ["S", "M", "L", "XL", "XXL"],
                //     selectedIndex: 1,
                //     press: (value) {},
                //   ),
                // ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
                //   sliver: ProductListTile(
                //     title: "Size guide",
                //     svgSrc: "assets/icons/Sizeguid.svg",
                //     isShowBottomBorder: true,
                //     press: () {
                //       // customModalBottomSheet(
                //       //   context,
                //       //   height: MediaQuery.of(context).size.height * 0.9,
                //       //   child: const SizeGuideView(),
                //       // );
                //     },
                //   ),
                // ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.defaultPadding),
                        Text(
                          "Store pickup availability",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppConstants.defaultPadding / 2),
                        const Text("Check store availability and In-Store pickup options."),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
                  sliver: ProductListTile(
                    title: "Check stores",
                    svgSrc: "assets/icons/Stores.svg",
                    isShowBottomBorder: true,
                    press: () {
                      profileController.launchWebUrl(WebUrl.storeListingUrl);
                      // customModalBottomSheet(
                      //   context,
                      //   height: MediaQuery.of(context).size.height * 0.92,
                      //   child: const LocationPermissionStoreAvailabilityView(),
                      // );
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: AppConstants.defaultPadding)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}