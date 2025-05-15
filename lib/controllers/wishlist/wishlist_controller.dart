// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product_model.dart';
import '../../repositories/wishlist_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class WishlistController extends GetxController {
  final myWishlistRepo = WishlistRepository();
  late ArsProgressDialog progressDialog;
  List<ProductModel> wishlistAllProducts = <ProductModel>[].obs;
  RxBool isProductWishlist = false.obs;
  RxString totalWishlistCount = ''.obs;
  RxBool isWishlistEmpty = false.obs;

  Future<void> getWishlistApiResponse(BuildContext context, String userId) async {
    wishlistAllProducts.clear();

    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      totalWishlistCount.value = '';
      isWishlistEmpty.value = true;
      return;
    }

    await myWishlistRepo.getWishlistApiCall(userId).then((value) {
      wishlistAllProducts.assignAll(value.map<ProductModel>((item) {
        return ProductModel(
          productId: item['id'],
          categoryId: item['categories'][0]['id'],
          image: item['image_url'] == false ? '' : item['image_url'],
          title: item['name'],
          brandName: "SKU: ${item['sku']}",
          price: ParseValues.parsePrice(item['price']),
          // discountPercent: 20,
        );
      }).toList());
      totalWishlistCount.value = wishlistAllProducts.length.toString();
    }).onError((error, stackTrace) {
      totalWishlistCount.value = '';
      isWishlistEmpty.value = true;
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> addProductToWishlistResponse(String userId, String productId, BuildContext context) async {
    progressDialog.show();
    final params = {
      "user_id": userId,
      "prod_id": productId,
    };
    myWishlistRepo.addProductToWishlistApiCall(params).then((value) async {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(value['message'].toString(), context);
      await getWishlistApiResponse(context, userId);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> removeProductToWishlistResponse(String userId, String productId, BuildContext context) async {
    progressDialog.show();
    final params = {
      "user_id": userId,
      "prod_id": productId,
    };
    myWishlistRepo.removeProductToWishlistApiCall(params).then((value) async {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(value['message'].toString(), context);
      await getWishlistApiResponse(context, userId);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> checkProductInWishlistResponse(String userId, String productId, BuildContext context) async {
    final params = {
      "user_id": userId,
      "prod_id": productId,
    };
    myWishlistRepo.checkProductInWishlistApiCall(params).then((value) {
      isProductWishlist.value = value['data']['status'];
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}