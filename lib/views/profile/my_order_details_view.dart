import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/cart/my_orders_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../models/my_order_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';

class MyOrderDetailsView extends StatefulWidget {
  final OrderModel order;

  const MyOrderDetailsView({super.key, required this.order});

  @override
  State<MyOrderDetailsView> createState() => _MyOrderDetailsViewState();
}

class _MyOrderDetailsViewState extends State<MyOrderDetailsView> {
  // MyOrdersController myOrdersController = Get.put(MyOrdersController());
  // ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
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
        title: const Text("Order details"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID: #${widget.order.id}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            Text(
              "Payment: ${widget.order.paymentMethodTitle}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppConstants.defaultBorderRadius),
            Text(
              "Status:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            const SizedBox(height: AppConstants.defaultBorderRadius),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProgressStep("On Hold",
                    widget.order.status == 'on-hold' ? 'on-hold' : ''),
                _buildProgressStep("Processing",
                    widget.order.status == 'processing' ? 'processing' : ''),
                _buildProgressStep("Completed",
                    widget.order.status == 'completed' ? 'completed' : ''),
                _buildProgressStep("Cancelled",
                    widget.order.status == 'cancelled' ? 'cancelled' : ''),
              ],
            ),
            const SizedBox(height: AppConstants.defaultBorderRadius),
            Text(
              "Details:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            Card(
              elevation: 0,
              color: AppColors.greyColor10,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.defaultBorderRadius),
                side: const BorderSide(width: 1, color: AppColors.greyColor10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultBorderRadius),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleSmall),
                          Text("Total",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleSmall),
                        ],
                      ),
                      const Divider(
                          height: 15, color: AppColors.blackColor),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...widget.order.lineItems.map((item) {
                            return SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 70.0, 0.0),
                                      child: Text(item.name,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodySmall)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" x ${item.quantity} Quantity",
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodySmall),
                                      Text(
                                          '${(widget.order.currencySymbol + item.total)}',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Vendor:",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall),
                          Text('${(widget.order.store.first.shopName)}',
                              style: TextStyle(
                                color: AppColors.blackColor60,
                                // Set the text color to blue
                                fontSize: 12,
                                // Optional: Set the font size
                                fontWeight: FontWeight
                                    .bold, // Optional: Set the font weight
                              )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall),
                          Text(
                              '${(widget.order.currencySymbol + calculateSubTotal(widget.order.lineItems))}',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment method:",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall),
                          Text(widget.order.paymentMethodTitle,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall),
                        ],
                      ),
                      const Divider(
                          height: 15, color: AppColors.blackColor),
                      _buildSummaryRow(
                        'Total Amount:',
                        '${(widget.order.currencySymbol + widget.order.total)}',
                        valueStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryAppColor,
                            fontSize: 16),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: AppConstants.defaultBorderRadius),
            Text(
              "Billing address:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.order.billing.firstName + " " + widget.order.billing.lastName}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      Text(
                        "${widget.order.billing.address1}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      Text(
                        "${widget.order.billing.city}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      if (widget.order.billing.state != null &&
                          widget.order.billing.state.isNotEmpty)
                        Text(
                          "${widget.order.billing.state}",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black54),
                        ),
                      Text(
                        "${widget.order.billing.postcode}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      Text(
                        "${widget.order.billing.country}",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Call.svg",
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyLarge!.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 1),
                          Text(
                            "${widget.order.billing.phone}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/email.svg",
                            height: 17,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyLarge!.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "${widget.order.billing.email}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ])),
          ],
        ),
      ),
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
        Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith()),
        Text(value, style: valueStyle ?? const TextStyle(fontSize: 16)),
      ],
    );
  }
}

String calculateSubTotal(List<LineItem> lineItems) {
  double total = lineItems.fold(0.0, (sum, item) => sum + double.parse(item.subtotal) ?? 0.0);
  return total.toStringAsFixed(2);
}
