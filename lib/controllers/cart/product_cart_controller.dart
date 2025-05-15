import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../../models/cart_model.dart';
import '../../repositories/cart_repository.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';
import '../../views/product/added_to_cart_message_view.dart';

class ProductCartController extends GetxController {
  final myCartRepo = CartRepository();
  late ArsProgressDialog progressDialog;
  List<CartItemsModel> getCartData = <CartItemsModel>[].obs;
  var couponController = TextEditingController().obs;
  RxBool isProductInCart = false.obs;
  RxBool isButtonShow = false.obs;
  RxBool isCartEmpty = false.obs;

  RxString cartHash = ''.obs;
  RxString cartKey = ''.obs;
  RxString itemCount = ''.obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble shippingTotal = 0.0.obs;
  RxDouble discountTotal = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxBool refreshPage = false.obs;
  @override
  void onInit() {
    super.onInit();
    progressDialog = ArsProgressDialog(Get.context!);
  }

  Future<void> getCartForUserApiResponse(BuildContext context) async {
    getCartData.clear();

    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      isCartEmpty.value = true;
      cartHash.value = '';
      cartKey.value = '';
      itemCount.value = '';
      subtotal.value = 0.0;
      shippingTotal.value = 0.0;
      discountTotal.value = 0.0;
      total.value = 0.0;
      return;
    }

    await myCartRepo.getCartForUserApiCall().then((value) {
      getCartData.clear();
      cartHash.value = value['cart_hash'] ?? '';
      cartKey.value = value['cart_key'] ?? '';
      itemCount.value = value['item_count'].toString() ?? '';
      subtotal.value = ParseValues.parsePrice(value['totals']['subtotal'] ?? '');
      shippingTotal.value = ParseValues.parsePrice(value['totals']['shipping_total'] ?? '');
      discountTotal.value = ParseValues.parsePrice(value['totals']['discount_total'] ?? '');
      total.value = ParseValues.parsePrice(value['totals']['total'] ?? '');

      for (var itemsData in value['items']) {
        getCartData.add(CartItemsModel(
          itemKey: itemsData['item_key'] ?? '',
          productId: itemsData['id'] ?? '',
          vendorId: itemsData['vendor_id'] ?? '',
          storeName: itemsData['store_name'] ?? '',
          vendorName: itemsData['vendor_name'] ?? '',
          name: itemsData['name'] ?? '',
          price: ParseValues.parsePrice(itemsData['price'] ?? ''),
          quantity: itemsData['quantity']['value'] ?? '',
          minPurchase: itemsData['quantity']['min_purchase'] ?? '',
          maxPurchase: itemsData['quantity']['max_purchase'] ?? '',
          sku: "SKU: ${itemsData['meta']['sku'] ?? ''}",
          imgUrl: itemsData['featured_image'] ?? '',
        ));
      }

      isCartEmpty.value = cartHash.value == 'No items in cart so no hash';
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> checkProductInCartApiResponse(
      String productId, BuildContext context) async {
    final params = {
      "product_id": productId,
    };
    myCartRepo.checkProductInCartApiCall(params).then((value) {
      isProductInCart.value = value['data']['status'];
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> addProductToCartApiResponse(
      String productId, String quantity, BuildContext context) async {
    progressDialog.show();
    final params = {
      "id": productId,
      "quantity": quantity,
    };
    myCartRepo.addProductToCartApiCall(params).then((value) async {
      progressDialog.dismiss();
      customModalBottomSheet(
        context,
        isDismissible: false,
        child: const AddedToCartMessageView(),
      );
      await getCartForUserApiResponse(context);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
          "Something went wrong please try again later.", context);
    });
  }

  void showLoadingDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      // Disables closing the dialog when tapped outside
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  Future<void> updateProductInCartApiResponse(
      String itemKay, String quantity, BuildContext context) async {
    final params = {
      "quantity": quantity,
    };
    showLoadingDialog();
    await myCartRepo
        .updateProductInCartApiCall(itemKay, params)
        .then((value) async {
      await getCartForUserApiResponse(context);
      Get.back();
    }).onError((error, stackTrace) {
      Get.back();
      MessageUtils.flushBarErrorMessage(
          "Something went wrong please try again later.", context);
    });
  }

  Future<void> removeProductFromCartApiResponse(
      String itemKay, BuildContext context) async {
    myCartRepo.removeProductFromCartApiCall(itemKay).then((value) async {
      Navigator.pop(context);
      await getCartForUserApiResponse(context);
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(
          "Something went wrong please try again later.", context);
    });
  }

  Future<void> clearCartApiResponse(BuildContext context) async {
    progressDialog.show();
    myCartRepo.clearCartApiCall().then((value) async {
      progressDialog.dismiss();
      await getCartForUserApiResponse(context);
      Get.offAllNamed(RoutesName.entryPointScreen);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
          "Something went wrong please try again later.", context);
    });
  }

  // Future<void> notifyMeResponse(
  //   BuildContext context,
  //   int productID,
  //   int userID,
  // ) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String token = pref.getString('fcmToken')!;
  //   progressDialog.show();
  //   final params = {
  //     "productID": productID,
  //     "firebaseToken": token,
  //     "UserID": userID,
  //   };
  //   myCartRepo.notifyMeApiCall(params).then((value) async {
  //     progressDialog.dismiss();
  //     await getCartForUserApiResponse(context);
  //     Get.offAllNamed(RoutesName.entryPointScreen);
  //   }).onError((error, stackTrace) {
  //     progressDialog.dismiss();
  //     MessageUtils.flushBarErrorMessage(
  //         "Something went wrong please try again later.", context);
  //   });
  // }
  Future<void> notifyMeResponse(
      BuildContext context,
      int productID,
      int userID,
      ) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String? token = pref.getString('fcmToken');

      /// TODO: Disabled this condition as in Huawei devices FCM token will not be generated.
      // if (token == null || token.isEmpty) {
      //   MessageUtils.flushBarErrorMessage("FCM token not found.", context);
      //   return;
      // }

      // progressDialog.show();

      final params = {
        "productID": productID,
        "firebaseToken": token ?? '',
        "UserID": userID,
      };

      await myCartRepo.notifyMeApiCall(params);
      // progressDialog.dismiss();

      // await getCartForUserApiResponse(context);
      // Get.offAllNamed(RoutesName.entryPointScreen);
    } catch (e) {
      // progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
          "Something went wrong please try again later.", context);
      if (kDebugMode) {
        print("NotifyMe Error: $e");
      }
    }
  }

}
