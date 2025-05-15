// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/review_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../profile_controller.dart';

class AddReviewController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myReviewRepo = ReviewRepository();
  late ArsProgressDialog progressDialog;
  var reviewController = TextEditingController().obs;
  RxDouble starRateValue = 0.0.obs;

  void getRateValue(double value) {
    starRateValue.value = value;
  }

  Future<void> createReviewApiResponse(String productId, BuildContext context) async {
    progressDialog.show();
    final params = {
      "product_id": productId,
      "reviewer": profileController.userName.value,
      "reviewer_email": profileController.userEmail.value,
      "review": reviewController.value.text,
      "rating": starRateValue.value.toString(),
    };
    myReviewRepo.createReviewApiCall(params).then((value) {
      progressDialog.dismiss();
      Get.back();
      MessageUtils.flushBarErrorMessage("Review added successfully.", context);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage("Something went wrong please try again later.", context);
    });
  }
}