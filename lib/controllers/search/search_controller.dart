// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../repositories/product_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class SearchProductController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final myProductRepo = ProductRepository();
  final RxList<ProductModel> getAllProducts = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxBool isProductNotFound = false.obs;

  Future<bool> getAllProductsApiResponse(
      BuildContext context, int perPageCount) async {
    getAllProducts.clear();
    await myProductRepo.getAllProductsApiCall(perPageCount).then((value) {
      getAllProducts.assignAll(value.map<ProductModel>((item) {
        String image =
        item['images'].isNotEmpty ? item['images'][0]['src'] ?? '' : '';
        return ProductModel(
          productId: item['id'] ?? '',
          categoryId: (item['categories'] as List).isEmpty
              ? 0
              : item['categories'][0]['id'] ?? 0,
          image: image,
          title: item['name'] ?? '',
          brandName: "SKU: ${item['sku'] ?? ''}",
          price: ParseValues.parsePrice(item['price'] ?? ''),
          // discountPercent: 20,
        );
      }).toList());
      filteredProducts.assignAll(getAllProducts);
      if (filteredProducts.isEmpty) {
        isProductNotFound.value = true;
      }
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
    return true;
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(getAllProducts);
    } else {
      filteredProducts.assignAll(getAllProducts.where((product) {
        final productNameMatches =
        product.title.toLowerCase().contains(query.toLowerCase());
        final skuMatches =
        product.brandName.toLowerCase().contains(query.toLowerCase());
        return productNameMatches || skuMatches;
      }).toList());

      if (filteredProducts.isEmpty) {
        isProductNotFound.value = true;
      } else {
        isProductNotFound.value = false;
      }
    }
  }
}
