import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class WishlistRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> getWishlistApiCall(String userId) async {
    try {
      dynamic response = await apiServices.httpGetRequest(url: ApiUrl.getWishlistEndPoint, isTokenRequire: true, queryParams: {'user_id': userId});
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> addProductToWishlistApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.addProductToWishlistEndPoint, isTokenRequire: true, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> removeProductToWishlistApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.removeProductToWishlistEndPoint, isTokenRequire: true, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> checkProductInWishlistApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpGetRequest(url: ApiUrl.checkProductInWishlistEndPoint, isTokenRequire: true, queryParams: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }
}