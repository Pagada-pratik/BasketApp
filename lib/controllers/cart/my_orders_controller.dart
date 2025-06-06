import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/my_order_model.dart';
import '../../repositories/checkout_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../profile_controller.dart';

class MyOrdersController extends GetxController {
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  var orders = <OrderModel>[].obs;
  RxBool isDataSuccess = false.obs;
  ProfileController profileController = Get.put(ProfileController());
  Future<String> getGuestEmailIdData() => UserController().getGuestEmailId();

  Future<void> getMyOrdersApiResponse(BuildContext context, String userId) async {
    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    /*String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      return;
    }*/

    progressDialog.show();

    if (profileController.userId.isNotEmpty) {
      try {
        final response = await myCheckoutRepo.getMyOrdersApiCall(userId);
        final List<dynamic> jsonData = response;
        // orders.value = jsonData.map((e) => OrderModel.fromJson(e)).toList();
        List<OrderModel> ordersList = jsonData.map((e) => OrderModel.fromJson(e)).toList();
        orders.clear();
        for (int i = 0; i < ordersList.length; i++) {
          if(ordersList[i].parentId == 0) {
            orders.add(ordersList[i]);
          }
        }
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      } finally {
        progressDialog.dismiss();
      }
    } else {
      try {
        await getGuestEmailIdData().then((value) async {
          print("Api -=-==->>"+ value);
          final response = await myCheckoutRepo.getGuestOrdersApiCall(value);
          final List<dynamic> jsonData = response;
          // orders.value = jsonData.map((e) => OrderModel.fromJson(e)).toList();
          List<OrderModel> ordersList = jsonData.map((e) => OrderModel.fromJson(e)).toList();
          orders.clear();
          for (int i = 0; i < ordersList.length; i++) {
            if(ordersList[i].parentId == 0) {
              orders.add(ordersList[i]);
            }
          }
        }).onError((error, stackTrace) {
          print("Api -=-==->>error");
          // progressDialog.dismiss();
          print(error.toString());
        });

      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      } finally {
        progressDialog.dismiss();
      }
    }

  }
}