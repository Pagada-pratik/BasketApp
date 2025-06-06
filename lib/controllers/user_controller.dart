import 'dart:convert';

import 'package:get/get.dart';
import 'package:mybasket247/models/product_guest_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', user.token.toString());
    pref.setString('userEmail', user.userEmail.toString());
    pref.setString('userNickname', user.userNickname.toString());
    pref.setString('userDisplayName', user.userDisplayName.toString());
    return true;
  }

  Future<bool> saveCurrentUserData(CurrentUserModel userData) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userId', userData.id.toString());
    pref.setString('description', userData.description.toString());
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString("token");
    final String? userEmail = pref.getString("userEmail");
    final String? userNickname = pref.getString("userNickname");
    final String? userDisplayName = pref.getString("userDisplayName");

    return UserModel(
      token: token.toString(),
      userEmail: userEmail.toString(),
      userNickname: userNickname.toString(),
      userDisplayName: userDisplayName.toString(),
    );
  }

  Future<CurrentUserModel> getCurrentUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? userId = pref.getString("userId");
    final String? description = pref.getString("description");

    return CurrentUserModel(
      id: userId,
      description: description,
    );
  }

  Future<bool> removeUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    return true;
  }

  Future<bool> saveProductList(List<ProductGuestModel> products) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Convert list to List<Map> then to JSON string
    final String productsJson = jsonEncode(products.map((e) => e.toJson()).toList());

    return await pref.setString('productList', productsJson);
  }

  Future<bool> addProductToList(ProductGuestModel newProduct) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Get existing list
    final String? productsJson = pref.getString('productList');
    List<ProductGuestModel> currentList = [];

    if (productsJson != null) {
      final List<dynamic> decoded = jsonDecode(productsJson);
      currentList = decoded.map((e) => ProductGuestModel.fromJson(e)).toList();
    }

    // Check if product already exists → update quantity instead of duplicating
    final index = currentList.indexWhere((p) => p.id == newProduct.id);
    if (index >= 0) {
      currentList[index] = ProductGuestModel(
        id: newProduct.id,
        quantity: currentList[index].quantity + newProduct.quantity,
      );
      print("Api -=-==->>Add>>" + currentList[index].toString());
    } else {
      currentList.add(newProduct);
    }
    print("Api -=-==->>Add>" + currentList.length.toString());
    // Save updated list
    final String updatedJson = jsonEncode(currentList.map((e) => e.toJson()).toList());
    return await pref.setString('productList', updatedJson);
  }

  Future<bool> removeProductFromList(ProductGuestModel targetProduct) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // Get existing list
    final String? productsJson = pref.getString('productList');
    List<ProductGuestModel> currentList = [];

    if (productsJson != null) {
      final List<dynamic> decoded = jsonDecode(productsJson);
      currentList = decoded.map((e) => ProductGuestModel.fromJson(e)).toList();
    }

    // Find the product
    final index = currentList.indexWhere((p) => p.id == targetProduct.id);

    if (index >= 0) {
      final existingProduct = currentList[index];

      if (existingProduct.quantity > 1) {
        // Reduce quantity by 1
        currentList[index] = ProductGuestModel(
          id: existingProduct.id,
          quantity: existingProduct.quantity - 1,
        );
      } else {
        // Remove product if quantity is 1 or less
        currentList.removeAt(index);
      }

      // Save updated list
      final String updatedJson = jsonEncode(currentList.map((e) => e.toJson()).toList());
      return await pref.setString('productList', updatedJson);
    }

    return false; // Product not found
  }


  Future<List<ProductGuestModel>> getProductList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? productsJson = pref.getString('productList');

    if (productsJson == null) return [];

    final List<dynamic> decodedList = jsonDecode(productsJson);

    return decodedList.map((json) => ProductGuestModel.fromJson(json)).toList();
  }

  Future<void> clearProductToList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('productList');
  }

  Future<bool> saveGuestEmailIdData(String emailId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('emailId', emailId.toString());
    return true;
  }

  Future<String> getGuestEmailId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? emailId = pref.getString("emailId");

    return emailId.toString();
  }
}