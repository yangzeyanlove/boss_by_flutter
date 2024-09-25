import 'package:flutter/material.dart';
import '../../common/http_request.dart';
import '../../widgets/collapse_text.dart';
import '../../widgets/video_player.dart';

class TopList extends StatefulWidget {
  const TopList({super.key});

  @override
  State<TopList> createState() => _SubContentState();
}

class _SubContentState extends State<TopList>
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
    await Future.delayed(const Duration(seconds: 2));

    try {
      Map<String, dynamic> data = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/have/toplist');
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
        var postUserInfo = itemData['postUserInfo'];
        var picList = itemData['picList'];
        var coverImg = itemData['coverImg'];
        var fileInfo = itemData['file'];
        var videoUrl =
            'https://zhipin-moment-1251955568.zhipin.com/zhipin-moment/99/20240521/fp_zhipin-mo_25016047ac0845dfa59e767d4c99fee8-OSS8.55447832ec66OSS8.mp4?sign=ff7b8758f3da9713974cff0c12c760cf&t=1727194713';

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
                  // 第一行，用户信息，头像，名称，右边更多按钮
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // 顶部对其
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(postUserInfo["avatar"]),
                              radius: 18,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(postUserInfo["bcName"]),
                                Text(
                                  postUserInfo["bcTitle"],
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz)
                    ],
                  ),
                  // 中间文字内容部分
                  const SizedBox(height: 10),
                  CollapseText(
                    text: itemData['content'],
                    maxLines: 3,
                    textStyle: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                  // 媒体，图片/视频
                  picList.length > 0
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10.0), // 设置圆角半径
                                child: Image(
                                  image:
                                      NetworkImage(picList[0]['thumbnailUrl']),
                                  width: 120,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ))
                          ],
                        )
                      : const SizedBox.shrink(),
                  // 视频
                  coverImg != null && fileInfo != null
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomVideoPlayer(
                              // videoUrl: fileInfo['url'],
                              videoUrl: videoUrl,
                              width: 120,
                              height: 200,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  // 底部数据统计，留言数，收藏数，点赞数
                  const SizedBox(height: 20),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.mode_comment_outlined,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${itemData['commentCount']}')
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star_outline,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${itemData['collectCount']}')
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.favorite_border,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${itemData['likeCount']}')
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
