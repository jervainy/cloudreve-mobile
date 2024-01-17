import 'dart:io';
import 'package:cloudreve_mobile/common/global.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpDio {

  static final Dio dio = Dio(BaseOptions(
    headers: {
      HttpHeaders.authorizationHeader: Global.readToken() ?? ''
    }
  ));

  static void init() {
    if (Global.readServerAddress() != null) {
      dio.options.baseUrl = Global.readServerAddress()!;
    }
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(LogInterceptor(responseBody: false));
    if (!Global.release) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  static Future pong(String url) {
    return dio.get('/');
  }

  static void setBaseurl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

}


class SimpleLogDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}