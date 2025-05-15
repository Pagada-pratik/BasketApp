// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/dot_indicators.dart';
import '../../models/onboard_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import 'components/onboarding_content.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<OnBoard> _onbordData = [
    OnBoard(
      image: "assets/Illustration/Illustration-0.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_0.png",
      title: "Find the item you’ve \nbeen looking for",
      description:
          "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
    ),
    OnBoard(
      image: "assets/Illustration/Illustration-1.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_1.png",
      title: "Get those shopping \nbags filled",
      description:
          "Add any item you want to your cart, or save it on your wishlist, so you don’t miss it in your future purchases.",
    ),
    OnBoard(
      image: "assets/Illustration/Illustration-2.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_2.png",
      title: "Fast & secure \npayment",
      description: "There are many payment options available for your ease.",
    ),
    OnBoard(
      image: "assets/Illustration/Illustration-3.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_3.png",
      title: "Package tracking",
      description:
          "In particular, MyBasket247 can pack your orders, and help you seamlessly manage your shipments.",
    ),
    OnBoard(
      image: "assets/Illustration/Illustration-4.png",
      imageDarkTheme: "assets/Illustration/Illustration_darkTheme_4.png",
      title: "Nearby stores",
      description:
          "Easily track nearby shops, browse through their items and get information about their products.",
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    await pref.setBool('isOnBoardingViewSuccess', true);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RoutesName.entryPointScreen, (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: AppColors.primaryAppColor),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onbordData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnbordingContent(
                    title: _onbordData[index].title,
                    description: _onbordData[index].description,
                    image: (Theme.of(context).brightness == Brightness.dark &&
                            _onbordData[index].imageDarkTheme != null)
                        ? _onbordData[index].imageDarkTheme!
                        : _onbordData[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onbordData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: AppConstants.defaultPadding / 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_pageIndex < _onbordData.length - 1) {
                          _pageController.nextPage(
                              curve: Curves.ease, duration: AppConstants.defaultDuration);
                        } else {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          await pref.setBool('isOnBoardingViewSuccess', true);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RoutesName.entryPointScreen, (Route<dynamic> route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Arrow - Right.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}