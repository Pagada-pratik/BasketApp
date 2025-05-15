import 'package:get/get.dart';
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
}