import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class ProfileRepository {
  NetworkApiServices apiServices = NetworkApiServices();

  Future<dynamic> getUserProfileAndAddressApiCall() async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.getUserProfileAndAddressEndPoint, isTokenRequire: true);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserProfileApiCall(
      Map<String, dynamic> params, String userId) async {
    try {
      dynamic response = await apiServices.httpPutRequest(
          url: '${ApiUrl.updateUserProfileEndPoint}/$userId',
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> changePasswordApiCall(
      Map<String, dynamic> params, String userId) async {
    try {
      dynamic response = await apiServices.httpPostRequest(
          // url: '${ApiUrl.changePasswordEndPoint}/$userId',
          url: ApiUrl.changePasswordEndPoint,
          isTokenRequire: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserAddressApiCall(
      Map<String, dynamic> params, String userId) async {
    try {
      dynamic response = await apiServices.httpPutRequest(
          url: '${ApiUrl.updateUserProfileAndAddressEndPoint}/$userId',
          isTokenRequire: true,
          isBasicAuth: true,
          parameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
