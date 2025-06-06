// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/profile_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../profile_controller.dart';

class ChangePwController extends GetxController {
  // ProfileController profileController = Get.put(ProfileController());
  late ArsProgressDialog progressDialog;
  final myProfileRepo = ProfileRepository();

  RxBool isObscureForOldPw = true.obs;
  RxBool isObscureForNewPw = true.obs;
  RxBool isObscureForConfirmPw = true.obs;

  var oldPwController = TextEditingController().obs;
  var newPwController = TextEditingController().obs;
  var confirmPwController = TextEditingController().obs;

  void showHideOldPassword(bool value) {
    isObscureForOldPw.value = value;
  }
  void showHideNewPassword(bool value) {
    isObscureForNewPw.value = value;
  }
  void showHideConfirmPassword(bool value) {
    isObscureForConfirmPw.value = value;
  }

  Future<void> changePwApiResponse(BuildContext context, String userID) async {
    progressDialog.show();
    final Map<String, dynamic> params = {
      "user_id": userID,
      "old_password": oldPwController.value.text,
      "new_password": newPwController.value.text,
      "confirm_password": confirmPwController.value.text,
    };
    myProfileRepo.changePasswordApiCall(params, userID).then((value) async {
      progressDialog.dismiss();
      Get.back();
      // await profileController.getUserProfileAndAddressApiResponse(context, profileController.userId.toString());
      MessageUtils.flushBarErrorMessage(
        "Your password has been updated.",
        context,
      );
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
        error.toString(),
        context,
      );
    });
  }
}