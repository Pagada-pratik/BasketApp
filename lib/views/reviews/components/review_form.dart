import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/reviews/add_review_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import 'stars_rating.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    AddReviewController addReviewController = Get.put(AddReviewController());

    return Column(
      children: [
        const Divider(),
        const SizedBox(height: AppConstants.defaultPadding),

        Obx(() => StarsRating(
          titleText: "Your overall rating of this product",
          initialValue: addReviewController.starRateValue.value,
          onValueChanged: (v) {
            addReviewController.getRateValue(v);
          },
        )),

        const SizedBox(height: AppConstants.defaultPadding),
        const Divider(),
        const SizedBox(height: AppConstants.defaultPadding * 2),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "What did you like or dislike?",
            style: TextStyle(fontSize: 16, color: AppColors.blackColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Form(
          key: addReviewController.formKey,
          child: TextFormField(
            maxLines: 8,
            minLines: 6,
            controller: addReviewController.reviewController.value,
            textCapitalization: TextCapitalization.words,
            validator: AppConstants.reviewValidator.call,
            textInputAction: TextInputAction.done,
            cursorColor: AppColors.primaryAppColor,
            decoration: const InputDecoration(
              hintText: "What should shoppers know before?",
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(3000),
            ],
          ),
        ),
        const SizedBox(height: 2),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "3000 Character Max",
            style: TextStyle(fontSize: 14, color: AppColors.greyColor),
          ),
        ),
      ],
    );
  }
}