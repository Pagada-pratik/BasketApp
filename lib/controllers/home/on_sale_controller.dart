// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../repositories/home_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class OnSaleController extends GetxController {
  List<ProductModel> onSaleProducts = <ProductModel>[].obs;
  final myRepo = HomeRepository();
  RxString onSaleBannerUrl = ''.obs;
  Rx<Duration> duration = Duration.zero.obs;
  late Timer timer;

  void setBannerTimer(Duration value) {
    duration.value = value;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.value.inSeconds > 0) {
        duration.value = Duration(seconds: duration.value.inSeconds - 1);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> onSaleBannerApiResponse(BuildContext context) async {
    myRepo.onSaleBannerApiCall().then((value) async {
      onSaleBannerUrl.value = value['url'];
      await onSaleProductsApiResponse(context);
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> onSaleProductsApiResponse(BuildContext context) async {
    myRepo.onSaleProductsApiCall().then((value) {
      onSaleProducts.assignAll(value.map<ProductModel>((item) {
        return ProductModel(
          productId: item['id'],
          categoryId: item['categories'][0]['id'],
          image: item['image_url'] == false ? '' : item['image_url'],
          title: item['name'],
          brandName: "SKU: ${item['sku']}",
          price: ParseValues.parsePrice(item['regular_price']),
          priceAfetDiscount: ParseValues.parsePrice(item['sale_price']),
          discountPercent: item['discount_percentage'],
        );
      }).toList());
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}