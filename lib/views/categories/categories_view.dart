import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/skeleton/others/discover_categories_skeleton.dart';
import '../../controllers/categories/categories_view_controller.dart';
import '../../resources/constants.dart';
import '../search/components/search_form.dart';
import 'components/expansion_category.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  CategoriesViewController categoriesViewController = Get.put(CategoriesViewController());

  @override
  void initState() {
    super.initState();
    categoriesViewController.getAllCategoriesApiResponse(context, 100);

    categoriesViewController.searchFocusNode.addListener(() {
      if (!categoriesViewController.searchFocusNode.hasFocus) {
        categoriesViewController.searchController.clear();
        categoriesViewController.filterCategories('');
      }
    });
  }

  @override
  void dispose() {
    categoriesViewController.searchFocusNode.dispose();
    categoriesViewController.searchController.dispose();
    Get.delete<CategoriesViewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: SearchForm(
                controller: categoriesViewController.searchController,
                focusNode: categoriesViewController.searchFocusNode,
                onChanged: (query) => categoriesViewController.filterCategories(query ?? ''),
                hintText: "Search categories here...",
                isFilterAvailable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding / 2),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: Obx(() => (categoriesViewController.filteredCategories.isNotEmpty) ?
              ListView.builder(
                itemCount: categoriesViewController.filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = categoriesViewController.filteredCategories[index];
                  return ExpansionCategory(
                    id: category.id!,
                    title: category.title!,
                    subCategory: category.subCategories,
                  );
                },
              ) : const DiscoverCategoriesSkeleton()),
            ),
          ],
        ),
      ),
    );
  }
}