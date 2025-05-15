import 'dart:developer';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../resources/api_url.dart';

class HomeRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> homeSliderApiCall() async {
    try {
      dynamic response =
          await apiServices.httpGetRequest(url: ApiUrl.imageSliderEndPoint);
      log('message  ${response.toString()}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> homeCategoriesApiCall() async {
    try {
      dynamic response =
          await apiServices.httpGetRequest(url: ApiUrl.homeCategoriesEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> onSaleBannerApiCall() async {
    try {
      dynamic response =
          await apiServices.httpGetRequest(url: ApiUrl.onSaleBannerEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> onSaleProductsApiCall() async {
    try {
      dynamic response =
          await apiServices.httpGetRequest(url: ApiUrl.onSaleProductsEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> sectionBaseHomeProductsApiCall() async {
    try {
      dynamic response = await apiServices.httpGetRequest(
          url: ApiUrl.sectionBaseHomeProductsEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
