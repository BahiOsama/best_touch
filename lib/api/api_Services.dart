import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:second_project/helper/local_data/shared_pref.dart';

class ApiServices {
  final Dio dio;

  final baseurl = 'https://demo.best-touch.online';

  Future<Map<String, dynamic>> getHeaders() async {
    final token = CashedSharedPrefrances.getData(key: 'token');

    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  ApiServices({required this.dio}) {
    dio.interceptors.addAll(kDebugMode
        ? [
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              compact: false,
              error: true,
              request: true,
            ),
          ]
        : []);
  }
  Future get(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      dynamic body}) async {
    var response = await dio.get('$baseurl$endPoint',
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers ?? await getHeaders()));
    return response.data;
  }

  Future post(
      {required String endPoint,
      dynamic body,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    var response = await dio.post('$baseurl$endPoint',
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers ?? await getHeaders()));
    return response.data;
  }
}
