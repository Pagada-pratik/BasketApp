// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/profile_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../profile_controller.dart';

class ProfileUpdateController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  late ArsProgressDialog progressDialog;
  final myProfileRepo = ProfileRepository();
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var nicknameController = TextEditingController().obs;

  Future<void> updateUserProfileApiResponse(BuildContext context, String userID) async {
    progressDialog.show();
    final Map<String, dynamic> params = {
      "first_name": firstNameController.value.text,
      "last_name": lastNameController.value.text,
      "nickname": nicknameController.value.text,
      "email": emailController.value.text,
      // "description": descriptionController.value.text,
    };
    myProfileRepo.updateUserProfileApiCall(params, userID).then((value) async {
      progressDialog.dismiss();
      Get.back();
      await profileController.getUserProfileAndAddressApiResponse(context, profileController.userId.toString());
      MessageUtils.flushBarErrorMessage(
        "Profile details updated successfully.",
        context,
      );
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
        "Something went wrong. Please try again later.",
        context,
      );
    });
  }
}