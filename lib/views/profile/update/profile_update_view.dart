import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';
import '../../../controllers/update/profile_update_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';

class ProfileUpdateView extends StatefulWidget {
  const ProfileUpdateView({super.key});

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  final _formKey = GlobalKey<FormState>();
  ProfileUpdateController profileUpdateController =
      Get.put(ProfileUpdateController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileUpdateController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    profileUpdateController.firstNameController.value.text =
        profileController.firstName.value;
    profileUpdateController.lastNameController.value.text =
        profileController.lastName.value;
    profileUpdateController.nicknameController.value.text =
        profileController.userName.value;
    profileUpdateController.emailController.value.text =
        profileController.userEmail.value;
    // profileUpdateController.descriptionController.value.text = profileController.userDescription.value;
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
        title: const Text("Update Profile"),
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
                    const Text("First name :"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller:
                          profileUpdateController.firstNameController.value,
                      validator: AppConstants.fnValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "First name",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Last name :"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller:
                          profileUpdateController.lastNameController.value,
                      validator: AppConstants.lnValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "Last name",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Username :"),
                    const SizedBox(height: 2),
                    TextFormField(
                      enabled: false,
                      controller:
                          profileUpdateController.nicknameController.value,
                      validator: AppConstants.usernameValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "Username",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Email address :"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: profileUpdateController.emailController.value,
                      validator: AppConstants.emailIdValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.primaryAppColor,
                      decoration: const InputDecoration(
                        hintText: "Email address",
                      ),
                    ),
                    // const SizedBox(height: AppConstants.defaultPadding),
                    // const Text("Description :"),
                    // const SizedBox(height: 2),
                    // TextFormField(
                    //   maxLines: 6,
                    //   minLines: 4,
                    //   controller: profileUpdateController.descriptionController.value,
                    //   validator: AppConstants.reviewValidator.call,
                    //   textInputAction: TextInputAction.next,
                    //   keyboardType: TextInputType.text,
                    //   cursorColor: AppColors.primaryAppColor,
                    //   textCapitalization: TextCapitalization.words,
                    //   decoration: const InputDecoration(
                    //     hintText: "Description",
                    //   ),
                    // ),
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
              profileUpdateController.updateUserProfileApiResponse(
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
