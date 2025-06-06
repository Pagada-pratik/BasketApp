// ignore_for_file: use_build_context_synchronously
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/user_controller.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../repositories/checkout_repository.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../../views/checkout/components/checkout_message_view.dart';
import '../cart/product_cart_controller.dart';
import '../profile_controller.dart';
import 'checkout_form_controller.dart';

class OrderPaymentsController extends GetxController {
  ProductCartController productCartController = Get.put(ProductCartController());
  CheckoutFormController checkoutFormController = Get.put(CheckoutFormController());
  ProfileController profileController = Get.put(ProfileController());
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  RxString selectedPaymentMethod = "".obs;
  RxString paymentMethod = "".obs;
  RxString paymentMethodTitle = "".obs;

  Future<void> createOrderApiResponse({
    required bool setPaid,
    bool cod = false,
    required BuildContext context,
  }) async {
    progressDialog.show();

    final lineItems = productCartController.getCartData.map((cartItem) {
      return {
        "product_id": cartItem.productId,
        "quantity": int.parse(cartItem.quantity.toString()),
      };
    }).toList();

    List<String> couponLinesList = <String>[];
    var couponLines;
    if(productCartController.couponController.value.text.isNotEmpty) {
      couponLinesList.add(productCartController.couponController.value.text);
      couponLines = couponLinesList.map((code) {
        return {
          "code": code,
        };
      }).toList();
    }

    final Map<String, dynamic> orderData = {

      if(profileController.userId.isNotEmpty)
        "customer_id": profileController.userId.toString(),

      "payment_method": paymentMethod.value.toString(),
      "payment_method_title": paymentMethodTitle.value.toString(),
      "set_paid": setPaid,
      "billing": {
        "first_name": checkoutFormController.firstNameController.value.text,
        "last_name": checkoutFormController.lastNameController.value.text,
        "address_1": checkoutFormController.streetAddressController.value.text,
        "city": checkoutFormController.townCityController.value.text,
        "postcode": checkoutFormController.postcodeZIPController.value.text,
        "country": "Cyprus",
        "email": checkoutFormController.emailController.value.text,
        "phone": checkoutFormController.phoneController.value.text,
      },
      "line_items": lineItems,

      if(0 < couponLinesList.length)
        "coupon_lines": couponLines,
    };

    myCheckoutRepo.createOrderApiCall(orderData).then((value) async {
      progressDialog.dismiss();
      if (setPaid || cod) {
        customModalBottomSheet(
          context,
          isDismissible: false,
          child: const CheckoutMessageView(),
        ).then((_) async {
          if(profileController.userId.isNotEmpty)
          await productCartController.clearCartApiResponse(context);
          if(profileController.userId.isNotEmpty)
          await productCartController.getCartForUserApiResponse(context);

          await productCartController.getGuestProductDataClear(context);
          Get.delete<CheckoutFormController>();
          Get.delete<OrderPaymentsController>();
        });
      } else {
        customModalBottomSheet(context,
            isDismissible: false, child: const CheckOutMessageFail());
      }
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      /*MessageUtils.flushBarErrorMessage(
        "Something went wrong. Please try again later.",
        context,
      );*/
      MessageUtils.flushBarErrorMessage(
        error.toString(),
        context,
      );
    });
  }


  Future<void> updateOrderApiResponse({
    required String myOrderId,
    required BuildContext context,
  }) async {
    progressDialog.show();

    final Map<String, dynamic> orderData = {
      "customer_id": 'processing',
    };

    myCheckoutRepo.updateOrderApiCall(orderData, myOrderId).then((value) async {
      progressDialog.dismiss();
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Payment Successful')),
      );
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
        "Something went wrong. Please try again later.",
        context,
      );
    });
  }

  Future<void> checkUserEmailApiResponse({
    required String email,
    required BuildContext context,
  }) async {
    progressDialog.show();

    myCheckoutRepo.checkUserEmailApiCall(email).then((value) async {
      progressDialog.dismiss();
      if(value['status']){
        MessageUtils.flushBarErrorMessage(
          "User already exists",
          context,
        );
      } else {
        UserController().saveGuestEmailIdData(email);
        Navigator.pushNamed(context, RoutesName.orderPaymentsScreen);
      }
       /*await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(value.)),
      );
      Navigator.pop(context);*/
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
        "Something went wrong. Please try again later.",
        context,
      );
    });
  }
}
