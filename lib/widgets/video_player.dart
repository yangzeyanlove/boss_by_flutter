import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// 自定义的视频播放器Widget
class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl; // 视频的URL
  final double width; // 容器宽度
  final double height; // 容器高度

  /// 构造函数
  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.width,
    required this.height,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    // 创建一个VideoPlayerController实例，并加载视频文件
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    // 初始化视频播放器
    await _controller.initialize();

    // 设置初始化标志
    setState(() {
      _isInitialized = true;
    });

    // 当视频准备好播放时开始播放
    // _controller.play();

    // 监听视频播放状态的变化
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        // 如果视频播放结束，设置为停止状态
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      // 如果正在播放，则暂停
      _controller.pause();
    } else {
      // 否则开始播放
      _controller.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return GestureDetector(
        onTap: _togglePlayPause, // 添加点击事件
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // 可选，增加边框
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              if (!_isPlaying && _controller.value.isInitialized)
                const Center(
                  child: Icon(Icons.play_arrow, size: 50, color: Colors.white),
                ),
            ],
          ),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator()); // 显示加载指示器
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
