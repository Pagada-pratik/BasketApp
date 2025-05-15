// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes_name.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('isOnBoardingViewSuccess') != true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.onBoardingScreen, (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.entryPointScreen, (Route<dynamic> route) => false,
      );
    }
  }
}