import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';
import '../../../controllers/update/address_update_controller.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../utils/ars_progress_dialog.dart';
import '../../../utils/custom_loading.dart';

class AddressUpdateView extends StatefulWidget {
  const AddressUpdateView({super.key});

  @override
  State<AddressUpdateView> createState() => _AddressUpdateViewState();
}

class _AddressUpdateViewState extends State<AddressUpdateView> {
  final _formKey = GlobalKey<FormState>();
  AddressUpdateController addressUpdateController = Get.put(AddressUpdateController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    addressUpdateController.progressDialog = ArsProgressDialog(
      context,
      dismissable: false,
      loadingWidget: const CustomLoading(),
    );

    addressUpdateController.firstNameController.value.text = profileController.addressFN.value;
    addressUpdateController.lastNameController.value.text = profileController.addressLN.value;
    addressUpdateController.companyController.value.text = profileController.company.value;
    addressUpdateController.addressController.value.text = profileController.address.value;
    addressUpdateController.cityController.value.text = profileController.city.value;
    addressUpdateController.postcodeController.value.text = profileController.postcode.value;
    // addressUpdateController.countryController.value.text = profileController.country.value;
    // addressUpdateController.stateController.value.text = profileController.state.value;
    addressUpdateController.countryController.value.text = 'Cyprus';
    addressUpdateController.stateController.value.text = 'Cyprus';
    addressUpdateController.emailController.value.text = profileController.addressEmail.value;
    addressUpdateController.phoneNumberController.value.text = profileController.phoneNumber.value;
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
        title: const Text("Update Billing Address"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("First name *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.firstNameController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "First name",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Last name *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.lastNameController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "Last name",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Company (optional)"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.companyController.value,
                      // validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "Company",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Address *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.addressController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "Address",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("City *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.cityController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: "City",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Postcode *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.postcodeController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primaryAppColor,
                      decoration: const InputDecoration(
                        hintText: "Postcode",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Country *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.countryController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: AppColors.primaryAppColor,
                      textCapitalization: TextCapitalization.words,
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        hintText: "Country",
                      ),
                    ),
                    // const SizedBox(height: AppConstants.defaultPadding),
                    // const Text("State *"),
                    // const SizedBox(height: 2),
                    // TextFormField(
                    //   controller: addressUpdateController.stateController.value,
                    //   validator: AppConstants.reviewValidator.call,
                    //   textInputAction: TextInputAction.next,
                    //   keyboardType: TextInputType.text,
                    //   cursorColor: AppColors.primaryAppColor,
                    //   textCapitalization: TextCapitalization.words,
                    //   decoration: const InputDecoration(
                    //     hintText: "State",
                    //   ),
                    // ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Email address *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.emailController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColors.primaryAppColor,
                      decoration: const InputDecoration(
                        hintText: "Email address",
                      ),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text("Phone *"),
                    const SizedBox(height: 2),
                    TextFormField(
                      controller: addressUpdateController.phoneNumberController.value,
                      validator: AppConstants.reviewValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      cursorColor: AppColors.primaryAppColor,
                      decoration: const InputDecoration(
                        hintText: "Phone",
                      ),
                      // inputFormatters: [
                      //   LengthLimitingTextInputFormatter(10),
                      // ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              addressUpdateController.updateUserAddressApiResponse(context, profileController.userId.toString());
            }
          },
          child: const Text(
            "Update",
            style: TextStyle(fontSize: AppConstants.defaultFontSize),
          ),
        ),
      ),
    );
  }
}