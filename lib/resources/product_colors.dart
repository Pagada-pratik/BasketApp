import 'package:flutter/material.dart';

class ProductColors {
  static Color beigeColor = const Color.fromRGBO(245, 245, 220, 1);
  static Color blackColor = Colors.black;
  static Color blueColor = Colors.blue;
  static Color darkGreenColor = const Color.fromRGBO(1, 50, 32, 1);
  static Color greyColor = Colors.grey;
  static Color greenColor = Colors.green;
  static Color limeGreenColor = const Color.fromRGBO(50, 205, 50, 1);
  static Color orangeColor = Colors.orange;
  static Color pinkColor = Colors.pink;
  static Color purpleColor = Colors.purple;
  static Color redColor = Colors.red;
  static Color turquoiseColor = const Color.fromRGBO(48, 213, 200, 1);
  static Color whiteColor = Colors.white;
  static Color yellowColor = Colors.yellow;

  List<Color> getMappedColors(List<String> colorNames) {
    Map<String, Color> colorMap = {
      "Beige": ProductColors.beigeColor,
      "Black": ProductColors.blackColor,
      "Blue": ProductColors.blueColor,
      "Dark Green": ProductColors.darkGreenColor,
      "Grey": ProductColors.greyColor,
      "Green": ProductColors.greenColor,
      "Lime Green": ProductColors.limeGreenColor,
      "Orange": ProductColors.orangeColor,
      "Pink": ProductColors.pinkColor,
      "Purple": ProductColors.purpleColor,
      "Red": ProductColors.redColor,
      "Turquoise": ProductColors.turquoiseColor,
      "White": ProductColors.whiteColor,
      "Yellow": ProductColors.yellowColor,
    };
    return colorNames.map((name) => colorMap[name] ?? Colors.transparent).toList();
  }

  List<String> getColorOptions(Map<String, dynamic> productData) {
    if (productData['attributes'] != null && productData['attributes'] is List) {
      var colorAttribute = productData['attributes'].firstWhere((attr) => attr['name'].toLowerCase() == 'color',
        orElse: () => null,
      );
      if (colorAttribute != null && colorAttribute['options'] != null) {
        return List<String>.from(colorAttribute['options']);
      }
    }
    return [];
  }
}