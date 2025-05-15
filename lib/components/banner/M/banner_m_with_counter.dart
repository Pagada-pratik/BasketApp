import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/home/on_sale_controller.dart';
import '../../../resources/constants.dart';
import '../../blur_container.dart';
import 'banner_m.dart';

class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    required this.image,
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  OnSaleController onSaleController = Get.put(OnSaleController());

  @override
  void initState() {
    onSaleController.setBannerTimer(widget.duration);
    super.initState();
  }

  @override
  void dispose() {
    onSaleController.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: widget.image,
      press: widget.press,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppConstants.grandisExtendedFont,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => BlurContainer(
                  text: onSaleController.duration.value.inHours.toString().padLeft(2, "0"),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding / 4),
                  child: SvgPicture.asset("assets/icons/dot.svg"),
                ),
                Obx(() => BlurContainer(
                  text: onSaleController.duration.value.inMinutes
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.defaultPadding / 4),
                  child: SvgPicture.asset("assets/icons/dot.svg"),
                ),
                Obx(() => BlurContainer(
                  text: onSaleController.duration.value.inSeconds
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}