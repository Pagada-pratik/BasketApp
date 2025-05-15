import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/constants.dart';
import 'banner_s.dart';

class BannerSStyle5 extends StatelessWidget {
  const BannerSStyle5({
    super.key,
    this.image,
    required this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
  });
  final String? image;
  final String title;
  final String? subtitle, bottomText;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerS(
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
                    if (subtitle != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding / 2,
                            vertical: AppConstants.defaultPadding / 8),
                        color: Colors.white70,
                        child: Text(
                          subtitle!,
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
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    if (bottomText != null)
                      Text(
                        bottomText!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              SvgPicture.asset(
                "assets/icons/miniRight.svg",
                height: 28,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ],
    );
  }
}