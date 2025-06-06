import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/products_model.dart';
import '../../repositories/product_repository.dart';
import 'dart:developer';
import '../../utils/ars_progress_dialog.dart';

class CompareProductsController extends GetxController {
  late ArsProgressDialog progressDialog;
  final myProductRepo = ProductRepository();
  var products = <ProductsModel>[].obs;
  RxBool isDataSuccess = false.obs;
  RxString productID = ''.obs;
  var productIDs = <String>[].obs;

  Future<void> getCompareProductsApiResponse(BuildContext context, String productID) async {
    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    // productIDs.add("7884");
    // productIDs.add("7912");
    if(token == null || token.isEmpty) {
      return;
    }
    progressDialog.show();

    try {
      final response = await myProductRepo.getCompareProductsApiCall(productIDs);
      final List<dynamic> jsonData = response;
      products.value = jsonData.map((e) => ProductsModel.fromJson(e)).toList();
      log("Compare Products: ${products.length}");
    } catch (error) {
      if (kDebugMode) {
        print("Compare Products error:-$error.toString()");
      }
    } finally {
      log("Compare Products:- ${products.length}");
      progressDialog.dismiss();
    }
  }

}