import 'package:flutter/material.dart';

/// 职位信息展示，卡片样式
class JobCard extends StatelessWidget {
  final String title; // 职位名称
  final String salary; // 薪资
  final String brandName; // 企业名称
  final String brandStageName; // 目前状态，已上市，A/B/C/D轮，未融资。。。。
  final String brandScaleName; // 人数规模
  final List<dynamic> jobLabels; // 岗位标签
  final String bossAvatar; // boss头像
  final String bossName; // boss名称
  final String bossTitle;
  final String areaDistrict;
  final String businessDistrict;

  const JobCard(
      {super.key,
      this.title = '软件开发工程师软件开发工程师软件开发',
      this.salary = '15K-20K',
      this.brandName = '华为',
      this.brandStageName = '已上市',
      this.brandScaleName = '1000-5000人',
      this.jobLabels = const ["3-5年", "大专"],
      this.bossAvatar = '',
      this.bossName = '张三',
      this.bossTitle = '高级工程师',
      this.areaDistrict = '南山',
      this.businessDistrict = '科技园'});

  Row _getFirstRowData() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 顶部对其
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          salary,
          style: const TextStyle(
              fontSize: 18,
              color: Color(0xff37c2bc),
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // 显示标签
  Row _getLabel() {
    List<Widget> labelList = [];

    for (int i = 0; i < jobLabels.length; i++) {
      labelList.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: const Color(0xfff8f8f8), // 灰色背景
            borderRadius: BorderRadius.circular(2.0), // 圆角
          ),
          child: Text(jobLabels[i],
              style: const TextStyle(color: Color(0xff666666)))));
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
              backgroundImage: NetworkImage(bossAvatar),
              radius: 14,
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // 这会使得子元素左对齐
              children: [
                Text('$bossName.$bossTitle',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left),
                const Text(
                  '今天回复10+',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xff666666)),
                )
              ],
            ),
          ],
        ),
        Text('$areaDistrict $businessDistrict',
            style: const TextStyle(color: Color(0xff666666)))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              _getFirstRowData(),
              const SizedBox(height: 10),
              Text('$brandName  $brandStageName  $brandScaleName'),
              const SizedBox(height: 10),
              _getLabel(),
              const SizedBox(height: 10),
              _getBottomInfo()
            ],
          )),
    );
  }
}
