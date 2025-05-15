// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';

import '../../repositories/product_repository.dart';
import '../../utils/message_utils.dart';
import '../../utils/parse_values.dart';

class ProductDetailsController extends GetxController {
  final myProductRepo = ProductRepository();
  List<dynamic> productData = [].obs;
  List<ProductModel> getRelatedProducts = <ProductModel>[].obs;
  RxInt quantityCount = 1.obs;
  RxInt selectedColorsIndex = (-1).obs;
  RxBool isProductNotFound = false.obs;

  Future<void> getSingleProductDataApiResponse(BuildContext context, int productId) async {
    myProductRepo.getProductsByProductIdApiCall(productId).then((value) async {
      productData.add(value);
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> getRelatedProductsApiResponse(BuildContext context, int categoryId, int productId) async {
    isProductNotFound.value = false;
    myProductRepo.getProductsByCategoryAndExcludeProductIdApiCall(categoryId: categoryId, excludeProductId: productId).then((value) {
      getRelatedProducts.assignAll(value.map<ProductModel>((item) {
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
      if (getRelatedProducts.isEmpty) {
        isProductNotFound.value = true;
      }
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  void incrementQuantityCount(int stockQuantity) {
    if (quantityCount.value < stockQuantity) {
      quantityCount.value++;
    }
  }

  void decrementQuantityCount() {
    if (quantityCount.value != 1) {
      quantityCount.value--;
    }
  }

  void selectedColors(int index) {
    selectedColorsIndex.value = index;
  }
}