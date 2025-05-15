import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class CartRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> addProductToCartApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          url: ApiUrl.addProductToCartEndPoint,
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCartForUserApiCall() async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.getCartForUserEndPoint, isTokenRequire: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkProductInCartApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.checkProductInCartEndPoint,
          isTokenRequire: true,
          queryParams: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProductInCartApiCall(
      String itemKay, Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          url: '${ApiUrl.updateProductInCartEndPoint}/$itemKay',
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> removeProductFromCartApiCall(String itemKay) async {
    try {
      dynamic response = await apiServices.httpDeleteRequest(
          url: '${ApiUrl.updateProductInCartEndPoint}/$itemKay',
          isTokenRequire: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> clearCartApiCall() async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          url: ApiUrl.clearCartEndPoint, isTokenRequire: true, parameters: {});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> notifyMeApiCall(Map<String, dynamic> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          url: ApiUrl.notifyMeEndPoint,
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
