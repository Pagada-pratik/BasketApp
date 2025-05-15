import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/my_order_model.dart';
import '../../repositories/checkout_repository.dart';
import '../../utils/ars_progress_dialog.dart';

class MyOrdersController extends GetxController {
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  var orders = <OrderModel>[].obs;
  RxBool isDataSuccess = false.obs;

  Future<void> getMyOrdersApiResponse(BuildContext context, String userId) async {
    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      return;
    }

    progressDialog.show();

    try {
      final response = await myCheckoutRepo.getMyOrdersApiCall(userId);
      final List<dynamic> jsonData = response;
      orders.value = jsonData.map((e) => OrderModel.fromJson(e)).toList();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    } finally {
      progressDialog.dismiss();
    }
  }
}