// ignore_for_file: use_build_context_synchronously
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../controllers/cart/product_cart_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/wishlist/wishlist_controller.dart';
import '../resources/app_colors.dart';
import '../resources/constants.dart';
import '../routes/routes_name.dart';
import '../utils/ars_progress_dialog.dart';
import '../utils/custom_loading.dart';
import 'categories/categories_view.dart';
import 'checkout/cart_view.dart';
import 'home/home_view.dart';
import 'profile/profile_view.dart';
import 'wishlist/wishlist_view.dart';

class EntryPointView extends StatefulWidget {
  const EntryPointView({super.key});

  @override
  State<EntryPointView> createState() => _EntryPointViewState();
}

class _EntryPointViewState extends State<EntryPointView> {
  ProfileController profileController = Get.put(ProfileController());
  WishlistController wishlistController = Get.put(WishlistController());
  ProductCartController productCartController = Get.put(ProductCartController());

  final List _pages = const [
    HomeView(),
    CategoriesView(),
    WishlistView(),
    CartView(),
    ProfileView(),
  ];
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = Get.arguments?['initialIndex'] ?? 0;

    profileController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await wishlistController.getWishlistApiResponse(context, profileController.userId.toString());
      await productCartController.getCartForUserApiResponse(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // pinned: true,
        // floating: true,
        // snap: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: Image.asset(AppConstants.appLogo, width: Get.width * .35),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.searchScreen);
            },
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, notificationsScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
      // body: _pages[_currentIndex],
      body: PageTransitionSwitcher(
        duration: AppConstants.defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: AppConstants.defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: AppColors.primaryAppColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/home.svg"),
              activeIcon: svgIcon("assets/icons/home.svg", color: AppColors.primaryAppColor),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Category.svg"),
              activeIcon: svgIcon("assets/icons/Category.svg", color: AppColors.primaryAppColor),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Obx(() => badges.Badge(
                showBadge: (wishlistController.totalWishlistCount.value.isEmpty) ? false : true,
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeContent: Text(
                  wishlistController.totalWishlistCount.value,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: (wishlistController.totalWishlistCount.value.length < 2) ? 12 : (wishlistController.totalWishlistCount.value.length < 3) ? 9 : 8,
                  ),
                ),
                position: badges.BadgePosition.topEnd(
                  top: (wishlistController.totalWishlistCount.value.length < 2) ? -11 : -10,
                  end: (wishlistController.totalWishlistCount.value.length < 2) ? -7 : (wishlistController.totalWishlistCount.value.length < 3) ? -8 : -9,
                ),
                child: svgIcon("assets/icons/heart.svg"),
              )),
              activeIcon: Obx(() => badges.Badge(
                showBadge: (wishlistController.totalWishlistCount.value.isEmpty) ? false : true,
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeContent: Text(
                  wishlistController.totalWishlistCount.value,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: (wishlistController.totalWishlistCount.value.length < 2) ? 12 : (wishlistController.totalWishlistCount.value.length < 3) ? 9 : 8,
                  ),
                ),
                position: badges.BadgePosition.topEnd(
                  top: (wishlistController.totalWishlistCount.value.length < 2) ? -11 : -10,
                  end: (wishlistController.totalWishlistCount.value.length < 2) ? -7 : (wishlistController.totalWishlistCount.value.length < 3) ? -8 : -9,
                ),
                child: svgIcon("assets/icons/heart.svg", color: AppColors.primaryAppColor),
              )),
              label: "Wishlist",
            ),
            BottomNavigationBarItem(
              icon: Obx(() => badges.Badge(
                showBadge: (productCartController.itemCount.value == '0') ? false : true,
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeContent: Text(
                  productCartController.itemCount.value.toString(),
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: (productCartController.itemCount.value.length < 2) ? 12 : (productCartController.itemCount.value.length < 3) ? 9 : 8,
                  ),
                ),
                position: badges.BadgePosition.topEnd(
                  top: (productCartController.itemCount.value.length < 2) ? -11 : -10,
                  end: (productCartController.itemCount.value.length < 2) ? -7 : (productCartController.itemCount.value.length < 3) ? -8 : -9,
                ),
                child: svgIcon("assets/icons/Bag.svg"),
              )),
              activeIcon: Obx(() => badges.Badge(
                showBadge: (productCartController.itemCount.value == '0') ? false : true,
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeContent: Text(
                  productCartController.itemCount.value.toString(),
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: (productCartController.itemCount.value.length < 2) ? 12 : (productCartController.itemCount.value.length < 3) ? 9 : 8,
                  ),
                ),
                position: badges.BadgePosition.topEnd(
                  top: (productCartController.itemCount.value.length < 2) ? -11 : -10,
                  end: (productCartController.itemCount.value.length < 2) ? -7 : (productCartController.itemCount.value.length < 3) ? -8 : -9,
                ),
                child: svgIcon("assets/icons/Bag.svg", color: AppColors.primaryAppColor),
              )),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon: svgIcon("assets/icons/Profile.svg", color: AppColors.primaryAppColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}