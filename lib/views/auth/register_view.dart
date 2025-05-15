import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import 'components/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signUp_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let’s get started!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding / 2),
                  const Text(
                    "Please enter your valid data in order to create an account.",
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  RegisterForm(formKey: _formKey),
                  const SizedBox(height: AppConstants.defaultPadding),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        onChanged: (value) {
                          authController.setUserCustomer(value!);
                        },
                        value: authController.isUserCustomer.value,
                        activeColor: AppColors.primaryAppColor,
                      )),
                      const Expanded(
                        child: Text("I am a customer"),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       onChanged: (value) {},
                  //       value: false,
                  //       activeColor: AppColors.primaryAppColor,
                  //     ),
                  //     Expanded(
                  //       child: Text.rich(
                  //         TextSpan(
                  //           text: "I agree with the",
                  //           children: [
                  //             TextSpan(
                  //               recognizer: TapGestureRecognizer()
                  //                 ..onTap = () {
                  //                   // Navigator.pushNamed(
                  //                   //     context, termsOfServicesScreenRoute);
                  //                 },
                  //               text: " Terms of Service ",
                  //               style: const TextStyle(
                  //                 color: AppColors.primaryAppColor,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //             const TextSpan(
                  //               text: "& privacy policy.",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: AppConstants.defaultPadding * 2),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.registerApiResponse(authController.registerUsernameController.value.text, authController.registerEmailController.value.text, authController.registerPasswordController.value.text, authController.isUserCustomer.value, context);
                      }
                    },
                    child: const Text("Continue", style: TextStyle(fontSize: AppConstants.defaultFontSize)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
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