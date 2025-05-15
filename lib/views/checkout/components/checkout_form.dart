import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/categories/checkout_form_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class CheckoutForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  CheckoutForm({super.key, required this.formKey});
  CheckoutFormController checkoutFormController = Get.put(CheckoutFormController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("First name :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.firstNameController.value,
                validator: AppConstants.firstNameValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.primaryAppColor,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "First name *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Last name :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.lastNameController.value,
                validator: AppConstants.lastNameValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.primaryAppColor,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "Last name *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Street address :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.streetAddressController.value,
                validator: AppConstants.streetAddressValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.primaryAppColor,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "Street address *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Town / City :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.townCityController.value,
                validator: AppConstants.townCityValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.primaryAppColor,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "Town / City *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Postcode / ZIP :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.postcodeZIPController.value,
                validator: AppConstants.postcodeZIPValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.primaryAppColor,
                decoration: const InputDecoration(
                  hintText: "Postcode / ZIP *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Phone number :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.phoneController.value,
                validator: AppConstants.phoneValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                cursorColor: AppColors.primaryAppColor,
                decoration: const InputDecoration(
                  hintText: "Phone *",
                ),
                // inputFormatters: [
                //   LengthLimitingTextInputFormatter(10),
                // ],
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Text("Email address :"),
              const SizedBox(height: 2),
              TextFormField(
                controller: checkoutFormController.emailController.value,
                validator: AppConstants.emailFieldValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.primaryAppColor,
                decoration: const InputDecoration(
                  hintText: "Email address *",
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Country / Region *",
                  style: TextStyle(fontSize: 16, color: AppColors.greyColor),
                ),
              ),
              const SizedBox(height: 2),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cyprus",
                  style: TextStyle(fontSize: 16, color: AppColors.blackColor),
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.defaultPadding),
        const Text("Company name (optional) :"),
        const SizedBox(height: 2),
        TextFormField(
          controller: checkoutFormController.companyNameController.value,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          cursorColor: AppColors.primaryAppColor,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: "Company name (optional)",
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Row(
          children: [
            Obx(() => Checkbox(
              onChanged: (value) {
                checkoutFormController.setOrderUpdates(value!);
              },
              value: checkoutFormController.isOrderUpdates.value,
              activeColor: AppColors.primaryAppColor,
            )),
            const Expanded(
              child: Text("Please send me order updates via text message (optional)"),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Order notes (optional)",
            style: TextStyle(fontSize: 16, color: AppColors.blackColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLines: 6,
          minLines: 4,
          controller: checkoutFormController.orderNotesController.value,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          cursorColor: AppColors.primaryAppColor,
          decoration: const InputDecoration(
            hintText: "Notes about your order, e.g. special notes for delivery. (additional information)",
          ),
        ),
      ],
    );
  }
}