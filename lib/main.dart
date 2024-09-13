import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() {
  // 启动应用程序
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 此小部件是应用程序的根
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 关闭调试模式下的横幅
      title: 'Flutter Demo', // 应用程序标题
      theme: ThemeData(
        useMaterial3: true, // 使用 Material 3 样式
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff00bebd)), // 设置主题颜色方案
      ),
      home: const HomePage(), // 设置首页为 BottomNavigation 小部件
    );
  }
}
