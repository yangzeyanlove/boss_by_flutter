/// 配置类，用于管理HTTP请求的基础配置
class Config {
  static const String baseUrl = 'https://mockapi.eolink.com';
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // static const String _baseUrl = 'https://mockapi.eolink.com';
  // // static const int _connectTimeout = 5000;
  // // static const int _receiveTimeout = 3000;
  // static const Duration _connectTimeout = Duration(milliseconds: 5000); // 单位：毫秒
  // static const Duration _receiveTimeout = Duration(milliseconds: 3000); // 单位：毫秒
  // static const Map<String, dynamic> _headers = {
  //   'Content-Type': 'application/json',
  // };

  /// 获取基础URL
  // static String get baseUrl => _baseUrl;

  // /// 获取连接超时时间
  // static Duration get connectTimeout => _connectTimeout;

  // /// 获取接收超时时间
  // static Duration get receiveTimeout => _receiveTimeout;

  // /// 获取默认请求头
  // static Map<String, dynamic> get headers => _headers;
}
