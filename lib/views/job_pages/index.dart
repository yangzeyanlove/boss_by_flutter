import 'package:flutter/material.dart';
import '../../config.dart';
import '../../common/http_request.dart';
import '../../widgets/job_card.dart';
import 'dart:math' as math;

final GlobalKey<RefreshIndicatorState> _jobIndexRefreshKey =
    GlobalKey<RefreshIndicatorState>(); // 控制下拉刷新
final ScrollController _jobIndexScrollController = ScrollController(); // 控制滚动监听

class JobIndexPage extends StatelessWidget {
  const JobIndexPage({super.key});

  // 顶部标签按钮，全部/附近/最新
  Widget _getTopLabel() {
    List<Widget> list = [];
    List<String> labels = ['全部', '附近', '最新'];
    for (var i = 0; i < labels.length; i++) {
      list.add(
        InkWell(
          onTap: () {
            // 滚动会顶部
            _jobIndexScrollController
                .jumpTo(_jobIndexScrollController.initialScrollOffset);
            // 点击文本时要执行的操作
            _jobIndexRefreshKey.currentState?.show();
          },
          child: Text(labels[i], style: const TextStyle(fontSize: 13)),
        ),
      );
      list.add(const SizedBox(width: 20));
    }
    // return list;
    return Row(children: list);
  }

  // 顶部筛选过滤，
  Widget _getFilter() {
    List<Widget> list = [];
    List<String> labels = ['深圳', '筛选'];

    for (var i = 0; i < labels.length; i++) {
      list.add(const SizedBox(width: 10));
      list.add(Stack(
        children: [
          InkWell(
            onTap: () {
              print('TextButton被点击');
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF6F5F5),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.fromLTRB(10, 4, 18, 4),
              child: Text(labels[i], style: const TextStyle(fontSize: 13)),
            ),
          ),
          Positioned(
              bottom: 2,
              right: 2,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: const Icon(
                  Icons.arrow_right,
                  size: 16,
                  color: Colors.grey,
                ),
              )),
        ],
      ));
    }
    return Row(children: list);
  }

  AppBar _getAppBar({required BuildContext context}) {
    return AppBar(
        toolbarHeight: 90,
        // 底部边框
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            decoration: const ShapeDecoration(
              shape: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 198, 198, 198), width: 0.1),
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Config.secondaryColor,
                Colors.white,
                Colors.white,
                // Color.fromARGB(255, 255, 167, 161)
              ],
            ),
          ),
        ),
        title: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('前端开发工程师',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.add, size: 30),
                      SizedBox(width: 20),
                      Icon(Icons.search, size: 30),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_getTopLabel(), _getFilter()],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context: context), body: const JobList());
  }
}

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final _http = HttpRequest();
  List<dynamic> _list = []; // 列表数据
  bool _isLoading = false; // 控制重复请求

  @override
  void initState() {
    super.initState();
    _fetchData();
    // 监听滚动
    _jobIndexScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_jobIndexScrollController.position.maxScrollExtent <=
            _jobIndexScrollController.offset &&
        !_isLoading) {
      _fetchData();
    }
  }

  Future<void> _fetchData({bool isFresh = false}) async {
    print('doing fetch data...');
    setState(() {
      _isLoading = true;
    });

    // 模拟延迟2s
    await Future.delayed(const Duration(seconds: 2));

    try {
      Map<String, dynamic> data = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/job/new-list');
      setState(() {
        _list = isFresh
            ? data['zpData']['jobList']
            : [..._list, ...data['zpData']['jobList']];
        _isLoading = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _onRefresh() async {
    await _fetchData(isFresh: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return RefreshIndicator(
        key: _jobIndexRefreshKey,
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _list.length,
          controller: _jobIndexScrollController,
          itemBuilder: (context, index) {
            Widget item = JobCard(params: _list[index]);
            return index == _list.length - 1
                ? Column(
                    children: [
                      item,
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : item;
          },
        ));
  }

  @override
  void dispose() {
    // 清除监听器以避免内存泄漏
    _jobIndexScrollController.removeListener(_onScroll);
    super.dispose();
  }
}
