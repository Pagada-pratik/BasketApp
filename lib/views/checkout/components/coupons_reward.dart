import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class CouponsReward extends StatefulWidget {
  final String discountAmount;
  const CouponsReward({super.key, required this.discountAmount});

  @override
  State<CouponsReward> createState() => _CouponsRewardState();
}

class _CouponsRewardState extends State<CouponsReward> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(minutes: 2));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
          child: Column(
            children: [
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 30,
                gravity: 0.10,
                emissionFrequency: 0.05,
                maxBlastForce: 30,
                minBlastForce: 10,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                ],
              ),
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/PayWithCash_lightTheme.png"
                    : "assets/Illustration/PayWithCash_darkTheme.png",
                height: MediaQuery.of(context).size.height * 0.22,
              ),
              const Spacer(flex: 2),
              Text(
                "Congratulations".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.primaryAppColor, fontSize: 28),
              ),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              const Text(
                "You got a coupon discount.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              Text(
                "€${widget.discountAmount}",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Continue"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}