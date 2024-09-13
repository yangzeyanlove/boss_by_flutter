import "package:flutter/material.dart";

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("消息"),
      ),
      body: const Center(
        child: Text("这是消息页面"),
      ),
    );
  }
}
