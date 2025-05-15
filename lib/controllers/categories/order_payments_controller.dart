// ignore_for_file: use_build_context_synchronously
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../repositories/checkout_repository.dart';
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

    final Map<String, dynamic> orderData = {
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
    };

    myCheckoutRepo.createOrderApiCall(orderData).then((value) async {
      progressDialog.dismiss();
      if (setPaid || cod) {
        customModalBottomSheet(
          context,
          isDismissible: false,
          child: const CheckoutMessageView(),
        ).then((_) async {
          await productCartController.clearCartApiResponse(context);
          await productCartController.getCartForUserApiResponse(context);
          Get.delete<CheckoutFormController>();
          Get.delete<OrderPaymentsController>();
        });
      } else {
        customModalBottomSheet(context,
            isDismissible: false, child: const CheckOutMessageFail());
      }
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage(
        "Something went wrong. Please try again later.",
        context,
      );
    });
  }
}
