// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_banner_model.dart';
import '../../models/product_model.dart';
import '../../repositories/home_repository.dart';
import '../../repositories/product_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class SectionProductsController extends GetxController {
  final myRepo = HomeRepository();
  final myProductRepo = ProductRepository();
  List<ProductBannerModel> productBannerData = <ProductBannerModel>[].obs;
  RxMap<int, List<ProductModel>> categoryProducts = <int, List<ProductModel>>{}.obs;

  Future<void> sectionBaseHomeBannerApiResponse(BuildContext context) async {
    myRepo.sectionBaseHomeProductsApiCall().then((value) async {
      productBannerData.assignAll(value.map<ProductBannerModel>((item) {
        return ProductBannerModel.fromJson(item);
      }).toList());
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> sectionBaseHomeProductsApiResponse(BuildContext context, int categoryId) async {
    myProductRepo.getProductsByCategoryIdApiCall(categoryId).then((value) {
      categoryProducts[categoryId] = value.map<ProductModel>((item) {
        return ProductModel(
          productId: item['id'],
          categoryId: item['categories'][0]['id'],
          image: item['images'][0]['src'],
          title: item['name'],
          brandName: "SKU: ${item['sku']}",
          price: ParseValues.parsePrice(item['price']),
        );
      }).toList();
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}