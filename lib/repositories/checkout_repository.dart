import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class CheckoutRepository {
  NetworkApiServices apiServices = NetworkApiServices();

  Future<dynamic> createOrderApiCall(Map<String, dynamic> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          isBasicAuth: true,
          url: ApiUrl.createOrderEndPoint,
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> couponsDiscountApiCall() async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          isBasicAuth: true,
          url: ApiUrl.couponsDiscountEndPoint,
          isTokenRequire: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getMyOrdersApiCall(String userId) async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.createOrderEndPoint,
          isBasicAuth: true,
          isTokenRequire: true,
          queryParams: {'customer_id': userId});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
