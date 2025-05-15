// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class SalesViewController extends GetxController {
  late ScrollController scrollController;
  final myProductRepo = ProductRepository();
  List<ProductModel> categoriesBaseSalesProducts = <ProductModel>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isProductNotFound = false.obs;

  Future<void> salesProductsApiResponse(BuildContext context, int categoryId) async {
    isProductNotFound.value = false;
    categoriesBaseSalesProducts.clear();
    myProductRepo.getProductsByCategoryIdApiCall(categoryId).then((value) {
      categoriesBaseSalesProducts.assignAll(value.map<ProductModel>((item) {
        return ProductModel(
          productId: item['id'],
          categoryId: item['categories'][0]['id'],
          image: item['images'][0]['src'],
          title: item['name'],
          brandName: "SKU: ${item['sku']}",
          price: ParseValues.parsePrice(item['price']),
          // discountPercent: 20,
        );
      }).toList());
      if (categoriesBaseSalesProducts.isEmpty) {
        isProductNotFound.value = true;
      }
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  void scrollToActiveCategory(int index) {
    final double scrollPosition = index * 120.0;
    scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}