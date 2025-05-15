import 'package:flutter/material.dart';
import '../../../resources/constants.dart';
import 'banner_m.dart';

class BannerMStyle2 extends StatelessWidget {
  const BannerMStyle2({
    super.key,
    this.image,
    required this.title,
    required this.press,
    this.subtitle,
    required this.discountPercent,
    this.buttonText = 'Shop Now',
  });
  final String? image;
  final String title;
  final String? subtitle;
  final int discountPercent;
  final String buttonText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding / 2,
                          vertical: AppConstants.defaultPadding / 8),
                      color: Colors.white70,
                      child: Text(
                        "$discountPercent% off",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppConstants.grandisExtendedFont,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    InkWell(

                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 64,
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}