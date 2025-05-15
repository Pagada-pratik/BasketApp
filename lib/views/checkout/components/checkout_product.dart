import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/cart/coupons_controller.dart';
import '../../../controllers/cart/product_cart_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';

class CheckoutProduct extends StatefulWidget {
  final bool isOrderConfirm;

  const CheckoutProduct({super.key, required this.isOrderConfirm});

  @override
  State<CheckoutProduct> createState() => _CheckoutProductState();
}

class _CheckoutProductState extends State<CheckoutProduct> {
  RxDouble couponCodeAmount = (-1.0).obs;

  CouponsController couponsController = Get.put(CouponsController());

  @override
  void initState() {
    super.initState();
    couponsController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductCartController productCartController =
        Get.put(ProductCartController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Text(
            (!widget.isOrderConfirm)
                ? "Your coupon discount"
                : "Have a coupon?",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
          ),
          child: Obx(() {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:
                            productCartController.couponController.value,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColors.primaryAppColor,
                        enabled: couponCodeAmount.value == -1.0,
                        onChanged: (text) {
                          if (text.length > 2) {
                            productCartController.isButtonShow.value = true;
                          } else {
                            productCartController.isButtonShow.value = false;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter coupon code...",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppConstants.defaultPadding * 0.75),
                            child: SvgPicture.asset(
                              "assets/icons/Coupon.svg",
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.3),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (couponCodeAmount.value != -1.0)
                      Container(
                        margin: EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            couponsController
                                .removeCouponCode(couponCodeAmount.value);
                            couponCodeAmount.value = -1.0;
                            productCartController.couponController.value
                                .clear();
                          },
                          child: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ),
                  ],
                ),
                Obx(() => (productCartController.isButtonShow.value)
                    ? Column(
                        children: [
                          const SizedBox(height: AppConstants.defaultPadding),
                          OutlinedButton(
                            onPressed: () async {
                              String couponCode = productCartController
                                  .couponController.value.text
                                  .trim();
                              if (couponCode.isNotEmpty) {
                                double? couponCodeAmountValue =
                                    await couponsController.validateCoupon(
                                        context, couponCode);
                                if (couponCodeAmountValue != null) {}
                                couponCodeAmount.value = couponCodeAmountValue!;
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Please enter a coupon code",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: const Text("Apply coupon code",
                                style: TextStyle(color: AppColors.blackColor)),
                          ),
                        ],
                      )
                    : const SizedBox()),
                const SizedBox(height: AppConstants.defaultPadding * 2),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.defaultBorderRadius),
                    side:
                        const BorderSide(width: 1, color: AppColors.blackColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: AppConstants.defaultPadding),
                            _buildSummaryRow(
                              'Subtotal',
                              '€${productCartController.subtotal.value.toStringAsFixed(1)}',
                              valueStyle: const TextStyle(
                                  color: AppColors.blackColor, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            _buildSummaryRow(
                              'Shipping Fee',
                              (productCartController.shippingTotal.value == 0.0)
                                  ? 'Free'
                                  : '€${productCartController.shippingTotal.value.toStringAsFixed(2)}',
                              valueStyle: const TextStyle(
                                  color: Colors.green, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            _buildSummaryRow(
                              'Discount',
                              '- €${productCartController.discountTotal.value.toStringAsFixed(1)}',
                              valueStyle: const TextStyle(
                                  color: AppColors.blackColor, fontSize: 16),
                            ),
                            const Divider(
                                height: 30, color: AppColors.blackColor),
                            _buildSummaryRow(
                              'Total',
                              '€${(productCartController.total.value - productCartController.discountTotal.value).toStringAsFixed(2)}',
                              valueStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                  fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value, style: valueStyle ?? const TextStyle(fontSize: 16)),
      ],
    );
  }
}
