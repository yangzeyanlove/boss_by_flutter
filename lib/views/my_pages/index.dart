import 'package:flutter/material.dart';
import '../../config.dart';
import '../demo_pages/index.dart';

class MyIndexPage extends StatefulWidget {
  const MyIndexPage({super.key});

  @override
  State<MyIndexPage> createState() => _MyIndexPageState();
}

class _MyIndexPageState extends State<MyIndexPage> {
  final ScrollController _scrollController = ScrollController();
  double offsetTop = 0.0;

  @override
  void initState() {
    super.initState();
    // 监听滚动
    _scrollController.addListener(_onScroll);
  }

  // 滚动事件
  _onScroll() {
    double offset = _scrollController.offset;
    setState(() {
      offsetTop = offset;
    });

    if (offset < kToolbarHeight) {
      setState(() {
        offsetTop = offset;
      });
    } else {
      setState(() {
        offsetTop = kToolbarHeight;
      });
    }
  }

  @override
  void dispose() {
    // 清除监听器以避免内存泄漏
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // 自定义顶部栏，appBar
  Widget _getAppBar(double appBarHeight, double appBarPadding) {
    return Container(
      height: appBarHeight,
      padding: EdgeInsets.only(top: appBarPadding),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Config.secondaryColor,
            // Colors.white,
            // Colors.white,
            // Color.fromARGB(255, 255, 167, 161)
            Color(0xffF4FBFA)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.people_outline),
            onPressed: () {
              // 处理搜索按钮点击事件
            },
          ),
          IconButton(
            icon: const Icon(Icons.fit_screen_outlined),
            onPressed: () {
              // 处理搜索按钮点击事件
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DemoPage(),
                ),
              );
            },
          )
        ],
      ),
      // child: Container(decoration: BoxDecoration(color: Colors.grey)),
    );
  }

  // 顶部个人信息
  Widget _getUserInfo() {
    return const ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Opacity(
          opacity: 0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://img.bosszhipin.com/boss/avatar/avatar_5.png'),
            radius: 32,
          )),
      title: Opacity(
        opacity: 0,
        child: Text('杨泽炎', style: TextStyle(fontSize: 24)),
      ),
      subtitle: Row(
        children: [
          Text(
            '简历评分99分，建议优化',
            style: TextStyle(fontSize: 13),
          ),
          Icon(
            Icons.update,
            size: 18,
          )
        ],
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }

  // 滑动定位元素，头像和名称
  Widget _getPositionOption(double appBarPadding) {
    return Positioned(
      // top: appBarPadding,
      // top: appBarPadding + kToolbarHeight + 10,
      top: offsetTop >= 0
          ? (appBarPadding + kToolbarHeight + 10) -
              (offsetTop / kToolbarHeight) * (kToolbarHeight + 10)
          : appBarPadding + kToolbarHeight + 10 - offsetTop,
      left: 0,
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                  'https://img.bosszhipin.com/boss/avatar/avatar_6.png'),
              // radius: 14,
              // radius: 32,
              radius:
                  offsetTop >= 0 ? 32 - (offsetTop / kToolbarHeight) * 18 : 32,
            ),
            const SizedBox(width: 10),
            Container(
                padding: EdgeInsets.only(
                    bottom: offsetTop >= 0
                        ? 20 - (offsetTop / kToolbarHeight) * 20
                        : 20),
                child: Text('杨泽炎',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: offsetTop >= 0
                            ? 22 - (offsetTop / kToolbarHeight) * 4
                            : 22)) // 24->20,
                )
          ],
        ),
      ),
    );
  }

  // 统计数据
  Widget _getStatistics() {
    List<Map<String, dynamic>> data = [
      {'name': '待沟通', 'count': 420},
      {'name': '已投简历', 'count': 20},
      {'name': '待面试', 'count': 10},
      {'name': '收藏', 'count': 40}
    ];
    List<Widget> list = [];

    for (var item in data) {
      list.add(
        Expanded(
          child: Column(
            children: [
              Text(
                "${item['count']}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                item['name'],
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: list,
    );
  }

  // 推广，广告
  Widget _getAd() {
    Widget getAdItem(title, desc, icon) {
      return Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const SizedBox(width: 5),
          Icon(icon, color: const Color(0xffD59064), size: 16),
          Text(title,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(width: 10),
          Text(desc, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const Icon(
            Icons.navigate_next,
            size: 15,
            color: Colors.grey,
          ),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), //设置圆角半径为10
      ),
      child: Column(
        children: [
          const Image(image: AssetImage('assets/images/ad.png')),
          const SizedBox(height: 10),
          Row(
            children: [
              getAdItem('简历刷新', '提升曝光', Icons.loop),
              Container(
                width: 1,
                height: 10,
                color: Colors.grey,
              ),
              getAdItem('简历定制', '高薪求职', Icons.edit_calendar),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // 常用功能
  Widget _getCommonFunction() {
    List<Map<String, dynamic>> data = [
      {'icon': Icons.description, 'name': '在线简历', 'desc': '待优化3项'},
      {'icon': Icons.local_post_office, 'name': '附件简历', 'desc': '制作/上传'},
      {'icon': Icons.favorite, 'name': '求职意向', 'desc': '离职-随时到岗'},
      {'icon': Icons.local_mall, 'name': '道具商城', 'desc': '直豆/其他'},
    ];

    List<Widget> list = [];

    for (var item in data) {
      list.add(Expanded(
        // flex: 1,
        child: Column(
          children: [
            Stack(
              children: [
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(Icons.circle, size: 24, color: Color(0xffFFA572)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                  child: Icon(item['icon'],
                      size: 36, color: const Color(0xff1FB7BA)),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              item['name'],
              style: const TextStyle(fontSize: 12),
            ),
            Text(item['desc'],
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), //设置圆角半径为10
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '常用功能',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: list,
          )
        ],
      ),
    );
  }

  // 专属建议
  Widget _getSuggestion() {
    return const Image(image: AssetImage('assets/images/suggestion.png'));
  }

  // 其他功能
  Widget _getOthers() {
    List<Map<String, dynamic>> dataList = [
      {'icon': Icons.account_circle_outlined, 'name': '直聘分'},
      {'icon': Icons.live_tv_outlined, 'name': '直播招聘'},
      {'icon': Icons.edit_calendar_outlined, 'name': '面试刷题'},
      {'icon': Icons.find_in_page_outlined, 'name': '薪资查询'},
      {'icon': Icons.task_outlined, 'name': '16型测试'},
      {'icon': Icons.paid_outlined, 'name': '高薪机会'},
      {'icon': Icons.admin_panel_settings_outlined, 'name': '规则中心'},
      {'icon': Icons.gavel, 'name': '仲裁厅'},
      {'icon': Icons.support_agent_outlined, 'name': '我的客服'},
      {'icon': Icons.security_outlined, 'name': '防骗指南'},
      {'icon': Icons.feed_outlined, 'name': '隐私规则'},
      {'icon': Icons.business_outlined, 'name': '精选公司'},
    ];

    return Container(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0), //设置圆角半径为10
        ),
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('其他功能',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text(
                            '查看全部',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Icon(Icons.navigate_next, color: Colors.grey)
                        ],
                      ),
                    ])),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisExtent: 75),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Icon(
                        dataList[index]['icon'],
                        size: 25,
                        color: const Color(0xff5A5A5A),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        dataList[index]['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff5A5A5A),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final appBarPadding = MediaQuery.of(context).padding.top; // 刘海的高度
    final appBarHeight =
        kToolbarHeight + appBarPadding; // kToolbarHeight是appbar内容部分的高度

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.fromLTRB(10, appBarHeight, 10, 10),
          controller: _scrollController,
          children: [
            _getUserInfo(),
            const SizedBox(height: 20),
            _getStatistics(),
            const SizedBox(height: 20),
            // 推广广告
            _getAd(),
            const SizedBox(height: 10),
            // 常用功能
            _getCommonFunction(),
            const SizedBox(height: 10),
            // 专属建议
            _getSuggestion(),
            const SizedBox(height: 10),
            // 其他功能
            _getOthers(),
            const SizedBox(height: 10),
            // 底部信息
            const DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('客服电话 400-065-5799 工作时间 8:00-22:00'),
                  Text('老年人直连热线 400-661-6030 工作时间 8:00-22:00'),
                  Text('算法举报与未成年人举报渠道同上'),
                  Text('人力资源服务许可证 营业执照 朝阳区人社局监督电话'),
                  Text('京ICP备19000001号-1 京ICP证17001号'),
                  Text('算法备案信息'),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        _getAppBar(appBarHeight, appBarPadding),
        _getPositionOption(appBarPadding)
      ],
    );
  }
}
