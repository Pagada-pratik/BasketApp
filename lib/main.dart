import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:mybasket247/firebase_api.dart';

import 'routes/routes.dart';
import 'routes/routes_name.dart';
import 'utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await checkFirebaseSupport();

  runApp(const MyApp());
}

Future<void> checkFirebaseSupport() async {
  if (Platform.isAndroid) {
    try {
      GooglePlayServicesAvailability availability = await GoogleApiAvailability
          .instance.checkGooglePlayServicesAvailability();

      if (availability == GooglePlayServicesAvailability.success) {
        handleFirebaseInit();
        print("Firebase initialized");
      } else {
        print("Firebase not initialized");
      }
    } catch (e) {
      print(e);
      print("Firebase not initialized");
    }
  } else if (Platform.isIOS) {
    handleFirebaseInit();
    print("Firebase initialized");
  }
}

Future<void> handleFirebaseInit() async {
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  FirebaseMessaging.onBackgroundMessage(handler);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
