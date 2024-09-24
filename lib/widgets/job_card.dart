import 'package:flutter/material.dart';
import '../config.dart';
import '../views/job_detail.dart';
import 'label.dart';

/// 职位信息展示，卡片样式
class JobCard extends StatelessWidget {
  final Map<String, dynamic> params;

  const JobCard({super.key, required this.params});

  Row _getFirstRowData() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 顶部对其
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
      children: [
        Flexible(
          child: Text(
            params["jobName"],
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, height: 1.2),
          ),
        ),
        Text(
          params["salaryDesc"],
          style: const TextStyle(
              fontSize: 16,
              color: Config.primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // 显示标签
  Row _getLabel() {
    List<Widget> labelList = [];

    for (int i = 0; i < params["jobLabels"].length; i++) {
      labelList.add(LabelWidget(str: params["jobLabels"][i]));
      labelList.add(const SizedBox(width: 8.0));
    }

    return Row(children: labelList);
  }

  // 底部的hr，地址信息
  Row _getBottomInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(params["bossAvatar"]),
              radius: 12,
            ),
            const SizedBox(width: 13),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // 这会使得子元素左对齐
              children: [
                // '$params['bossName'].$params['bossTitle']'
                Text('${params["bossName"]}.${params["bossTitle"]}',
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.left),
                const Text(
                  '今天回复10+',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 11, color: Config.lightColor),
                )
              ],
            ),
          ],
        ),
        Text('${params["areaDistrict"]} ${params["businessDistrict"]}',
            style: const TextStyle(fontSize: 12, color: Config.lightColor))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetail(info: params),
            ),
          );
        },
        child: Card(
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
                  _getFirstRowData(),
                  const SizedBox(height: 10),
                  Text(
                      '${params["brandName"]}  ${params["brandStageName"]}  ${params["brandScaleName"]}',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
                  _getLabel(),
                  const SizedBox(height: 10),
                  _getBottomInfo()
                ],
              )),
        ));
  }
}
