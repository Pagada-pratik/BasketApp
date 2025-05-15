import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/constants.dart';
import '../common_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future httpPostRequest({
    required String url,
    required Map parameters,
    Map<String, String>? headers,
    bool isTokenRequire = false,
    bool isBasicAuth = false,
  }) async {
    try {
      var headerMap = <String, String>{};
      headerMap['Content-Type'] = "application/json";

      if (isTokenRequire) {
        if (!isBasicAuth) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = pref.getString("token") ??
              AppConstants.wooCommerceAuthorizationToken;
          headerMap['Authorization'] = 'Bearer $token';
        } else {
          headerMap['Authorization'] =
              'Basic ${base64.encode(utf8.encode('${AppConstants.consumerKey}:${AppConstants.consumerSecret}'))}';
        }
      }
      if (headers != null) headerMap.addAll(headers);

      if (kDebugMode) {
        log("request ==------------------");
        log("URL      ==> POST $url");
        log("headers  ==> $headerMap");
        log("params   ==> $parameters");
        log("request ==-------------------");
      }

      http.Response res = await http.post(
        getUri(url),
        body: jsonEncode(parameters),
        headers: headerMap,
      );

      if (kDebugMode) {
        log("response ==------------------");
        log("URL      ==> ${res.statusCode} $url");
        log("headers  ==> $headerMap");
        log("params   ==> $parameters");
        log("response ==> ${res.body}");
        log("response ==-------------------");
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        dynamic body = jsonDecode(res.body);
        return body;
      } else {
        String responseMessage = FixedException.errorUnknown;
        dynamic body = jsonDecode(res.body);
        if (body['message'] != null) {
          if (body['message'] is List && body['message'].isNotEmpty) {
            responseMessage = body['message'][0];
          } else {
            responseMessage = body['message'].toString();
          }
        }
        throw CommonException(code: res.statusCode, message: responseMessage);
      }
    } catch (e, s) {
      if (e is CommonException) rethrow;
      if (kDebugMode) {
        print("Exception $e");
        print("StackTrace $s");
      }
      if (e is TimeoutException || e is SocketException) {
        throw CommonException(code: 408, message: FixedException.errorTimeout);
      }
      throw CommonException(code: 407, message: FixedException.errorUnknown);
    }
  }

  @override
  Future httpGetRequest({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool isTokenRequire = false,
    bool isBasicAuth = false,
  }) async {
    try {
      var headerMap = <String, String>{};
      headerMap['accept'] = "application/json";

      if (isTokenRequire) {
        if (!isBasicAuth) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = pref.getString("token") ??
              AppConstants.wooCommerceAuthorizationToken;
          headerMap['Authorization'] = 'Bearer $token';
        } else {
          headerMap['Authorization'] =
              'Basic ${base64.encode(utf8.encode('${AppConstants.consumerKey}:${AppConstants.consumerSecret}'))}';
        }
      }
      if (headers != null) headerMap.addAll(headers);

      if (queryParams != null && queryParams.isNotEmpty) {
        url = '$url?${mapToQuery(queryParams)}';
      }

      if (kDebugMode) {
        log("request ==------------------");
        log("URL      ==> GET $url");
        log("headers  ==> $headerMap");
        log("request ==-------------------");
      }

      http.Response res = await http.get(getUri(url), headers: headerMap);

      if (kDebugMode) {
        log("response ==------------------");
        log("URL      ==> ${res.statusCode} $url");
        log("headers  ==> $headerMap");
        log("response ==> ${res.body}");
        log("response ==-------------------");
      }

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        return body;
      } else {
        String responseMessage = FixedException.errorUnknown;
        dynamic body = jsonDecode(res.body);
        if (body['message'] != null) {
          if (body['message'] is List && body['message'].isNotEmpty) {
            responseMessage = body['message'][0];
          } else {
            responseMessage = body['message'].toString();
          }
        }
        throw CommonException(code: res.statusCode, message: responseMessage);
      }
    } catch (e, s) {
      if (e is CommonException) rethrow;
      if (kDebugMode) {
        print("Exception $e");
        print("StackTrace $s");
      }
      if (e is TimeoutException || e is SocketException) {
        throw CommonException(code: 408, message: FixedException.errorTimeout);
      }
      throw CommonException(code: 407, message: FixedException.errorUnknown);
    }
  }

  @override
  Future httpDeleteRequest({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    bool isTokenRequire = false,
    bool isBasicAuth = false,
  }) async {
    try {
      var headerMap = <String, String>{};
      headerMap['accept'] = "application/json";

      if (isTokenRequire) {
        if (!isBasicAuth) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = pref.getString("token") ??
              AppConstants.wooCommerceAuthorizationToken;
          headerMap['Authorization'] = 'Bearer $token';
        } else {
          headerMap['Authorization'] =
              'Basic ${base64.encode(utf8.encode('${AppConstants.consumerKey}:${AppConstants.consumerSecret}'))}';
        }
      }
      if (headers != null) headerMap.addAll(headers);

      if (queryParams != null && queryParams.isNotEmpty) {
        url = '$url?${mapToQuery(queryParams)}';
      }

      if (kDebugMode) {
        log("request ==------------------");
        log("URL      ==> DELETE $url");
        log("headers  ==> $headerMap");
        log("request ==-------------------");
      }

      http.Response res = await http.delete(getUri(url), headers: headerMap);

      if (kDebugMode) {
        log("response ==------------------");
        log("URL      ==> ${res.statusCode} $url");
        log("headers  ==> $headerMap");
        log("response ==> ${res.body}");
        log("response ==-------------------");
      }

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        return body;
      } else {
        String responseMessage = FixedException.errorUnknown;
        dynamic body = jsonDecode(res.body);
        if (body['message'] != null) {
          if (body['message'] is List && body['message'].isNotEmpty) {
            responseMessage = body['message'][0];
          } else {
            responseMessage = body['message'].toString();
          }
        }
        throw CommonException(code: res.statusCode, message: responseMessage);
      }
    } catch (e, s) {
      if (e is CommonException) rethrow;
      if (kDebugMode) {
        print("Exception $e");
        print("StackTrace $s");
      }
      if (e is TimeoutException || e is SocketException) {
        throw CommonException(code: 408, message: FixedException.errorTimeout);
      }
      throw CommonException(code: 407, message: FixedException.errorUnknown);
    }
  }

  @override
  Future httpPutRequest({
    required String url,
    required Map parameters,
    Map<String, String>? headers,
    bool isTokenRequire = false,
    bool isBasicAuth = false,
  }) async {
    try {
      var headerMap = <String, String>{};
      headerMap['Content-Type'] = "application/json";

      if (isTokenRequire) {
        if (!isBasicAuth) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = pref.getString("token") ??
              AppConstants.wooCommerceAuthorizationToken;
          headerMap['Authorization'] = 'Bearer $token';
        } else {
          headerMap['Authorization'] =
              'Basic ${base64.encode(utf8.encode('${AppConstants.consumerKey}:${AppConstants.consumerSecret}'))}';
        }
      }
      if (headers != null) headerMap.addAll(headers);

      if (kDebugMode) {
        log("request ==------------------");
        log("URL      ==> PUT $url");
        log("headers  ==> $headerMap");
        log("params   ==> $parameters");
        log("request ==-------------------");
      }

      http.Response res = await http.put(
        getUri(url),
        body: jsonEncode(parameters),
        headers: headerMap,
      );

      if (kDebugMode) {
        log("response ==------------------");
        log("URL      ==> ${res.statusCode} $url");
        log("headers  ==> $headerMap");
        log("params   ==> $parameters");
        log("response ==> ${res.body}");
        log("response ==-------------------");
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        dynamic body = jsonDecode(res.body);
        return body;
      } else {
        String responseMessage = FixedException.errorUnknown;
        dynamic body = jsonDecode(res.body);
        if (body['message'] != null) {
          if (body['message'] is List && body['message'].isNotEmpty) {
            responseMessage = body['message'][0];
          } else {
            responseMessage = body['message'].toString();
          }
        }
        throw CommonException(code: res.statusCode, message: responseMessage);
      }
    } catch (e, s) {
      if (e is CommonException) rethrow;
      if (kDebugMode) {
        print("Exception $e");
        print("StackTrace $s");
      }
      if (e is TimeoutException || e is SocketException) {
        throw CommonException(code: 408, message: FixedException.errorTimeout);
      }
      throw CommonException(code: 407, message: FixedException.errorUnknown);
    }
  }

  Uri getUri(String apiPath) {
    return Uri.parse(apiPath);
  }

  String mapToQuery(Map<String, String?> map, {Encoding encoding = utf8}) {
    var pairs = <List<String>>[];
    map.forEach((key, value) => pairs.add([
          Uri.encodeQueryComponent(key, encoding: encoding),
          Uri.encodeQueryComponent(value!, encoding: encoding),
        ]));
    return pairs.map((pair) => '${pair[0]}=${pair[1]}').join('&');
  }
}
