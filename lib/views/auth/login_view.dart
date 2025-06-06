import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../../utils/ars_progress_dialog.dart';
import '../../utils/custom_loading.dart';
import 'components/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();

    authController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    if (kDebugMode) {
      authController.emailController.value.text = 'admin@netinfoweb.net';
      authController.passwordController.value.text = '#^%he123^#';
    }
  }

  @override
  void dispose() {
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding / 2),
                  const Text(
                    "Log in with your data that you entered during your registration.",
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  LogInForm(formKey: authController.formKey),
                  Align(
                    child: TextButton(
                      child: const Text("Forgot your password?"),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forgotScreen);
                      },
                    ),
                  ),
                  const SizedBox(height: AppConstants.defaultPadding * 3),
                  ElevatedButton(
                    onPressed: () {
                      if (authController.formKey.currentState!.validate()) {
                        authController.loginApiResponse(authController.emailController.value.text, authController.passwordController.value.text, context);
                      }
                    },
                    child: const Text("Log in", style: TextStyle(fontSize: AppConstants.defaultFontSize)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.registerScreen);
                        },
                        child: const Text("Register here"),
                      ),
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