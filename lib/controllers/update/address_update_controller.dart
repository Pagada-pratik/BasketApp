// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/profile_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../profile_controller.dart';

class AddressUpdateController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  late ArsProgressDialog progressDialog;
  final myProfileRepo = ProfileRepository();
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var companyController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  var postcodeController = TextEditingController().obs;
  var countryController = TextEditingController().obs;
  var stateController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;

  Future<void> updateUserAddressApiResponse(BuildContext context, String userID) async {
    progressDialog.show();
    final Map<String, dynamic> params = {
      "billing": {
        "first_name": firstNameController.value.text,
        "last_name": lastNameController.value.text,
        "company": companyController.value.text,
        "address_1": addressController.value.text,
        "address_2": '',
        "city": cityController.value.text,
        "postcode": postcodeController.value.text,
        "country": countryController.value.text,
        "state": stateController.value.text,
        "email": emailController.value.text,
        "phone": phoneNumberController.value.text,
      },
    };
    myProfileRepo.updateUserAddressApiCall(params, userID).then((value) async {
      progressDialog.dismiss();
      Get.back();
      await profileController.getUserProfileAndAddressApiResponse(context, profileController.userId.toString());
      MessageUtils.flushBarErrorMessage(
        "Address details updated successfully.",
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