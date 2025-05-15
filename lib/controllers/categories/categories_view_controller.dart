// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybasket247/utils/parse_values.dart';

import '../../models/category_model.dart';
import '../../repositories/category_repository.dart';
import '../../utils/message_utils.dart';

class CategoriesViewController extends GetxController {
  final categoryRepo = CategoryRepository();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final RxString searchQuery = ''.obs;

  Future<void> getAllCategoriesApiResponse(BuildContext context, int pageCount) async {
    try {
      final response = await categoryRepo.getAllCategoriesApiCall(pageCount);
      final processedCategories = _processCategoryData(response);
      categories.assignAll(processedCategories);
      filteredCategories.assignAll(processedCategories);
    } catch (error) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    }
  }

  List<CategoryModel> _processCategoryData(List<dynamic> apiResponse) {
    final List<CategoryModel> allCategories = _mapApiResponseToCategories(apiResponse);
    return _buildCategoryHierarchy(allCategories);
  }

  List<CategoryModel> _mapApiResponseToCategories(List<dynamic> apiResponse) {
    return apiResponse.map((item) {
      return CategoryModel(
        id: item['id'] as int?,
        title: ParseValues.removeHtmlTags(item['name'] as String?),
        slug: item['slug'] as String?,
        parent: item['parent'] as int?,
        description: item['description'] as String?,
        subCategories: [],
      );
    }).toList();
  }

  List<CategoryModel> _buildCategoryHierarchy(List<CategoryModel> allCategories) {
    final Map<int?, CategoryModel> categoryMap = {
      for (var category in allCategories) category.id: category
    };
    final List<CategoryModel> rootCategories = [];

    for (var category in allCategories) {
      if (category.parent == 0 || category.parent == null) {
        rootCategories.add(category);
      } else {
        final parentCategory = categoryMap[category.parent];
        if (parentCategory != null) {
          parentCategory.subCategories.add(category);
        }
      }
    }

    return rootCategories;
  }

  void filterCategories(String query) {
    searchQuery.value = query.toLowerCase();
    if (searchQuery.value.isEmpty) {
      filteredCategories.assignAll(categories);
    } else {
      final List<CategoryModel> filteredList = [];
      for (var category in categories) {
        if (category.title!.toLowerCase().contains(searchQuery.value)) {
          filteredList.add(category);
        } else {
          final matchingSubCategories = category.subCategories.where(
                (subCategory) => subCategory.title!.toLowerCase().contains(searchQuery.value),
          ).toList();

          if (matchingSubCategories.isNotEmpty) {
            filteredList.add(CategoryModel(
              id: category.id,
              title: category.title,
              slug: category.slug,
              parent: category.parent,
              description: category.description,
              subCategories: matchingSubCategories,
            ));
          }
        }
      }
      filteredCategories.assignAll(filteredList);
    }
  }
}