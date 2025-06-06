import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../../models/cart_model.dart';
import '../../models/product_guest_model.dart';
import '../../repositories/cart_repository.dart';
import '../../repositories/product_repository.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';
import '../../views/product/added_to_cart_message_view.dart';
import '../user_controller.dart';
import 'coupons_controller.dart';

class ProductCartController extends GetxController {
  final myCartRepo = CartRepository();
  final myProductRepo = ProductRepository();

  late ArsProgressDialog progressDialog;
  List<CartItemsModel> getCartData = <CartItemsModel>[].obs;

  var couponController = TextEditingController().obs;
  RxBool isProductInCart = false.obs;
  RxBool isButtonShow = true.obs;
  RxBool isCartEmpty = false.obs;

  RxString cartHash = ''.obs;
  RxString cartKey = ''.obs;
  RxString itemCount = ''.obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble shippingTotal = 0.0.obs;
  RxDouble discountTotal = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxBool refreshPage = false.obs;

  Future<List<ProductGuestModel>> getProductListData() => UserController().getProductList();
  List<ProductGuestModel> productGuestData = <ProductGuestModel>[].obs;
  int productGuestIndex = 0;
  int productQuantity = 0;
  RxString couponAmount = ''.obs;
  RxString couponType = ''.obs;

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
      discountTotal.value += ParseValues.parsePrice(value['totals']['discount_total'] ?? '');
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
      updateCouponValue();
      isCartEmpty.value = cartHash.value == 'No items in cart so no hash';
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> getGuestProductDataClear(BuildContext context) async {
    isCartEmpty.value = true;
    cartHash.value = '';
    cartKey.value = '';
    itemCount.value = '';
    subtotal.value = 0.0;
    shippingTotal.value = 0.0;
    discountTotal.value = 0.0;
    total.value = 0.0;

    getCartData.clear();
    productGuestData.clear();
    productGuestIndex = 0;
    productQuantity = 0;
    subtotal.value = 0.0;
    total.value = 0.0;

    UserController().clearProductToList();
    /*UserController().removeUser().then((value) {
      Get.offAllNamed(RoutesName.entryPointScreen);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      if (kDebugMode) {
        print(error.toString());
      }
    });*/
  }

  Future<void> getGuestProductDataApiResponse(BuildContext context) async {
    getCartData.clear();
    getProductListData().then((value) {
      print("Api -=-==->>");
      print("Api -=-==->>" + value.length.toString());
      productGuestData.clear();
      productGuestIndex = 0;
      productQuantity = 0;
      subtotal.value = 0.0;
      total.value = 0.0;
      productGuestData.addAll(value);
      print(productGuestData.length);
      if(0 < productGuestData.length) {
        progressDialog.show();
        callGuestProductApiResponse(context);
      } else{
        getGuestProductDataClear(context);
      }
    }).onError((error, stackTrace) {
      print("Api -=-==->>error");
        // progressDialog.dismiss();
        print(error.toString());
    });

  }

  Future<void> callGuestProductApiResponse(BuildContext context) async {

    print("Api -=-==->>call>"+ productGuestData.length.toString());
    // print("Api -=-==->>id>" + productGuestData[productGuestIndex].id.toString());
    myProductRepo.getProductsByProductIdApiCall(int.parse(productGuestData[productGuestIndex].id)).then((value) async {
      // productData.add(value);

      // itemCount.value = value['item_count'].toString() ?? '';
      productQuantity = productQuantity + productGuestData[productGuestIndex].quantity;
      itemCount.value = productQuantity.toString();
      // subtotal.value = ParseValues.parsePrice(value['totals']['subtotal'] ?? '');
      subtotal.value = subtotal.value + (ParseValues.parsePrice(value['price'] ?? '') * productGuestData[productGuestIndex].quantity);
      // total.value = ParseValues.parsePrice(value['totals']['total'] ?? '');
      total.value =  total.value + (ParseValues.parsePrice(value['price'] ?? '') * productGuestData[productGuestIndex].quantity);

      getCartData.add(CartItemsModel(
        itemKey: '',
        productId: value['id'] ?? '',
        vendorId: '',
        storeName: value['store']['shop_name'] ?? '',
        vendorName: '',
        name: value['name'] ?? '',
        price: ParseValues.parsePrice(value['price'] ?? ''),
        // quantity: itemsData['quantity']['value'] ?? '',
        quantity: productGuestData[productGuestIndex].quantity,
        minPurchase: -1,
        // maxPurchase: value['stock_quantity'] ?? '',
        maxPurchase: (value['stock_quantity'] != null && value['stock_quantity'].toString() != 'null')
            ? int.tryParse(value['stock_quantity'].toString()) ?? 0
            : 0,
        sku: "SKU: ${value['sku'] ?? ''}",
        imgUrl: (value['images'] != null && value['images'].isNotEmpty)
            ? value['images'][0]['src']
            : '',
        // imgUrl:'https://netinfodemo1.com/wp-content/uploads/Paddle-Board-png-1.png',
      ));

      // isCartEmpty.value = true;
      // cartHash.value = "18986e2bde48ae34b77c07db8bd062d2";
      isCartEmpty.value = cartHash.value == 'No items in cart so no hash';

      productGuestIndex = productGuestIndex + 1;
      print("product--View--end--" + productGuestIndex.toString());
      if(productGuestIndex < productGuestData.length) {
        callGuestProductApiResponse(context);
      } else {
        progressDialog.dismiss();
        updateCouponValue();
      }
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(error.toString(), context);
      if(productGuestIndex < productGuestData.length) {
        productGuestIndex = productGuestIndex + 1;
        callGuestProductApiResponse(context);
      }
    });
  }

  Future<void> updateCouponValue() async {
    if(!isButtonShow.value) {
      double finalCouponAmount = 0;
      if (couponType.value == "percent") {
        finalCouponAmount =
            (total.value * double.parse(couponAmount.value)) /
                100;
      } else {
        finalCouponAmount = double.parse(couponAmount.value);
      }
      discountTotal.value = finalCouponAmount;
    }
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

  Future<void> addProductToCartApiOrderAgainResponse(
      String productId, String quantity, BuildContext context, bool isLast) async {
    progressDialog.show();
    final params = {
      "id": productId,
      "quantity": quantity,
    };
    myCartRepo.addProductToCartApiCall(params).then((value) async {
      progressDialog.dismiss();
      if(isLast) {
        customModalBottomSheet(
          context,
          isDismissible: false,
          child: const AddedToCartMessageView(),
        );
        await getCartForUserApiResponse(context);
      }
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      // MessageUtils.flushBarErrorMessage("Something went wrong please try again later.", context);
      MessageUtils.flushBarErrorMessage(error.toString(), context);
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
