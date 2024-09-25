import 'package:dio/dio.dart';
import '../config.dart';
import 'dart:convert';

class HttpRequest {
  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() {
    return _instance;
  }

  HttpRequest._internal() {
    _initInterceptors();
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    headers: Config.defaultHeaders,
  ));

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) async {
        // 添加身份验证头部或其他请求前的操作
        options.headers['Authorization'] = 'Bearer your_token_here';
        return handler.next(options);
      },
      onResponse: (Response response, handler) async {
        // 处理响应数据或错误
        if (response.statusCode == 200) {
          return handler.next(response);
        } else {
          throw Exception('Failed to load data');
        }
      },
      onError: (DioException error, handler) async {
        // 错误处理逻辑
        return handler.next(error);
      },
    ));
  }

  // GET请求
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.get(url, options: Options(), queryParameters: params);
      if (response.statusCode == 200) {
        return response.data.runtimeType == String
            ? json.decode(response.data)
            : response.data;
      }
      return {
        'code': response.statusCode,
        'message': response.statusMessage,
      };
    } on DioException catch (e) {
      // ignore: avoid_print
      print('整个DioException对象: $e');
      rethrow;
    }
  }

  // POST请求
  Future<Map<String, dynamic>> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        return json.decode(response.data);
      }
      return {
        'code': response.statusCode,
        'message': response.statusMessage,
      };
    } on DioException catch (e) {
      // ignore: avoid_print
      print('整个DioException对象: $e');
      rethrow;
    }
  }
}
