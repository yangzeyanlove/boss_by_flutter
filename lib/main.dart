import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'config.dart';

void main() {
  // 启动应用程序
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 此小部件是应用程序的根
  @override
  Widget build(BuildContext context) {
    List<String> fontFamilyList =
        defaultTargetPlatform == TargetPlatform.android
            ? const [
                "SourceHanSansSC",
              ]
            : const [
                "PingFang SC",
              ];

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 关闭调试模式下的横幅
      title: 'Boss by flutter', // 应用程序标题
      theme: ThemeData(
        fontFamilyFallback: fontFamilyList,
        scaffoldBackgroundColor: const Color(0xffF5F5F5), // 默认背景颜色
        useMaterial3: true, // 使用 Material 3 样式
        colorScheme:
            ColorScheme.fromSeed(seedColor: Config.primaryColor), // 设置主题颜色方案
      ),
      home: const HomePage(), // 设置首页为 BottomNavigation 小部件
    );
  }
}
