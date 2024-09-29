import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../../controller/interaction_controller.dart';
import '../../widgets/job_card.dart';
import '../../config.dart';

// 互动页面
class Interaction extends StatelessWidget {
  // 申明getx控制器，数据控制器
  final InteractionController dataCtrl = Get.put(InteractionController());

  Interaction({super.key});

  // appBar的底部tab切换
  TabBar _getTabBar() {
    List<Widget> tabsList = [];

    for (var i = 0; i < dataCtrl.tabs.length; i++) {
      tabsList.add(Tab(
        height: 30,
        iconMargin: const EdgeInsets.all(0),
        text: dataCtrl.tabs[i],
      ));
    }

    return TabBar(
      tabs: tabsList,
      isScrollable: true, // 是否滚动
      dividerHeight: 0,
      tabAlignment: TabAlignment.start, // 从左侧开始对齐
      labelPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: const EdgeInsets.all(0), // tab容器，左右填充
      physics: const BouncingScrollPhysics(), // 横向滑动回弹效果
      indicator: const BoxDecoration(),
      labelColor: const Color(0xff171516),
      unselectedLabelColor: Colors.grey,
    );
  }

  List<Widget> _getTabBarViewList() {
    List<Widget> list = [];
    List<Widget> cardList = [];
    List<Widget> others = [];

    for (var i = 0; i < dataCtrl.listData.length; i++) {
      cardList.add(JobCard(params: dataCtrl.listData[i]));
    }

    for (var i = 0; i < dataCtrl.tabs.length; i++) {
      // 如果是第一个，对我感兴趣
      if (i == 0) {
        others.add(Column(
          children: [
            const SizedBox(height: 20),
            const Image(
              width: 150,
              height: 150,
              image: AssetImage('assets/images/icon-empty.png'),
            ),
            const Text('还没有boss对你感兴趣哦', style: TextStyle(color: Colors.grey)),
            const Text('快去主动联系吧！', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 按钮点击时执行的操作
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                backgroundColor: const Color(0xff17B3B3), // 设置背景颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ), // 设置圆角
              ),
              child: const Text(
                '找职位',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ));
        others.add(const Center(
          child: Text(
            '--- 热门职位推荐 ---',
            style: TextStyle(
              color: Config.primaryColor,
              fontWeight: FontWeight.bold,
              // fontSize: 14,
              height: 2.4,
            ),
          ),
        ));
      } else {
        others.clear();
      }

      list.add(ListView(padding: const EdgeInsets.all(10), children: [
        ...others,
        ...cardList,
      ]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: dataCtrl.tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _getTabBar(),
        body: Container(
          color: const Color(0xffF5F5F5),
          child: TabBarView(
            // controller: _tabController,
            children: _getTabBarViewList(),
          ),
        ),
      ),
    );
  }
}
