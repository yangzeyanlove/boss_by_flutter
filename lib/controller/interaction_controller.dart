import 'package:get/get.dart';
import '../../common/http_request.dart';

class InteractionController extends GetxController {
  final _http = HttpRequest();
  RxList<dynamic> listData = [].obs; // 列表数据
  RxBool isLoading = false.obs; // 是否正在请求

  // 不需要观察数据
  List<String> tabs = ['对我感兴趣', '看过我', '新职位'];

  @override
  void onInit() {
    super.onInit();
    // 触发获取数据
    fetchData();
  }

  // 请求接口，获取数据
  Future<void> fetchData({bool isFresh = false}) async {
    print('doing Interaction controller fetch data...');
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
}
