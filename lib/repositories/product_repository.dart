import '../data/network/WooCommerceApiServices.dart';
import '../resources/api_url.dart';

class ProductRepository {
  WooCommerceApiServices apiWooCommerce = WooCommerceApiServices();

  Future<dynamic> getProductsByCategoryIdApiCall(int categoryId) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
          url: ApiUrl.getProductsByIdEndPoint,
          queryParams: {'category': '$categoryId'});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductsByCategoryIdSortingApiCall(int categoryId, String orderBy, String order) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
          url: ApiUrl.getProductsByIdEndPoint,
          queryParams: {'category': '$categoryId',
            'orderby': '$orderBy',
            'order': '$order',});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCompareProductsApiCall(List<String> productIDs) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
          url: buildWooCommerceUrl(ApiUrl.getProductsByIdEndPoint, productIDs).toString(),
          /*queryParams: {
            'include[]': productIDs,
          }*/);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Uri buildWooCommerceUrl(String baseUrl, List<String> includeIds) {
    final uri = Uri.parse(baseUrl);
    final queryParameters = <String, dynamic>{};

    for (var id in includeIds) {
      queryParameters.putIfAbsent('include[]', () => []).add(id);
    }

    return uri.replace(queryParameters: queryParameters);
  }

  Future<dynamic> getProductsByProductIdApiCall(int productId) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
          url: '${ApiUrl.getProductsByIdEndPoint}/$productId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductsByCategoryAndExcludeProductIdApiCall({
    required int categoryId,
    required int excludeProductId,
  }) async {
    try {
      final queryParams = {
        'category': '$categoryId',
        'exclude': '$excludeProductId',
      };
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
        url: ApiUrl.getProductsByIdEndPoint,
        queryParams: queryParams,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getAllProductsApiCall(int perPageCount) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(
          url: ApiUrl.getProductsByIdEndPoint,
          queryParams: {'per_page': '$perPageCount'});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
