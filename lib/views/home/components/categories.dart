import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/skeleton/others/categories_skeleton.dart';
import '../../../controllers/home/categories_products_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  HomeCategoriesProductsController homeCategoriesProductsController = Get.put(HomeCategoriesProductsController());

  @override
  void initState() {
    super.initState();
    homeCategoriesProductsController.homeCategoriesApiResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (homeCategoriesProductsController.allHomeCategories.isNotEmpty) ?
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            homeCategoriesProductsController.allHomeCategories.length,
                (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? AppConstants.defaultPadding : AppConstants.defaultPadding / 2,
                  right:
                  index == homeCategoriesProductsController.allHomeCategories.length - 1 ? AppConstants.defaultPadding : 0),
              child: Obx(() => CategoryBtn(
                category: homeCategoriesProductsController.allHomeCategories[index].name,
                isActive: index == homeCategoriesProductsController.currentIndex.value,
                press: () async {
                  homeCategoriesProductsController.currentIndex.value = index;
                  await homeCategoriesProductsController.homePopularProductsApiResponse(context, homeCategoriesProductsController.allHomeCategories[index].termId!);
                },
              )),
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