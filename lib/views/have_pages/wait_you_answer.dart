import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/wait_you_answer_controller.dart';

class WaitYouAnswer extends StatelessWidget {
  final WaitYouAnswerController dataCtrl = Get.put(WaitYouAnswerController());

  WaitYouAnswer({super.key});

  // 每项数据，每个card
  Widget getItemInfo(itemData) {
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
                      backgroundImage: NetworkImage(itemData["answerList"][0]),
                      radius: 10,
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      backgroundImage: NetworkImage(itemData["answerList"][1]),
                      radius: 10,
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      backgroundImage: NetworkImage(itemData["answerList"][2]),
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
                        size: 15, color: Color.fromARGB(255, 141, 140, 140))
                  ],
                ),
              ],
            )
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
