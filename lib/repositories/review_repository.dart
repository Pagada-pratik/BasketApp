import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class ReviewRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> createReviewApiCall(Map<String, String> params) async {
    try {
      dynamic response = await apiServices.httpPostRequest(url: ApiUrl.createReviewEndPoint, isTokenRequire: true, parameters: params);
      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> getReviewByProductIDApiCall(String productId) async {
    try {
      dynamic response = await apiServices.httpGetRequest(url: '${ApiUrl.getReviewByProductIDEndPoint}/$productId/reviews', isTokenRequire: true);
      return response;
    } catch(e) {
      rethrow;
    }
  }
}