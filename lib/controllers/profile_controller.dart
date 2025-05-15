// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/widgets/custom_dialog.dart';
import '../models/user_model.dart';
import '../repositories/profile_repository.dart';
import '../resources/app_colors.dart';
import '../routes/routes_name.dart';
import '../utils/ars_progress_dialog.dart';
import 'user_controller.dart';

class ProfileController extends GetxController {
  Future<UserModel> getUserData() => UserController().getUser();

  Future<CurrentUserModel> getCurrentUserData() =>
      UserController().getCurrentUser();
  final myProfileRepo = ProfileRepository();
  late ArsProgressDialog progressDialog;
  RxString userId = ''.obs;
  RxString userToken = ''.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userDescription = ''.obs;

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString profileUserName = ''.obs;
  RxString profileEmail = ''.obs;
  RxString avtarImg = ''.obs;

  RxString addressFN = ''.obs;
  RxString addressLN = ''.obs;
  RxString company = ''.obs;
  RxString address = ''.obs;
  RxString city = ''.obs;
  RxString postcode = ''.obs;
  RxString country = ''.obs;
  RxString state = ''.obs;
  RxString addressEmail = ''.obs;
  RxString phoneNumber = ''.obs;

  void clearValues() {
    userId.value = '';
    userToken.value = '';
    userName.value = '';
    userEmail.value = '';
    userDescription.value = '';
    firstName.value = '';
    lastName.value = '';
    profileUserName.value = '';
    profileEmail.value = '';
    avtarImg.value = '';
    addressFN.value = '';
    addressLN.value = '';
    company.value = '';
    address.value = '';
    city.value = '';
    postcode.value = '';
    country.value = '';
    state.value = '';
    addressEmail.value = '';
    phoneNumber.value = '';
  }

  Future<void> displayUserData(BuildContext context, bool isSplash) async {
    if (!isSplash) {
      progressDialog.show();
    }
    getUserData().then((value) {
      userToken.value = value.token.toString();
      userName.value = value.userDisplayName.toString();
      userEmail.value = value.userEmail.toString();
    }).then((_) async {
      await getCurrentUserData().then((value) async {
        String id = (value.id != null) ? value.id.toString() : '';
        String description =
            (value.description != null) ? value.description.toString() : '';
        userId.value = id;
        userDescription.value = description;
        await getUserProfileAndAddressApiResponse(context, id);
        if (!isSplash) {
          progressDialog.dismiss();
        }
      });
    }).onError((error, stackTrace) {
      if (!isSplash) {
        progressDialog.dismiss();
      }
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> launchWebUrl(String webUrl) async {
    progressDialog.show();
    final Uri url = Uri.parse(webUrl);
    // if (!await launchUrl(url)) {
    //   progressDialog.dismiss();
    //   throw 'Could not launch $url';
    // }
    await launchUrl(
        mode: LaunchMode.inAppBrowserView, Uri.parse(url.toString()));
    progressDialog.dismiss();
  }

  void logOutProcess(BuildContext context) {
    customDialog(
      context,
      svgIconPath: 'assets/icons/Logout.svg',
      svgIconColor: AppColors.errorColor,
      dialogText: 'Are you sure you want to Log out of this account?',
      approveText: 'Log Out',
      onTapForCancel: () {
        Navigator.pop(context);
      },
      onTapForApprove: () {
        Navigator.pop(context);
        clearValues();
        progressDialog.show();
        Future.delayed(const Duration(seconds: 1), () {
          UserController().removeUser().then((value) {
            Get.offAllNamed(RoutesName.entryPointScreen);
          }).onError((error, stackTrace) {
            progressDialog.dismiss();
            if (kDebugMode) {
              print(error.toString());
            }
          });
        });
      },
    );
  }

  Future<void> getUserProfileAndAddressApiResponse(
      BuildContext context, String userId) async {
    myProfileRepo.getUserProfileAndAddressApiCall().then((value) {
      firstName.value = value['first_name'] ?? '';
      lastName.value = value['last_name'] ?? '';
      profileUserName.value = value['username'] ?? '';
      profileEmail.value = value['email'] ?? '';
      avtarImg.value = value['avatar_url'] ?? '';

      addressFN.value = value['billing_address']['first_name'] ?? '';
      addressLN.value = value['billing_address']['last_name'] ?? '';
      company.value = value['billing_address']['company'] ?? '';
      address.value = value['billing_address']['address_1'] ?? '';
      city.value = value['billing_address']['city'] ?? '';
      postcode.value = value['billing_address']['postcode'] ?? '';
      country.value = value['billing_address']['country'] ?? '';
      state.value = value['billing_address']['state'] ?? '';
      addressEmail.value = value['billing_address']['email'] ?? '';
      phoneNumber.value = value['billing_address']['phone'] ?? '';
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
