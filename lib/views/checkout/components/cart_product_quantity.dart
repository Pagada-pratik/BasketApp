import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../resources/constants.dart';

class CartProductQuantity extends StatelessWidget {
  const CartProductQuantity({
    super.key,
    required this.numOfItem,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int numOfItem;
  final VoidCallback onIncrement, onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: Get.width * 0.095,
              width: Get.width * 0.095,
              child: OutlinedButton(
                onPressed: onDecrement,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding / 2)),
                child: SvgPicture.asset(
                  "assets/icons/Minus.svg",
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.095,
              child: Center(
                child: Text(
                  numOfItem.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.095,
              width: Get.width * 0.095,
              child: OutlinedButton(
                onPressed: onIncrement,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding / 2)),
                child: SvgPicture.asset(
                  "assets/icons/Plus1.svg",
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}