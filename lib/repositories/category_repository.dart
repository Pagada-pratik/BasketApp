import '../data/network/WooCommerceApiServices.dart';
import '../resources/api_url.dart';

class CategoryRepository {
  WooCommerceApiServices apiWooCommerce = WooCommerceApiServices();

  Future<dynamic> getAllCategoriesApiCall(int pageCount) async {
    try {
      dynamic response = await apiWooCommerce.httpGetWooCommerceRequest(url: ApiUrl.categoriesEndPoint, queryParams: {'per_page': '$pageCount'});
      return response;
    } catch(e) {
      rethrow;
    }
  }
}