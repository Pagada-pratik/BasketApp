import 'package:html/parser.dart';

class ParseValues {
  static double parsePrice(dynamic value) {
    double price;
    if (value == null || value.toString().isEmpty) {
      price = 0.0;
    } else {
      try {
        price = double.parse(value.toString());
      } catch (e) {
        price = 0.0;
      }
    }
    return price;
  }

  static String stripHtml(String htmlText) {
    final RegExp htmlTagRegExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(htmlTagRegExp, '').trim();
  }

  static String? removeHtmlTags(String? htmlString) {
    if(htmlString == null) return null;

    final document = parse(htmlString);
    final String parsedString = document.body?.text ?? '';
    return parsedString;
  }


}