import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://m.amap.com/search/mapview/keywords=%E6%B7%B1%E5%9C%B3%E5%8D%97%E5%B1%B1%E5%A4%A7%E5%86%B2%E5%9C%B0%E9%93%81%E7%AB%99'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          Positioned(
            top: MediaQuery.of(context).padding.top, // 根据需要调整位置
            left: 0,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
