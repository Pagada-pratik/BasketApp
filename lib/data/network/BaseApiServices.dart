abstract class BaseApiServices {
  Future<dynamic> httpPostRequest({
    required String url,
    required Map parameters,
    Map<String, String>? headers,
    bool isTokenRequire = false,
  });

  Future<dynamic> httpGetRequest({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool isTokenRequire = false,
  });

  Future<dynamic> httpDeleteRequest({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool isTokenRequire = false,
  });

  Future<dynamic> httpPutRequest({
    required String url,
    required Map parameters,
    Map<String, String>? headers,
    bool isTokenRequire = false,
  });
}