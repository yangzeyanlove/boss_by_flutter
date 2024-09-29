import "package:flutter/material.dart";
import '../../config.dart';
import 'chat.dart';
import 'interaction.dart';

class MessageIndexPage extends StatefulWidget {
  const MessageIndexPage({super.key});

  @override
  State<MessageIndexPage> createState() => _MessageIndexPageState();
}

class _MessageIndexPageState extends State<MessageIndexPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
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
        title: TabBar(
          controller: _tabController,
          // isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicator: const BoxDecoration(), // 创建一个空的指示器
          dividerHeight: 0,
          labelPadding: const EdgeInsets.fromLTRB(3, 0, 18, 0),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          tabs: const [
            Tab(text: '聊天'),
            Tab(text: '互动'),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_outlined),
          SizedBox(width: 18),
          Icon(Icons.settings_outlined),
          SizedBox(width: 15)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Chat(),
          const Interaction(),
        ],
      ),
    );
  }
}
