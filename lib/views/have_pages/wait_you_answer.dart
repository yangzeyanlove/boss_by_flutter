import 'package:flutter/material.dart';
import '../../common/http_request.dart';
import '../../widgets/collapse_text.dart';
import '../../widgets/video_player.dart';

class WaitYouAnswer extends StatefulWidget {
  const WaitYouAnswer({super.key});

  @override
  State<WaitYouAnswer> createState() => _SubContentState();
}

class _SubContentState extends State<WaitYouAnswer>
    with AutomaticKeepAliveClientMixin {
  final _http = HttpRequest();
  bool _isLoading = false; // 控制重复请求
  List<dynamic> _list = []; // 列表数据

  @override
  bool get wantKeepAlive => true; // 保活设置

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // 获取列表数据
  Future<void> _fetchData({bool isFresh = false}) async {
    setState(() {
      _isLoading = true;
    });

    // 模拟延迟2s
    // await Future.delayed(const Duration(milliseconds: 500));

    try {
      Map<String, dynamic> data = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/question-answer-list');
      setState(() {
        _list = isFresh
            ? data['zpData']['list']
            : [..._list, ...data['zpData']['list']];
        _isLoading = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 需要调用super.build(context)

    if (_list.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _list.length,
      itemBuilder: (context, index) {
        // 单项数据，发布人信息
        var itemData = _list[index];

        return Card(
          color: Colors.white, // 背景颜色
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0), // 外间距
          elevation: 0.001, // 阴影深度
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 圆角大小
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemData['question'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 0.1,
                    color: Color.fromARGB(255, 240, 240, 240),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(itemData["answerList"][0]),
                            radius: 10,
                          ),
                          const SizedBox(width: 4),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(itemData["answerList"][1]),
                            radius: 10,
                          ),
                          const SizedBox(width: 4),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(itemData["answerList"][2]),
                            radius: 10,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '等${itemData['answerCount']}人参与讨论',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 141, 140, 140)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            itemData['viewCount'] + '浏览',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 141, 140, 140)),
                          ),
                          const SizedBox(width: 7),
                          const Icon(Icons.more_horiz,
                              size: 15,
                              color: Color.fromARGB(255, 141, 140, 140))
                        ],
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
