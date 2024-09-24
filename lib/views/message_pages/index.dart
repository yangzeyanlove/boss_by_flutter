import "package:flutter/material.dart";

class MessageIndexPage extends StatelessWidget {
  const MessageIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("消息111"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text("这是消息页面"),
      ),
    );
  }
}
