import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/network_image_with_loader.dart';
import '../../controllers/reviews/add_review_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import '../../utils/message_utils.dart';
import 'components/review_form.dart';

class AddReviewView extends StatefulWidget {
  final List<dynamic> productData;
  const AddReviewView({super.key, required this.productData});

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends State<AddReviewView> {
  AddReviewController addReviewController = Get.put(AddReviewController());

  @override
  void initState() {
    super.initState();
    addReviewController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );
  }

  @override
  void dispose() {
    Get.delete<AddReviewController>();
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
        title: const Text("Add Review"),
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width * 0.3,
                      height: Get.width * 0.3,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: NetworkImageWithLoader(widget.productData[0]['images'][0]['src'], radius: 10),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productData[0]['name'],
                            style: const TextStyle(fontSize: 16, color: AppColors.blackColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.productData[0]['sku'],
                            style: const TextStyle(fontSize: 14, color: AppColors.greyColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  children: [
                    const ReviewForm(),

                    const SizedBox(height: AppConstants.defaultPadding * 3),
                    ElevatedButton(
                      onPressed: () {
                        if (addReviewController.starRateValue.value == 0.0) {
                          MessageUtils.flushBarErrorMessage("Please star rate the product.", context);
                        } else {
                          if (addReviewController.formKey.currentState!.validate()) {
                            addReviewController.createReviewApiResponse(widget.productData[0]['id'].toString(), context);
                          }
                        }
                      },
                      child: const Text("Submit Review", style: TextStyle(fontSize: AppConstants.defaultFontSize)),
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