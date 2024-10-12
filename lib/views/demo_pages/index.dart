import 'package:flutter/material.dart';
import './album.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Demo List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text('打开相册，选择照片'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Album(),
                ),
              );
            },
          ),
          const Divider(), // 添加横线
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text('打开相机，拍照'),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          )
        ],
      ),
    );
  }
}
