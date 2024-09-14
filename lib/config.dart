import 'package:flutter/material.dart';

/// 配置类，用于管理HTTP请求的基础配置
class Config {
  /// 请求配置
  static const String baseUrl = 'https://mockapi.eolink.com';
  static const Duration connectTimeout =
      Duration(milliseconds: 5000); // 链接超时时间，单位：毫秒
  static const Duration receiveTimeout =
      Duration(milliseconds: 5000); // 获取接收超时时间，单位：毫秒
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // 颜色配置
  static const Color primaryColor = Color(0xFF17989D); // 主题色
  static const Color secondaryColor = Color(0xFF6CD8D8);
  // 定义字体颜色，除了默认字体颜色
  static const Color lightColor = Color(0xFF666666);
}
