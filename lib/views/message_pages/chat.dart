import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../../controller/chat_controller.dart';

class Chat extends StatelessWidget {
  // 申明getx控制器，数据控制器
  final MessageController dataCtrl = Get.put(MessageController());

  Chat({super.key});

  // 搜索框
  Widget getSearch() {
    return SizedBox(
      height: 32,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          prefixIconConstraints: const BoxConstraints(minWidth: 32),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // 设置圆角半径为 10
            borderSide: BorderSide.none,
          ),
          filled: true, // 填充背景
          fillColor: const Color(0xFFf5f5f5),
          hintText: '搜索联系人、公司、聊天记录',
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 1.3),
        ),
      ),
    );
  }

  // tabbar内容
  Widget getTabar(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TabBar(
            splashFactory: NoSplash.splashFactory, // 去掉点击时的背景反馈动画
            isScrollable: true,
            dividerHeight: 0,
            tabAlignment: TabAlignment.center,
            labelPadding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
            indicatorPadding: const EdgeInsets.symmetric(
                vertical: 4, horizontal: 0), // 选中下横向，与tabview之间的距离
            tabs: dataCtrl.tabs.map((String name) => Tab(text: name)).toList(),
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                    color: const Color(0xff5f5f5f),
                    fontWeight: FontWeight.w300),
            labelStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB9B9B9)), // 设置边框颜色
                borderRadius: BorderRadius.circular(5)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.filter_alt_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                Text(
                  '筛选',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getItemInfo(data, tabIndex) {
    late Widget iconWidget;

    if (data['avatar'] == '') {
      iconWidget = Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: data['isLatest']
                ? [
                    Colors.orange, // Left bottom color
                    const Color.fromARGB(
                        255, 249, 167, 44), // Left bottom color
                    const Color.fromARGB(
                        255, 247, 187, 98), // Left bottom color
                    // Colors.white, // Right top color
                  ]
                : [
                    const Color.fromARGB(255, 2, 219, 158), // Left bottom color
                    const Color.fromARGB(
                        255, 51, 198, 156), // Left bottom color
                    const Color.fromARGB(
                        255, 158, 228, 208), // Left bottom color
                    // Colors.white, // Right top color
                  ],
          ),
        ),
        child: data['isLatest']
            ? const Icon(
                Icons.add,
                color: Colors.white,
                size: 34,
              )
            : const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 34,
              ),
      );
    } else {
      iconWidget = CircleAvatar(
        backgroundImage: NetworkImage(data["avatar"]),
        radius: 25,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            data['name'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Text(
                                  data['brandName'] + '·' + data['title'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false, // 防止文本换行
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey))),
                        ],
                      ),
                    ),
                    Text(
                      data['date'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    data['type'] != ''
                        ? Text(
                            '[${data['type']}]',
                            style: const TextStyle(color: Colors.grey),
                          )
                        : const SizedBox.shrink(),
                    Expanded(
                      // width: double.infinity,
                      child: Text(
                        data['content'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false, // 防止文本换行
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTabarView() {
    List<Widget> list = [];
    for (var i = 0; i < dataCtrl.tabs.length; i++) {
      list.add(
        SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(dataCtrl.tabs[i]),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: Obx(
                      () => SliverFixedExtentList(
                        itemExtent: 80.0,
                        delegate: SliverChildBuilderDelegate(
                          childCount: i > 0
                              ? dataCtrl.listData.length
                              : dataCtrl.allData.length,
                          (BuildContext context, int index) {
                            return getItemInfo(
                                i > 0
                                    ? dataCtrl.listData[index]
                                    : dataCtrl.allData[index],
                                i);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    return TabBarView(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: dataCtrl.tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                    toolbarHeight: 48,
                    scrolledUnderElevation: 0,
                    backgroundColor: Colors.white,
                    title: getSearch(),
                    pinned: true,
                    floating: true,
                    snap: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                      // 设置PreferredSize的高度
                      preferredSize: const Size.fromHeight(34.0),
                      child: getTabar(context),
                    )),
              ),
            ];
          },
          body: getTabarView(),
        ),
      ),
    );
  }
}
