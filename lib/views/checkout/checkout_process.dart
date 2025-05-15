import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/categories/checkout_form_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import 'components/checkout_form.dart';

class CheckoutProcess extends StatefulWidget {
  const CheckoutProcess({super.key});

  @override
  State<CheckoutProcess> createState() => _CheckoutProcessState();
}

class _CheckoutProcessState extends State<CheckoutProcess> {
  CheckoutFormController checkoutFormController = Get.put(CheckoutFormController());
  ProfileController profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkoutFormController.firstNameController.value.text = profileController.addressFN.value;
    checkoutFormController.lastNameController.value.text = profileController.addressLN.value;
    checkoutFormController.streetAddressController.value.text = profileController.address.value;
    checkoutFormController.townCityController.value.text = profileController.city.value;
    checkoutFormController.postcodeZIPController.value.text = profileController.postcode.value;
    checkoutFormController.phoneController.value.text = profileController.phoneNumber.value;
    checkoutFormController.emailController.value.text = profileController.addressEmail.value;
    checkoutFormController.companyNameController.value.text = profileController.company.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("Billing & Delivery"),
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: CheckoutForm(formKey: _formKey),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamed(context, RoutesName.orderPaymentsScreen);
            }
          },
          child: const Text(
            "Continue to process",
            style: TextStyle(fontSize: AppConstants.defaultFontSize),
          ),
        ),
      ),
    );
  }
}