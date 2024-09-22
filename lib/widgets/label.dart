import 'package:flutter/material.dart';
import '../../config.dart';

class LabelWidget extends StatelessWidget {
  final String str;
  const LabelWidget({super.key, required this.str});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: const Color(0xfff8f8f8), // 灰色背景
          borderRadius: BorderRadius.circular(2.0), // 圆角
        ),
        child: Text(str,
            style: const TextStyle(fontSize: 12, color: Config.lightColor)));
  }
}
