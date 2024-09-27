// 有了栏目，精选列表
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../common/http_request.dart';

class GoodArticleController extends GetxController {
  final _http = HttpRequest();
  RxBool isLoading = false.obs; // 控制重复请求
  RxList<dynamic> listData = [].obs; // 列表数据
  // 缓存key，缓存页面状态，滚动状态
  final PageStorageKey<String> pageKey =
      const PageStorageKey<String>('good-article-list');

  @override
  void onInit() {
    super.onInit();
    // 触发获取数据
    fetchData();
  }

  // 获取列表数据
  Future<void> fetchData({bool isFresh = false}) async {
    print('good article fetch data');
    isLoading.value = true;
    // 模拟延迟2s
    // await Future.delayed(const Duration(milliseconds: 500));

    try {
      Map<String, dynamic> responseData = await _http
          .get('http://rap2api.taobao.org/app/mock/320664/good_article_list');
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
