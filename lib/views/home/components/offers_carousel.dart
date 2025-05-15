import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/dot_indicators.dart';
import '../../../components/skeleton/others/offers_skeleton.dart';
import '../../../controllers/home/home_slider_controller.dart';
import '../../../resources/constants.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({
    super.key,
  });

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  HomeSliderController homeSliderController = Get.put(HomeSliderController());

  @override
  void initState() {
    super.initState();
    homeSliderController.animateSlider(context);
  }

  @override
  void dispose() {
    homeSliderController.pageController.dispose();
    homeSliderController.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (homeSliderController.offerSliders.isNotEmpty)
        ? AspectRatio(
            aspectRatio: 1.87,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                PageView.builder(
                  controller: homeSliderController.pageController,
                  itemCount: homeSliderController.offerSliders.length,
                  onPageChanged: (int index) {
                    homeSliderController.selectedIndex.value = index;
                  },
                  itemBuilder: (context, index) =>
                      homeSliderController.offerSliders[index],
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    child: SizedBox(
                      height: 16,
                      child: Row(
                        children: List.generate(
                            homeSliderController.offerSliders.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: AppConstants.defaultPadding / 4),
                            child: DotIndicator(
                              isActive: index ==
                                  homeSliderController.selectedIndex.value,
                              activeColor: Colors.white70,
                              inActiveColor: Colors.white54,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const OffersSkeleton());
  }
}
