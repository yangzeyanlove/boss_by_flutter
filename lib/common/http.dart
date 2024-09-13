import 'package:dio/dio.dart';
import '../config.dart';

class Http {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    headers: Config.defaultHeaders,
  ));

  // 初始化拦截器
  Http() {
    _initInterceptors();
  }

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
  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final response =
          await _dio.get(url, options: Options(), queryParameters: params);
      return response;
    } on DioException catch (e) {
      // print('整个DioException对象: $e');
      rethrow;
    }
  }

  // POST请求
  Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
