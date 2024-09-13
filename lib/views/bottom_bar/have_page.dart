import 'package:flutter/material.dart';

class HavePage extends StatelessWidget {
  const HavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('有了'),
      ),
      body: const Center(child: Text('这是有了页面')),
    );
  }
}
