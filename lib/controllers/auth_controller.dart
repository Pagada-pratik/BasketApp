// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../utils/ars_progress_dialog.dart';
import '../utils/message_utils.dart';
import 'profile_controller.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  UserController userController = Get.put(UserController());
  ProfileController profileController = Get.put(ProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  final myRepo = AuthRepository();
  late ArsProgressDialog progressDialog;
  RxBool isObscureForLogin = true.obs;
  RxBool isObscureForRegister = true.obs;

  var registerUsernameController = TextEditingController().obs;
  var registerEmailController = TextEditingController().obs;
  var registerPasswordController = TextEditingController().obs;
  RxBool isUserCustomer = true.obs;

  void showHidePasswordForLogin(bool value) {
    isObscureForLogin.value = value;
  }

  void showHidePasswordForRegister(bool value) {
    isObscureForRegister.value = value;
  }

  void setUserCustomer(bool value) {
    isUserCustomer.value = value;
  }

  Future<void> loginApiResponse(String username, String password, BuildContext context) async {
    progressDialog.show();
    final params = {
      "username": username,
      "password": password,
    };
    myRepo.loginApiCall(params).then((value) {
      userController.saveUser(
        UserModel(
          token: value['token'].toString(),
          userEmail: value['user_email'].toString(),
          userNickname: value['user_nicename'].toString(),
          userDisplayName: value['user_display_name'].toString(),
        ),
      );
    }).then((_) {
      myRepo.getCurrentUserApiCall().then((value) {
        userController.saveCurrentUserData(
          CurrentUserModel(
            id: value['id'].toString(),
            description: value['description'].toString(),
          ),
        );
        progressDialog.dismiss();
        Get.back();
        MessageUtils.flushBarErrorMessage("User Login Successful!", context);
        profileController.displayUserData(context, false);
      });
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> registerApiResponse(String username, String email, String password, bool isCustomer, BuildContext context) async {
    progressDialog.show();
    final params = {
      "username": username,
      "email": email,
      "password": password,
      "customer": isCustomer,
    };
    myRepo.registerApiCall(params).then((value) {
      userController.saveUser(
        UserModel(
          token: value['token'].toString(),
          userEmail: value['user_email'].toString(),
          userNickname: value['user_nicename'].toString(),
          userDisplayName: value['user_display_name'].toString(),
        ),
      );
    }).then((_) {
      myRepo.getCurrentUserApiCall().then((value) {
        userController.saveCurrentUserData(
          CurrentUserModel(
            id: value['id'].toString(),
            description: value['description'].toString(),
          ),
        );
        progressDialog.dismiss();
        Get.back();
        Get.back();
        MessageUtils.flushBarErrorMessage("User Register Successful!", context);
        profileController.displayUserData(context, false);
      });
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}