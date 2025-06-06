import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import 'components/forgot_form.dart';
import 'components/register_form.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/forgot_password.png",
              height: MediaQuery.of(context).size.height * 0.30,
                width: Get.width * .40
              // fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forgot password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding / 2),
                  const Text(
                    "Provide your account's email for which you want to reset your password!",
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  ForgotForm(formKey: _formKey),

                  const SizedBox(height: AppConstants.defaultPadding * 2),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.forgotApiResponse(authController.forgotEmailController.value.text, context);
                      }
                    },
                    child: const Text("Send", style: TextStyle(fontSize: AppConstants.defaultFontSize)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Back to"),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}