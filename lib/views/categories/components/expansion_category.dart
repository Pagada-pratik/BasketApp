import 'package:flutter/material.dart';
import '../../../resources/constants.dart';
import '../../../routes/routes_name.dart';

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    super.key,
    required this.id,
    required this.title,
    required this.subCategory,
  });

  final int id;
  final String title;
  final List subCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      childrenPadding: const EdgeInsets.only(left: AppConstants.defaultPadding * 3.5),
      children: List.generate(
        subCategory.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.onSaleScreen, arguments: {'subCategory': subCategory, 'categoryIndex': index});
              },
              title: Text(
                subCategory[index].title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (index < subCategory.length - 1) const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}