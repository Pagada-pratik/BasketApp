import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../entry_point_view.dart';

class AddedToCartMessageView extends StatelessWidget {
  const AddedToCartMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/success.png"
                    : "assets/Illustration/success_dark.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Spacer(flex: 2),
              Text(
                "Product added to cart",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              const Text(
                "Click the checkout button to complete the purchase process.",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              OutlinedButton(
                onPressed: () {
                  Get.offAll(() => const EntryPointView(), arguments: {'initialIndex': 1});
                },
                child: const Text("Continue shopping", style: TextStyle(color: AppColors.blackColor)),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const EntryPointView(), arguments: {'initialIndex': 3});
                },
                child: const Text("Checkout"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}