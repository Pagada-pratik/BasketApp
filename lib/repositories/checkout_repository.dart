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

  Future<dynamic> updateOrderApiCall(Map<String, dynamic> params, String orderId) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          isBasicAuth: true,
          // url: ApiUrl.createOrderEndPoint,
          url: '${ApiUrl.createOrderEndPoint}/$orderId',
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> checkUserEmailApiCall(String email) async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.checkUserEmailEndPoint,
          isBasicAuth: true,
          isTokenRequire: false,
          queryParams: {'email': email});
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
          queryParams: {'customer': userId});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getGuestOrdersApiCall(String email) async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.createOrderEndPoint,
          isBasicAuth: true,
          isTokenRequire: true,
          queryParams: {'customer': "0", 'search' : email});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getOrdersComplaintApiCall(String orderId, String productId) async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.ordersComplaintEndPoint,
          isBasicAuth: false,
          isTokenRequire: true,
          queryParams: {'order_id': orderId, 'product_id': productId});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitComplaintApiCall(
      Map<String, dynamic> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
        // url: '${ApiUrl.changePasswordEndPoint}/$userId',
          url: ApiUrl.submitComplaintEndPoint,
          isBasicAuth: false,
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
