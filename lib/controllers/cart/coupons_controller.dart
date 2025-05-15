// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../../repositories/checkout_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/message_utils.dart';
import '../../views/checkout/components/coupons_reward.dart';
import 'product_cart_controller.dart';

class CouponsController extends GetxController {
  ProductCartController productCartController =
      Get.put(ProductCartController());
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  RxString couponAmount = ''.obs;

  void removeCouponCode(double amount){
    productCartController.discountTotal.value -= amount;
    productCartController.couponController.value.clear();
  }
  Future<double?> validateCoupon(BuildContext context, String couponCode) async {
    progressDialog.show();
    try {
      dynamic response = await myCheckoutRepo.couponsDiscountApiCall();
      progressDialog.dismiss();

      if (response is List) {
        var coupon = response.firstWhere(
          (coupon) => coupon['code'] == couponCode,
          orElse: () => null,
        );

        if (coupon != null) {
          couponAmount.value = coupon['amount'];
          customModalBottomSheet(
            context,
            isDismissible: false,
            child: CouponsReward(discountAmount: coupon['amount']),
          ).then((_) async {
            productCartController.discountTotal.value +=
                double.parse(coupon['amount']);
            // productCartController.couponController.value.clear();
            productCartController.isButtonShow.value = false;
          });
          return double.parse(coupon['amount']);
        } else {
          couponAmount.value = '';
          Get.snackbar(
            "Invalid Coupon",
            "The coupon code entered is not valid.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      progressDialog.dismiss();
      MessageUtils.flushBarErrorMessage("An error occurred: $e", context);
    }
  }
}
