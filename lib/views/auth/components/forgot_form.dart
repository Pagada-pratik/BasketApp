import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class ForgotForm extends StatelessWidget {
  ForgotForm({
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
            controller: authController.forgotEmailController.value,
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
        ],
      ),
    );
  }
}