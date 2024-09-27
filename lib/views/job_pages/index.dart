import 'package:flutter/material.dart';
import '../../config.dart';
import 'job_card.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import '../../controller/job_list_controller.dart';

class JobIndexPage extends StatelessWidget {
  const JobIndexPage({super.key});

  AppBar _getAppBar({required BuildContext context}) {
    return AppBar(
      toolbarHeight: 45,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Config.secondaryColor,
              Color(0xffBBECEE),
              Colors.white,
              Colors.white,
              // Color.fromARGB(255, 255, 167, 161)
            ],
          ),
        ),
      ),
      title: const Text('前端开发工程师',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      actions: const [
        Icon(Icons.add, size: 30),
        SizedBox(width: 10),
        Icon(Icons.search, size: 30),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context: context),
      body: JobPageContent(),
    );
  }
}

class JobPageContent extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _jobIndexRefreshKey =
      GlobalKey<RefreshIndicatorState>(); // 控制下拉刷新
  // 申明getx控制器，职位列表数据控制器
  final JobListController jobListCtrl = Get.put(JobListController());

  JobPageContent({super.key});

  // 顶部标签按钮，全部/附近/最新
  Widget _getTopLabel() {
    List<Widget> list = [];
    for (var i = 0; i < jobListCtrl.tabLabels.length; i++) {
      list.add(
        InkWell(
          onTap: () {
            // 滚动会顶部
            jobListCtrl.scrollTop();
            // 点击文本时要执行的操作
            _jobIndexRefreshKey.currentState?.show();
          },
          child: Text(jobListCtrl.tabLabels[i],
              style: const TextStyle(fontSize: 13)),
        ),
      );
      list.add(const SizedBox(width: 20));
    }
    return Row(children: list);
  }

  // 顶部筛选过滤，
  Widget _getFilter() {
    List<Widget> list = [];

    for (var i = 0; i < jobListCtrl.filterType.length; i++) {
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
              child: Text(jobListCtrl.filterType[i],
                  style: const TextStyle(fontSize: 13)),
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

  Future<void> _onRefresh() async {
    await jobListCtrl.fetchData(isFresh: true);
  }

  // 滚动内容区域，主要内容区域
  Widget getMainContent() {
    return jobListCtrl.listData.isEmpty
        ? const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: jobListCtrl.listData.length,
            controller: jobListCtrl.scrollController,
            itemBuilder: (context, index) {
              Widget item = JobCard(params: jobListCtrl.listData[index]);
              return index == jobListCtrl.listData.length - 1
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_getTopLabel(), _getFilter()],
        ),
      ),
      body: RefreshIndicator(
        key: _jobIndexRefreshKey,
        onRefresh: _onRefresh,
        child: Obx(() => getMainContent()),
      ),
    );
  }
}
