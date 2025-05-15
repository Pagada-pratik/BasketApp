import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../controllers/profile_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../routes/routes_name.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.proLableText = "Pro",
    this.isPro = false,
    this.press,
    this.isShowHi = true,
    this.isShowArrow = true,
  });

  final String name, email, imageSrc;
  final String proLableText;
  final bool isPro, isShowHi, isShowArrow;
  final VoidCallback? press;
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => (profileController.userToken.toString() != 'null') ?
    ListTile(
      onTap: press,
      leading: CircleAvatar(
        radius: 28,
        child: NetworkImageWithLoader(
          imageSrc,
          radius: 100,
        ),
      ),
      title: Row(
        children: [
          Text(
            isShowHi ? "Hi, $name" : name,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: AppConstants.defaultPadding / 2),
          if (isPro)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding / 2, vertical: AppConstants.defaultPadding / 4),
              decoration: const BoxDecoration(
                color: AppColors.primaryAppColor,
                borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
              ),
              child: Text(
                proLableText,
                style: const TextStyle(
                  fontFamily: AppConstants.grandisExtendedFont,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.7,
                  height: 1,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(email),
      trailing: isShowArrow
          ? SvgPicture.asset(
        "assets/icons/miniRight.svg",
        color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
      ) : null,
    ) : ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.greyColor,
        child: SvgPicture.asset(
          "assets/icons/User-Remove.svg",
          height: 28,
          width: 28,
          colorFilter: const ColorFilter.mode(
            AppColors.whiteColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.loginScreen);
        },
        child: const Text("Let's, Login Here", style: TextStyle(fontSize: AppConstants.defaultFontSize)),
      ),
    ));
  }
}