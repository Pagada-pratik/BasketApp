import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';
import '../../../controllers/update/change_pw_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';

class ChangePwView extends StatefulWidget {
  const ChangePwView({super.key});

  @override
  State<ChangePwView> createState() => _ChangePwViewState();
}

class _ChangePwViewState extends State<ChangePwView> {
  final _formKey = GlobalKey<FormState>();
  ChangePwController changePwController =  Get.put(ChangePwController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    changePwController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
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
        title: const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Old Password :"),
                    const SizedBox(height: 2),
                    Obx(() => TextFormField(
                      controller: changePwController.oldPwController.value,
                      validator: AppConstants.passwordValidator.call,
                      cursorColor: AppColors.primaryAppColor,
                      obscureText: changePwController.isObscureForOldPw.value,
                      decoration: InputDecoration(
                        hintText: "Enter old password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            changePwController.showHideOldPassword(!changePwController.isObscureForOldPw.value);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                            child: changePwController.isObscureForOldPw.value ? SvgPicture.asset(
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
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("New Password :"),
                    const SizedBox(height: 2),
                    Obx(() => TextFormField(
                      controller: changePwController.newPwController.value,
                      validator: AppConstants.passwordValidator.call,
                      cursorColor: AppColors.primaryAppColor,
                      obscureText: changePwController.isObscureForNewPw.value,
                      decoration: InputDecoration(
                        hintText: "Enter new password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            changePwController.showHideNewPassword(!changePwController.isObscureForNewPw.value);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                            child: changePwController.isObscureForNewPw.value ? SvgPicture.asset(
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
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Confirm Password :"),
                    const SizedBox(height: 2),
                    Obx(() => TextFormField(
                      controller: changePwController.confirmPwController.value,
                      validator: AppConstants.passwordValidator.call,
                      cursorColor: AppColors.primaryAppColor,
                      obscureText: changePwController.isObscureForConfirmPw.value,
                      decoration: InputDecoration(
                        hintText: "Enter confirm password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            changePwController.showHideConfirmPassword(!changePwController.isObscureForConfirmPw.value);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                            child: changePwController.isObscureForConfirmPw.value ? SvgPicture.asset(
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              changePwController.changePwApiResponse(
                  context, profileController.userId.toString());
            }
          },
          child: const Text(
            "Update",
            style: TextStyle(fontSize: AppConstants.defaultFontSize),
          ),
        ),
      ),
    );
  }
}
