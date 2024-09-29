import 'package:get/get.dart';
// import 'package:flutter/material.dart';
import '../../common/http_request.dart';

class MessageController extends GetxController {
  final _http = HttpRequest();
  // 不需要观察数据
  List<String> tabs = ['全部', '新招呼', '仅沟通', '有交换'];
  // 当前tab
  RxInt currentTab = 0.obs;
  RxBool isLoading = false.obs; // 是否正在请求
  RxList<dynamic> listData = [].obs; // 列表数据
  // 全部数据
  RxList<dynamic> allData = [].obs;
  // 其他数据
  List otherData = [
    {
      "uid": 1141998241,
      "name": "易宝软件 发布了新职位",
      "avatar": "",
      "brandName": "",
      "title": "",
      "date": "09:33",
      "type": "",
      "content": "40位Boss新发布",
      "isLatest": true,
      "isNotice": false
    },
    {
      "uid": 1141998241,
      "name": "通知",
      "avatar": "",
      "brandName": "系统通知",
      "title": "",
      "date": "星期四",
      "type": "",
      "content": "简历曝光将降低",
      "isLatest": false,
      "isNotice": true
    }
  ];

  @override
  void onInit() {
    super.onInit();
    // 触发获取数据
    fetchData();
  }

  // 请求接口，获取数据
  Future<void> fetchData({bool isFresh = false}) async {
    print('doing ChatController fetch data...');
    isLoading.value = true;

    // 模拟延迟2s
    // await Future.delayed(const Duration(milliseconds: 300));

    try {
      Map<String, dynamic> responseData = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/chat/list-content');
      // 如果是刷新
      if (isFresh) {
        listData.value = responseData['zpData']['result'];
      } else {
        listData.addAll(responseData['zpData']['result']);
      }
      allData
        ..addAll(otherData)
        ..addAll(listData);
      isLoading.value = false;
    } catch (error) {
      rethrow;
    }
  }
}
