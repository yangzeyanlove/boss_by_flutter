import 'package:flutter/material.dart';
import 'bottom_bar/index_page.dart';
import 'bottom_bar/have_page.dart';
import 'bottom_bar/message_page.dart';
import 'bottom_bar/my_page.dart';
import '../config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const IndexPage(),
    const HavePage(),
    const MessagePage(),
    const MyPage(),
  ];

  // 底部导航按钮配置
  List<BottomNavigationBarItem> _getBarItem() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.work), label: '职位'),
      BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '有了'),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '我的'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pages[_currentIndex],
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _getBarItem(),
        selectedItemColor: Config.primaryColor, // 选中时字体颜色
        unselectedItemColor: Colors.grey, // 未选中时字体颜色
        backgroundColor: Colors.white, // 默认背景颜色
        type: BottomNavigationBarType.fixed, // 底部有4个或以上的菜单，就需要配置
        // fixedColor: Colors.red,  // 选中的颜色
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
