import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/complaint_model.dart';
import '../../models/my_order_model.dart';
import '../../repositories/checkout_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';

class OrdersComplaintController extends GetxController {
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  var complaint = <Data>[].obs;
  RxBool isDataSuccess = false.obs;
  var complaintMsgController = TextEditingController().obs;
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;


  Future<void> getOrdersComplaintApiResponse(BuildContext context, String orderId, String productId) async {
    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      return;
    }

    progressDialog.show();

    try {
      final response = await myCheckoutRepo.getOrdersComplaintApiCall(orderId, productId);

      final data = response['data'];
      messages.clear(); // prevent duplicates if refreshed
      for (var item in data) {
        messages.add({
          'text': item['complaint_message'],
          'isMe': true, // customer's message
        });

        for (var reply in item['complaint_reply']) {
          messages.add({
            'text': reply,
            'isMe': false, // admin replies
          });
        }
      }

      final List<dynamic> jsonData = response;
      complaint.value = jsonData.map((e) => ComplaintModel.fromJson(e).data).cast<Data>().toList();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<void> submitComplaintApiResponse(BuildContext context, String orderId, String productId) async {
    progressDialog.show();
    final Map<String, dynamic> params = {
      "order_id": orderId,
      "product_id": productId,
      "message": complaintMsgController.value.text
    };
    myCheckoutRepo.submitComplaintApiCall(params).then((value) async {
      progressDialog.dismiss();
      // Get.back();
      // await profileController.getUserProfileAndAddressApiResponse(context, profileController.userId.toString());

      // Clear the message input
      complaintMsgController.value.clear();

      // Reload complaint messages
      messages.clear();
      await getOrdersComplaintApiResponse(context, orderId, productId);

      MessageUtils.flushBarErrorMessage(
        "Complaint submitted successfully.",
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