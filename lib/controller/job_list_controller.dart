import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/http_request.dart';

// 生命周期钩子介绍
// 1. onInit 当控制器初始化时调用。
// 2. onReady 在控制器初始化完成并且所有依赖关系已经注入之后调用。
// 4. onResume 当应用程序从后台恢复到前台时调用。
// 5. onPause 当应用程序从前台切换到后台时调用。
// 7. onClose() 描述: 当控制器即将被销毁时调用。

// 职位列表页控制器
class JobListController extends GetxController {
  final _http = HttpRequest();
  RxList<dynamic> listData = [].obs; // 列表数据
  RxBool isLoading = false.obs; // 是否正在请求
  // 滚动控制器
  final ScrollController scrollController = ScrollController(); // 控制滚动监听
  // 不需要观察的数据
  List<String> tabLabels = ['全部', '附近', '最新'];
  List<String> filterType = ['深圳', '筛选'];

  @override
  void onInit() {
    super.onInit();
    // 滚动监听
    scrollController.addListener(_onScrollEvent);
    // 触发获取数据
    fetchData();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScrollEvent);
    scrollController.dispose();
    super.onClose();
  }

  // 滚动触发事件
  void _onScrollEvent() {
    if (!scrollController.position.outOfRange &&
        scrollController.position.maxScrollExtent == scrollController.offset &&
        !isLoading.value) {
      fetchData();
    }
  }

  // 请求接口，获取数据
  Future<void> fetchData({bool isFresh = false}) async {
    print('doing job_list controller fetch data...');
    isLoading.value = true;

    // 模拟延迟2s
    // await Future.delayed(const Duration(milliseconds: 300));

    try {
      Map<String, dynamic> responseData = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/job/new-list');
      // 如果是刷新
      if (isFresh) {
        listData.value = responseData['zpData']['jobList'];
      } else {
        listData.addAll(responseData['zpData']['jobList']);
      }
      isLoading.value = false;
    } catch (error) {
      rethrow;
    }
  }

  // 滚动回顶部
  void scrollTop() {
    scrollController.jumpTo(scrollController.initialScrollOffset);
  }
}
