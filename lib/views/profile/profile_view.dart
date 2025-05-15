import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/views/checkout/checkout_screen.dart';

import '../../controllers/profile_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../resources/web_url.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await profileController.displayUserData(context, false);
      // await profileController.getUserProfileAndAddressApiResponse(
      //     context, profileController.userId.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Obx(() => ProfileCard(
                name: profileController.userName.value,
                email: profileController.userEmail.value,
                imageSrc: profileController.avtarImg.value,
                // proLableText: "Sliver",
                // isPro: true, if the user is pro
                press: () {
                  Navigator.pushNamed(context, RoutesName.profileDetailsScreen);
                },
              )),

          // Obx(() => (profileController.userToken.toString() != 'null') ?
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: const AspectRatio(
          //       aspectRatio: 1.8,
          //       child: NetworkImageWithLoader("https://i.imgur.com/dz0BBom.png"),
          //     ),
          //   ),
          // ) : const SizedBox()),

          const SizedBox(height: AppConstants.defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding),
            child: Text(
              "General",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.primaryAppColor),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding / 2),
          ProfileMenuListTile(
            text: "My Orders",
            svgSrc: "assets/icons/Order.svg",
            press: () {
              Navigator.pushNamed(context, RoutesName.myOrdersScreen);
            },
          ),
          // ProfileMenuListTile(
          //   text: "Addresses",
          //   svgSrc: "assets/icons/Address.svg",
          //   press: () {
          //     // Navigator.pushNamed(context, addressesScreenRoute);
          //   },
          // ),
          ProfileMenuListTile(
            text: "Term & Conditions",
            svgSrc: "assets/icons/info.svg",
            press: () {
              profileController.launchWebUrl(WebUrl.termConditionsUrl);
            },
          ),
          ProfileMenuListTile(
            text: "About Us",
            svgSrc: "assets/icons/Wishlist.svg",
            press: () {
              profileController.launchWebUrl(WebUrl.aboutUsUrl);
            },
          ),
          ProfileMenuListTile(
            text: "Check Stores",
            svgSrc: "assets/icons/Stores.svg",
            press: () {
              profileController.launchWebUrl(WebUrl.storeListingUrl);
            },
          ),
          // ProfileMenuListTile(
          //   text: "Wallet",
          //   svgSrc: "assets/icons/Wallet.svg",
          //   press: () {
          //     // Navigator.pushNamed(context, walletScreenRoute);
          //   },
          // ),
          // const SizedBox(height: AppConstants.defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding / 2),
          //   child: Text(
          //     "Personalization",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // DividerListTileWithTrailingText(
          //   svgSrc: "assets/icons/Notification.svg",
          //   title: "Notification",
          //   trailingText: "Off",
          //   press: () {
          //     // Navigator.pushNamed(context, enableNotificationScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Preferences",
          //   svgSrc: "assets/icons/Preferences.svg",
          //   press: () {
          //     // Navigator.pushNamed(context, preferencesScreenRoute);
          //   },
          // ),
          // const SizedBox(height: AppConstants.defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding / 2),
          //   child: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // ProfileMenuListTile(
          //   text: "Language",
          //   svgSrc: "assets/icons/Language.svg",
          //   press: () {
          //     // Navigator.pushNamed(context, selectLanguageScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Location",
          //   svgSrc: "assets/icons/Location.svg",
          //   press: () {},
          // ),
          const SizedBox(height: AppConstants.defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
                vertical: AppConstants.defaultPadding / 2),
            child: Text(
              "Help & Support",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.primaryAppColor),
            ),
          ),
          ProfileMenuListTile(
            text: "Get Help",
            svgSrc: "assets/icons/Help.svg",
            press: () {
              profileController.launchWebUrl(WebUrl.contactUrl);
            },
          ),
          Obx(() => ProfileMenuListTile(
                text: "FAQ",
                svgSrc: "assets/icons/FAQ.svg",
                press: () {
                  profileController.launchWebUrl(WebUrl.faqsUrl);
                },
                isShowDivider:
                    (profileController.userToken.toString() != 'null')
                        ? true
                        : false,
              )),

          Obx(() => (profileController.userToken.toString() != 'null')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.defaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                          vertical: AppConstants.defaultPadding / 2),
                      child: Text(
                        "Account",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.primaryAppColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        profileController.logOutProcess(context);
                      },
                      minLeadingWidth: 24,
                      leading: SvgPicture.asset(
                        "assets/icons/Logout.svg",
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.errorColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      title: const Text(
                        "Log Out",
                        style: TextStyle(
                            color: AppColors.errorColor,
                            fontSize: 14,
                            height: 1),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/miniRight.svg",
                        colorFilter: const ColorFilter.mode(
                            AppColors.errorColor, BlendMode.srcIn),
                      ),
                    ),
                  ],
                )
              : const SizedBox()),
        ],
      ),
    );
  }
}
