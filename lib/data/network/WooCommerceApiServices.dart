import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../resources/constants.dart';
import '../common_exceptions.dart';
import 'NetworkApiServices.dart';

class WooCommerceApiServices extends NetworkApiServices {
  Future<dynamic> httpGetWooCommerceRequest({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      var headerMap = <String, String>{};
      headerMap['accept'] = "application/json";

      String basicAuth = 'Basic ${base64Encode(utf8.encode('${AppConstants.consumerKey}:${AppConstants.consumerSecret}'))}';
      headerMap['Authorization'] = basicAuth;

      if (headers != null) headerMap.addAll(headers);

      if (queryParams != null && queryParams.isNotEmpty) {
        url = '$url?${mapToQuery(queryParams)}';
      }

      if (kDebugMode) {
        log("WooCommerce request ==------------------");
        log("URL      ==> $url");
        log("headers  ==> $headerMap");
        log("WooCommerce request ==-------------------");
      }

      http.Response res = await http.get(getUri(url), headers: headerMap);

      if (kDebugMode) {
        log("WooCommerce response ==------------------");
        log("Status Code ==> ${res.statusCode}");
        log("Response Body ==> ${res.body}");
        log("WooCommerce response ==-------------------");
      }

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        return body;
      } else {
        throw CommonException(
          code: res.statusCode,
          message: "Failed to fetch data. Status code: ${res.statusCode}",
        );
      }
    } catch (e, s) {
      if (kDebugMode) {
        log("Exception in WooCommerce API call: $e");
        log("StackTrace: $s");
      }
      throw CommonException(code: 407, message: FixedException.errorUnknown);
    }
  }
}