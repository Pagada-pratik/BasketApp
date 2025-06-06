import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/skeleton/others/categories_skeleton.dart';
import '../../../controllers/sales/sales_view_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class SaleCategories extends StatefulWidget {
  final List subCategory;
  final int categoryIndex;
  const SaleCategories(this.subCategory, this.categoryIndex, {super.key});

  @override
  State<SaleCategories> createState() => _SaleCategoriesState();
}

class _SaleCategoriesState extends State<SaleCategories> {
  SalesViewController salesViewController = Get.put(SalesViewController());

  @override
  void initState() {
    super.initState();
    salesViewController.scrollController = ScrollController();
    salesViewController.currentIndex.value = widget.categoryIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      salesViewController.scrollToActiveCategory(widget.categoryIndex);
    });
  }

  @override
  void dispose() {
    salesViewController.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (widget.subCategory.isNotEmpty) ?
    SingleChildScrollView(
      controller: salesViewController.scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            widget.subCategory.length,
                (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? AppConstants.defaultPadding : AppConstants.defaultPadding / 2,
                  right:
                  index == widget.subCategory.length - 1 ? AppConstants.defaultPadding : 0),
              child: CategoryBtn(
                category: widget.subCategory[index].title,
                isActive: index == salesViewController.currentIndex.value,
                press: () async {
                  salesViewController.currentIndex.value = index;
                  salesViewController.dropdownvalue.value = 'Default sorting';
                  await salesViewController.salesProductsApiResponse(context, widget.subCategory[index].id);
                },
              ),
            ),
          ),
        ],
      ),
    ) : const CategoriesSkeleton());
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    required this.isActive,
    required this.press,
  });

  final String category;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryAppColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}