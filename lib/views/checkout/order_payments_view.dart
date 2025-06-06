import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/views/checkout/checkout_screen.dart';

import '../../controllers/cart/product_cart_controller.dart';
import '../../controllers/categories/checkout_form_controller.dart';
import '../../controllers/categories/order_payments_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../services/payment_gateway_services.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';
import 'components/cart_product.dart';
import 'components/checkout_product.dart';

class OrderPaymentsView extends StatefulWidget {
  const OrderPaymentsView({super.key});

  @override
  State<OrderPaymentsView> createState() => _OrderPaymentsViewState();
}

class _OrderPaymentsViewState extends State<OrderPaymentsView> {
  ProductCartController productCartController =
      Get.put(ProductCartController());
  OrderPaymentsController orderPaymentsController =
      Get.put(OrderPaymentsController());
  CheckoutFormController checkoutFormController =
      Get.put(CheckoutFormController());
  PaymentGatewayServices paymentService = PaymentGatewayServices();
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    orderPaymentsController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    profileController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await paymentService.getAccessToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 80,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("Your Order"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            padding: const EdgeInsets.only(
                left: AppConstants.defaultPadding * 2, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/verified-check.svg",
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.successColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Customer matched zone "CY"',
                  style: TextStyle(fontSize: 16, color: AppColors.blackColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Card(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estimated Delivery Time',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const Divider(height: 30, color: AppColors.blackColor),
                        _buildSummaryRow(
                          'Vendor :',
                          'Vendor Shop',
                          valueStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'N/A',
                          '',
                          valueStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: CartProduct(
                    getCartItems: productCartController.getCartData,
                    isOrderConfirm: true)),
            const SliverToBoxAdapter(
                child: CheckoutProduct(isOrderConfirm: true)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Card(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Payment Method',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(height: 30, color: AppColors.blackColor),
                        Obx(() => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                orderPaymentsController.selectedPaymentMethod
                                    .value = "Cash on Delivery";
                                orderPaymentsController.paymentMethod.value =
                                    "cod";
                                orderPaymentsController.paymentMethodTitle
                                    .value = "Cash on delivery";
                              },
                              leading: Radio<String>(
                                value: "Cash on Delivery",
                                activeColor: AppColors.primaryAppColor,
                                groupValue: orderPaymentsController
                                    .selectedPaymentMethod.value,
                                onChanged: (value) {
                                  orderPaymentsController
                                      .selectedPaymentMethod.value = value!;
                                  orderPaymentsController.paymentMethod.value =
                                      "cod";
                                  orderPaymentsController.paymentMethodTitle
                                      .value = "Cash on delivery";
                                },
                              ),
                              title: const Text(
                                "Cash on Delivery",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle:
                                  const Text('Pay with cash upon delivery.',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 14,
                                      )),
                            )),
                        Obx(() => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                orderPaymentsController.selectedPaymentMethod
                                    .value = "Payment with VivaWallet";
                                orderPaymentsController.paymentMethod.value =
                                    "app_payment_viva";
                                orderPaymentsController.paymentMethodTitle
                                    .value = "App Payment Viva";
                              },
                              leading: Radio<String>(
                                value: "Payment with VivaWallet",
                                activeColor: AppColors.primaryAppColor,
                                groupValue: orderPaymentsController
                                    .selectedPaymentMethod.value,
                                onChanged: (value) {
                                  orderPaymentsController
                                      .selectedPaymentMethod.value = value!;
                                  orderPaymentsController.paymentMethod.value =
                                      "app_payment_viva";
                                  orderPaymentsController.paymentMethodTitle
                                      .value = "App Payment Viva";
                                },
                              ),
                              title: const Text(
                                "Payment with VivaWallet",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: const Text(
                                  'Pay via VivaWallet - You can pay with your credit card.',
                                  style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: ElevatedButton(
          onPressed: () async {
            String? orderCode = await paymentService.createOrder(
                productCartController.total.value -
                    productCartController.discountTotal.value);

            if (orderPaymentsController.selectedPaymentMethod.isNotEmpty) {
              if (orderCode != null) {
                if (orderPaymentsController.paymentMethod.value != "cod") {
                  // Step 3: Get Checkout URL and redirect user
                  // String checkoutUrl = paymentService.getCheckoutUrl(orderCode);
                  // print('Redirect to: $checkoutUrl');
                  // profileController.launchWebUrl(checkoutUrl);
                  Get.to(() => CheckoutScreen(
                        orderCode: orderCode, myOrderId: "",
                      ));
                } else {
                  orderPaymentsController.createOrderApiResponse(
                    setPaid: false,
                    cod: true,
                    context: context,
                  );
                }
              }
            } else {
              MessageUtils.flushBarErrorMessage(
                "Please Select Payment Method.",
                context,
              );
            }
          },
          child: const Text(
            "Place Order",
            style: TextStyle(fontSize: AppConstants.defaultFontSize),
          ),
        ),
      ),
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
