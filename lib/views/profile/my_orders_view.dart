import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart/my_orders_controller.dart';
import '../../controllers/cart/product_cart_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../../services/payment_gateway_services.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';
import '../checkout/checkout_screen.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  MyOrdersController myOrdersController = Get.put(MyOrdersController());
  ProfileController profileController = Get.put(ProfileController());

  PaymentGatewayServices paymentService = PaymentGatewayServices();

  ProductCartController productCartController = Get.put(ProductCartController());

  @override
  void initState() {
    super.initState();
    myOrdersController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await myOrdersController.getMyOrdersApiResponse(
          context, profileController.userId.toString());
      myOrdersController.isDataSuccess.value = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await paymentService.getAccessToken();
    });

    productCartController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
  }

  @override
  void dispose() {
    Get.delete<MyOrdersController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: const Text("Orders History"),
      ),
      body: Obx(() => (myOrdersController.orders.isNotEmpty)
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: myOrdersController.orders.length,
              itemBuilder: (context, index) {
                final order = myOrdersController.orders[index];
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius),
                        side: const BorderSide(
                            width: 1, color: AppColors.blackColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID: #${order.id}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                            Text(
                              "Payment: ${order.paymentMethodTitle}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                                height: AppConstants.defaultBorderRadius),
                            Text(
                              "Status:",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                            const SizedBox(
                                height: AppConstants.defaultBorderRadius),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildProgressStep("On Hold",
                                    order.status == 'on-hold' ? 'on-hold' : ''),
                                _buildProgressStep(
                                    "Processing",
                                    order.status == 'processing'
                                        ? 'processing'
                                        : ''),
                                _buildProgressStep(
                                    "Completed",
                                    order.status == 'completed'
                                        ? 'completed'
                                        : ''),
                                _buildProgressStep(
                                    "Cancelled",
                                    order.status == 'cancelled'
                                        ? 'cancelled'
                                        : ''),
                              ],
                            ),
                            const SizedBox(
                                height: AppConstants.defaultBorderRadius),
                            Text(
                              "Items Details:",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...order.lineItems.map((item) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 0,
                                      color: AppColors.greyColor10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            AppConstants.defaultBorderRadius),
                                        side: const BorderSide(
                                            width: 1,
                                            color: AppColors.greyColor20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            AppConstants.defaultBorderRadius),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Product:- ${item.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    "x${item.quantity} Quantity"),
                                                Text("Price: €${item.total}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            const Divider(
                                height: 30, color: AppColors.blackColor),
                            _buildSummaryRow(
                              'Total Amount:',
                              '€${(order.total)}',
                              valueStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryAppColor,
                                  fontSize: 16),
                            ),
                            if(order.status == 'completed' || order.status == 'pending')
                            const Divider(
                                height: 30, color: AppColors.blackColor),
                            if(order.status == 'pending')
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  String? orderCode = await paymentService.createOrder(
                                      double.parse(order.total) -
                                          double.parse(order.discountTotal));
                                  if (orderCode != null) {
                                      Get.to(() => CheckoutScreen(
                                        orderCode: orderCode, myOrderId: order.id.toString(),
                                      ));
                                  } else {
                                    MessageUtils.flushBarErrorMessage(
                                      "Payment order id issue.",
                                      context,
                                    );
                                  }
                                },
                                child: const Text(
                                  "Pay",
                                  style: TextStyle(fontSize: AppConstants.defaultFontSize),
                                ),
                              ),
                            ),
                            if(order.status == 'completed')
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: ElevatedButton(
                                onPressed: () async {
                                    // for (var item in order.lineItems) {
                                  for (int i = 0; i < order.lineItems.length; i++) {
                                    var item = order.lineItems[i];
                                    bool isLast = i == order.lineItems.length - 1;
                                      await productCartController
                                          .addProductToCartApiOrderAgainResponse(
                                          item.productId
                                              .toString(),
                                          item.quantity
                                              .toString(), context, isLast);
                                    }
                                },
                                child: const Text(
                                  "Order again",
                                  style: TextStyle(fontSize: AppConstants.defaultFontSize),
                                ),
                              ),
                            ),
                            if(order.status == 'completed')
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,15,0,0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.orderComplaintScreen,
                                    arguments: {
                                      'orderId': order.id,
                                      'productId': order.lineItems.first.productId,
                                    },
                                  );
                                },
                                child: const Text(
                                  "Complaint",
                                  style: TextStyle(fontSize: AppConstants.defaultFontSize),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.myOrderDetailsScreen,
                      arguments: {
                        'order': order,
                      },
                    );
                  },
                );
              },
            )
          : (!myOrdersController.isDataSuccess.value)
              ? const SizedBox()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/Illustration/NoResult.png"
                            : "assets/Illustration/NoResultDarkTheme.png",
                        height: MediaQuery.of(context).size.height * 0.22,
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Text(
                        "No order history was found!",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )),
    );
  }

  Widget _buildProgressStep(String title, String status) {
    Color getStatusColor() {
      switch (status) {
        case 'on-hold':
          return Colors.blue;
        case 'processing':
          return Colors.orange;
        case 'completed':
          return Colors.green;
        case 'cancelled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    IconData getStatusIcon() {
      switch (status) {
        case 'on-hold':
          return Icons.pause_circle;
        case 'processing':
          return Icons.timelapse;
        case 'completed':
          return Icons.check_circle;
        case 'cancelled':
          return Icons.cancel;
        default:
          return Icons.circle;
      }
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: getStatusColor(),
          child: Icon(
            getStatusIcon(),
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: getStatusColor(),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith()),
        Text(value, style: valueStyle ?? const TextStyle(fontSize: 16)),
      ],
    );
  }
}
