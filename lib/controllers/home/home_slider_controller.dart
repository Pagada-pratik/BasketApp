// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/views/sales/on_sale_view.dart';

import '../../components/banner/M/banner_m_style_2.dart';
import '../../repositories/home_repository.dart';
import '../../routes/routes_name.dart';
import '../../utils/message_utils.dart';

class HomeSliderController extends GetxController {
  List<BannerMStyle2> offerSliders = <BannerMStyle2>[].obs;
  late PageController pageController;
  final myRepo = HomeRepository();
  RxInt selectedIndex = 0.obs;
  late Timer timer;

  void animateSlider(BuildContext context) async {
    pageController = PageController(initialPage: 0);
    await offerSlidersApiResponse(context);
    timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (offerSliders.isNotEmpty) {
        if (selectedIndex < offerSliders.length - 1) {
          selectedIndex++;
        } else {
          selectedIndex.value = 0;
        }

        pageController.animateToPage(
          selectedIndex.value,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  Future<void> offerSlidersApiResponse(BuildContext context) async {
    myRepo.homeSliderApiCall().then((value) {
      offerSliders.assignAll(value.map<BannerMStyle2>((item) {
        return BannerMStyle2(
          image: item['image'],
          title: item['title'],
          subtitle: item['sub_title'],
          discountPercent: 10,
          buttonText: item['button_text'],
          press: () {
            // Navigator.pushNamed(context, RoutesName.);
            Get.to(()=>OnSaleView([], 0,categoryId: item['button_category'],));
          },
        );
      }).toList());
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}