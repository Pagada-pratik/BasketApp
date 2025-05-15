// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../repositories/home_repository.dart';
import '../../repositories/product_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class HomeCategoriesProductsController extends GetxController {
  final myRepo = HomeRepository();
  final myProductRepo = ProductRepository();
  RxInt currentIndex = 0.obs;
  List<CategoryModel> allHomeCategories = <CategoryModel>[].obs;
  List<ProductModel> categoriesBasePopularProducts = <ProductModel>[].obs;
  RxBool isProductNotFound = false.obs;

  Future<void> homeCategoriesApiResponse(BuildContext context) async {
    myRepo.homeCategoriesApiCall().then((value) async {
      await homePopularProductsApiResponse(context, value[0]['term_id']);
      allHomeCategories.assignAll(value.map<CategoryModel>((item) {
        return CategoryModel(
          name: item['name'],
          termId: item['term_id'],
        );
      }).toList());
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> homePopularProductsApiResponse(BuildContext context, int categoryId) async {
    isProductNotFound.value = false;
    categoriesBasePopularProducts.clear();
    myProductRepo.getProductsByCategoryIdApiCall(categoryId).then((value) {
      categoriesBasePopularProducts.assignAll(value.map<ProductModel>((item) {
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
      if (categoriesBasePopularProducts.isEmpty) {
        isProductNotFound.value = true;
      }
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }
}

class CategoryModel {
  final String name;
  final int? termId;

  CategoryModel({
    required this.name,
    required this.termId,
  });
}