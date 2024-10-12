import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Album extends StatefulWidget {
  const Album({super.key});

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // 或 ImageSource.camera
    if (pickedFile != null) {
      // 处理选中的图片
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('相册demo'),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () {
              selectImage();
            },
            child: const Text('选择'),
          ),
          _selectedImage != null
              ? Image.file(
                  _selectedImage!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : const Text('未选择照片'),
        ],
      ),
    );
  }
}
