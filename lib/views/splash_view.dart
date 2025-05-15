// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../resources/constants.dart';
import '../services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () async {
        splashServices.checkAuthentication(context);
        await profileController.displayUserData(context, true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Get.height * .3,
          child: Image.asset(AppConstants.appLogo),
        ),
      ),
    );
  }
}