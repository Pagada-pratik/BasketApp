// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../../repositories/checkout_repository.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';
import '../../views/checkout/components/coupons_reward.dart';
import 'product_cart_controller.dart';

class CouponsController extends GetxController {
  ProductCartController productCartController = Get.put(ProductCartController());
  late ArsProgressDialog progressDialog;
  final myCheckoutRepo = CheckoutRepository();
  /*RxString couponAmount = ''.obs;
  RxString couponType = ''.obs;*/
  // RxDouble couponCodeAmount = (-1.0).obs;


  void removeCouponCode(double amount){
    // productCartController.discountTotal.value -= amount;
    productCartController.discountTotal.value = amount;
    productCartController.couponController.value.clear();
  }

  Future<double?> validateCoupon(BuildContext context, String couponCode) async {
    progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
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
          productCartController.couponAmount.value = coupon['amount'];
          productCartController.couponType.value = coupon['discount_type'];

          double finalCouponAmount = 0;
          if(productCartController.couponType.value == "percent" ){
            finalCouponAmount =  (productCartController.total.value * double.parse(productCartController.couponAmount.value)) / 100;
          } else {
            finalCouponAmount = double.parse(productCartController.couponAmount.value);
          }

          customModalBottomSheet(
            context,
            isDismissible: false,
            // child: CouponsReward(discountAmount: coupon['amount']),
            child: CouponsReward(discountAmount: finalCouponAmount.toString()),
          ).then((_) async {

            // productCartController.discountTotal.value += double.parse(coupon['amount']);
            productCartController.discountTotal.value += finalCouponAmount;
            // productCartController.couponController.value.clear();
            productCartController.isButtonShow.value = false;

            // couponCodeAmount.value = finalCouponAmount;
          });
          return double.parse(productCartController.couponAmount.value);
        } else {
          productCartController.couponAmount.value = '';
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
