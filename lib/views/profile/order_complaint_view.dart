import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybasket247/controllers/cart/orders_complaint_controller.dart';

import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';

import 'dart:developer';

import '../../resources/constants.dart';

class OrderComplaintView extends StatefulWidget {
  final int orderId;
  final int productId;
  const OrderComplaintView({super.key, required int this.orderId, required int this.productId});

  @override
  State<OrderComplaintView> createState() => _OrderComplaintViewState();
}

class _OrderComplaintViewState extends State<OrderComplaintView> {
  final _formKey = GlobalKey<FormState>();
  OrdersComplaintController ordersComplaintController = Get.put(OrdersComplaintController());
  // final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ordersComplaintController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ordersComplaintController.getOrdersComplaintApiResponse(
          context, widget.orderId.toString(), widget.productId.toString() );
          // context, "7968", "7815");
      ordersComplaintController.isDataSuccess.value = true;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

  }

  @override
  void dispose() {
    // _messageController.dispose();
    _scrollController.dispose();
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
        title: const Text("Complaint"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                controller: _scrollController,
                reverse: false,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: ordersComplaintController.messages.length,
                itemBuilder: (context, index) {
                  final message = ordersComplaintController.messages[index];
                  return Align(
                    alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: message['isMe'] ? Colors.amber : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          color: message['isMe'] ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              )),
            ),
            const Divider(height: 1),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ordersComplaintController.complaintMsgController.value,
                        validator: AppConstants.reviewValidator.call,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      // onPressed: _sendMessage,
                      onPressed:() {
                        if (_formKey.currentState!.validate()) {
                          ordersComplaintController.submitComplaintApiResponse(
                              context, widget.orderId.toString(), widget.productId.toString());
                              // context, "7968", "7815");
                        }
                      } ,
                      icon: Icon(Icons.send, color: Colors.deepOrangeAccent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
