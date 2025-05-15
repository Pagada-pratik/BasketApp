import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutFormController extends GetxController {
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var streetAddressController = TextEditingController().obs;
  var townCityController = TextEditingController().obs;
  var postcodeZIPController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var companyNameController = TextEditingController().obs;
  var orderNotesController = TextEditingController().obs;
  RxBool isOrderUpdates = true.obs;

  void setOrderUpdates(bool value) {
    isOrderUpdates.value = value;
  }
}