// 职位详情控制器
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class JobDetailController extends GetxController {
  // 控制appBar背景透明度
  RxDouble appBarOpacity = 0.0.obs;
  // 滚动控制器
  final ScrollController scrollController = ScrollController(); // 控制滚动监听

  @override
  void onInit() {
    super.onInit();
    // 滚动监听
    scrollController.addListener(_onScrollEvent);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScrollEvent);
    scrollController.dispose();
    super.onClose();
  }

  // 滚动触发事件
  void _onScrollEvent() {
    double offset = scrollController.offset;
    double appBarHeight = kToolbarHeight; // appBar的高度
    if (offset < appBarHeight) {
      appBarOpacity.value = (offset > 0 ? offset : 0) / appBarHeight;
    } else {
      appBarOpacity.value = 1.0;
    }
  }
}
