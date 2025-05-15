import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: authController.registerUsernameController.value,
            validator: AppConstants.usernameValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.primaryAppColor,
            decoration: InputDecoration(
              hintText: "Username",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Profile.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          TextFormField(
            controller: authController.registerEmailController.value,
            validator: AppConstants.emailIdValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.primaryAppColor,
            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Message.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Obx(() => TextFormField(
            controller: authController.registerPasswordController.value,
            validator: AppConstants.passwordValidator.call,
            cursorColor: AppColors.primaryAppColor,
            obscureText: authController.isObscureForRegister.value,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  authController.showHidePasswordForRegister(!authController.isObscureForRegister.value);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                  child: authController.isObscureForRegister.value ? SvgPicture.asset(
                    "assets/icons/Show.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                  ) : SvgPicture.asset(
                    "assets/icons/Hide.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}