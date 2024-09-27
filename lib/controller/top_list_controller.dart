// 有了栏目，精选列表
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/http_request.dart';

class TopListController extends GetxController {
  final _http = HttpRequest();
  RxBool isLoading = false.obs; // 控制重复请求
  RxList<dynamic> listData = [].obs; // 列表数据
  // 缓存key，缓存页面状态，滚动状态
  final PageStorageKey<String> pageKey =
      const PageStorageKey<String>('have-top-list');

  @override
  void onInit() {
    super.onInit();
    // 触发获取数据
    fetchData();
  }

  // 获取列表数据
  Future<void> fetchData({bool isFresh = false}) async {
    isLoading.value = true;
    // 模拟延迟2s
    // await Future.delayed(const Duration(milliseconds: 500));

    try {
      Map<String, dynamic> responseData = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/have/toplist');
      // 如果是刷新
      if (isFresh) {
        listData.value = responseData['zpData']['list'];
      } else {
        listData.addAll(responseData['zpData']['list']);
      }
      isLoading.value = false;
    } catch (error) {
      rethrow;
    }
  }
}
