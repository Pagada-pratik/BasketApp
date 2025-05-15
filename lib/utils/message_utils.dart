import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:mybasket247/utils/parse_values.dart';

class MessageUtils {
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: ParseValues.removeHtmlTags(message),
        messageColor: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        titleColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        backgroundColor: Colors.black,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        icon: const Icon(Icons.error, size: 28, color: Colors.white),
        duration: const Duration(seconds: 4),
      )..show(context),
    );
  }

  static snackBarMessage(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}