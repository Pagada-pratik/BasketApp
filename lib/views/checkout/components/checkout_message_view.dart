import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/constants.dart';

class CheckoutMessageView extends StatelessWidget {
  const CheckoutMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
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
                "Thanks for your order",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              const Text(
                "You'll receive an email once your order is confirmed.",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              // OutlinedButton(
              //   onPressed: () {
              //     Get.offAll(() => const EntryPointView(), arguments: {'initialIndex': 1});
              //   },
              //   child: const Text("Continue shopping", style: TextStyle(color: AppColors.blackColor)),
              // ),
              // const SizedBox(height: AppConstants.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Back"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutMessageFail extends StatelessWidget {
  const CheckOutMessageFail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/Failed_lightTheme.png"
                    : "assets/Illustration/Failed_darkTheme.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Spacer(flex: 2),
              Text(
                "Failed to order",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              const Text(
                "Please try again",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              // OutlinedButton(
              //   onPressed: () {
              //     Get.offAll(() => const EntryPointView(), arguments: {'initialIndex': 1});
              //   },
              //   child: const Text("Continue shopping", style: TextStyle(color: AppColors.blackColor)),
              // ),
              // const SizedBox(height: AppConstants.defaultPadding),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: const Text("Back"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
