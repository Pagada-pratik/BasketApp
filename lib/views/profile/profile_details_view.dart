import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/widgets/rich_text.dart';
import '../../controllers/profile_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import 'components/profile_card.dart';

class ProfileDetailsView extends StatelessWidget {
  ProfileDetailsView({super.key});
  ProfileController profileController = Get.put(ProfileController());

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
        title: const Text("Profile"),
      ),

      body: Obx(() => ListView(
        children: [
          ProfileCard(
            name: profileController.userName.value,
            email: profileController.userEmail.value,
            imageSrc: profileController.avtarImg.value,
            isShowArrow: false,
            isShowHi: false,
          ),
          const SizedBox(height: AppConstants.defaultBorderRadius),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Details",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
                IconButton(
                  tooltip: "Edit",
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.profileUpdateScreen);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Edit Square.svg",
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryAppColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppConstants.defaultPadding, right: AppConstants.defaultPadding),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: AppColors.greyColor10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  side: const BorderSide(width: 1, color: AppColors.greyColor20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultBorderRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRich(
                        textOne: 'Name : ',
                        textTwo: '${profileController.firstName.value} ${profileController.lastName.value}',
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Username : ',
                        textTwo: profileController.userName.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Email : ',
                        textTwo: profileController.profileEmail.value,
                      ),
                      // const Divider(height: 30),
                      // TextRich(
                      //   textOne: 'Description : ',
                      //   textTwo: profileController.userDescription.value,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultBorderRadius),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Billing Address",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
                IconButton(
                  tooltip: "Edit",
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.addressUpdateScreen);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Edit Square.svg",
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryAppColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppConstants.defaultPadding, right: AppConstants.defaultPadding, bottom: AppConstants.defaultPadding),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: AppColors.greyColor10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                  side: const BorderSide(width: 1, color: AppColors.greyColor20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultBorderRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRich(
                        textOne: 'Name : ',
                        textTwo: '${profileController.addressFN.value} ${profileController.addressLN.value}',
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Company : ',
                        textTwo: profileController.company.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Address : ',
                        textTwo: profileController.address.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'City : ',
                        textTwo: profileController.city.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Postcode : ',
                        textTwo: profileController.postcode.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Country : ',
                        textTwo: profileController.country.value,
                      ),
                      const Divider(height: 30),
                      // TextRich(
                      //   textOne: 'State : ',
                      //   textTwo: profileController.state.value,
                      // ),
                      // const Divider(height: 30),
                      TextRich(
                        textOne: 'Business Email : ',
                        textTwo: profileController.addressEmail.value,
                      ),
                      const Divider(height: 30),
                      TextRich(
                        textOne: 'Phone : ',
                        textTwo: profileController.phoneNumber.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}