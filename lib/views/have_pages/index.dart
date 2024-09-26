import 'package:flutter/material.dart';
import '../../config.dart';
import 'top_list.dart';
import 'good_article.dart';
import 'wait_you_answer.dart';

class HaveIndexPage extends StatelessWidget {
  const HaveIndexPage({super.key});

  // 顶部导航
  AppBar _getAppBar() {
    return AppBar(
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
      elevation: 0, // 去除阴影
      title: Row(
        children: [
          const Text('有了',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, size: 18, color: Colors.grey),
                  prefixIconConstraints: const BoxConstraints(minWidth: 32),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xff55BAB8), width: 1.2), // 边框颜色 (未聚焦)
                    borderRadius: BorderRadius.circular(80),
                  ),
                  hintText: '搜索',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 30,
            ),
            onPressed: () {}),
        const SizedBox(width: 8),
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.bosszhipin.com/boss/avatar/avatar_5.png'),
          radius: 12,
        ),
        const SizedBox(width: 18)
      ],
      // bottom: _getBottomTab(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: const TabViewContent(),
    );
  }
}

class TabViewContent extends StatefulWidget {
  const TabViewContent({super.key});

  @override
  State<TabViewContent> createState() => _TabViewContentState();
}

class _TabViewContentState extends State<TabViewContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List data = [
    {'label': '精选', 'getWidget': () => const TopList()},
    {'label': '好文', 'getWidget': () => const GoodArticle()},
    {'label': '等你来答', 'getWidget': () => const WaitYouAnswer()},
    {'label': '求职', 'getWidget': () => const TopList()},
    {'label': '直播', 'getWidget': () => const TopList()},
    {'label': '关注', 'getWidget': () => const TopList()},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: data.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // appBar的底部tab切换
  TabBar _getTabBar() {
    List<Widget> tabsList = [];

    for (var i = 0; i < data.length; i++) {
      tabsList.add(Tab(
        height: 30,
        iconMargin: const EdgeInsets.all(0),
        text: data[i]['label'],
      ));
    }

    return TabBar(
      tabs: tabsList,
      controller: _tabController,
      isScrollable: true, // 是否滚动
      tabAlignment: TabAlignment.start, // 从左侧开始对齐
      labelStyle:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 0), // tab容器，左右填充
      physics: const BouncingScrollPhysics(), // 横向滑动回弹效果
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff4EC8C8), width: 3.0),
      ),
      indicatorPadding: const EdgeInsets.symmetric(
          vertical: 7, horizontal: 0), // 选中下横向，与tabview之间的距离
      labelColor: const Color(0xff171516),
      unselectedLabelColor: const Color(0xff666666),
    );
  }

  List<Widget> _getTabBarViewList() {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(data[i]['getWidget']());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getTabBar(),
      body: Container(
        color: const Color(0xffF5F5F5),
        child: TabBarView(
          controller: _tabController,
          children: _getTabBarViewList(),
        ),
      ),
    );
  }
}
