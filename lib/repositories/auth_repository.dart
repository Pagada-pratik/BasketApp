import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class AuthRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> loginApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.loginEndPoint, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> registerApiCall(Map<String, dynamic> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.registerEndPoint, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> forgotApiCall(Map<String, dynamic> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.forgotEndPoint, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> getCurrentUserApiCall() async {
    try {
      dynamic response = await apiServices.httpGetRequest(url: ApiUrl.getCurrentUserEndPoint, isTokenRequire: true);
      return response;
    } catch(e) {
      rethrow;
    }
  }
}