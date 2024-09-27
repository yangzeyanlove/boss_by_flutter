import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/collapse_text.dart';
import '../../controller/good_article_controller.dart';

class GoodArticle extends StatelessWidget {
  // 申明getx控制器，职位列表数据控制器
  final GoodArticleController dataCtrl = Get.put(GoodArticleController());

  GoodArticle({super.key});

  // 每条记录
  Widget getItemInfo(itemData) {
    var postUserInfo = itemData['postUserInfo'];
    var coverImg = itemData['coverImg'];

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
                        backgroundImage: NetworkImage(postUserInfo["avatar"]),
                        radius: 18,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postUserInfo["nickname"]),
                          postUserInfo["certName"] != ''
                              ? Text(
                                  postUserInfo["certName"],
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              : const SizedBox.shrink()
                        ],
                      )
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz)
              ],
            ),
            // 标题
            const SizedBox(height: 10),
            Text(
              itemData['title'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            // 中间文字内容部分
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // 顶部对其
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
              children: [
                Flexible(
                  child: CollapseText(
                    text: itemData['content'],
                    maxLines: 3,
                    textStyle: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // 设置圆角半径
                    child: Image(
                      image: NetworkImage(coverImg['thumbnailUrl']),
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
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
        ),
      ),
    );
  }

  Widget getMainContent() {
    return dataCtrl.listData.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            key: dataCtrl.pageKey,
            padding: const EdgeInsets.all(10),
            itemCount: dataCtrl.listData.length,
            itemBuilder: (context, index) {
              // 单项数据，发布人信息
              return getItemInfo(dataCtrl.listData[index]);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getMainContent());
  }
}
