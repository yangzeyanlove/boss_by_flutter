import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../config.dart';
import '../../widgets/label.dart';
import '../../controller/job_detail_controller.dart';
import '../map_page.dart';

class JobDetail extends StatelessWidget {
  // 申明getx控制器，职位列表数据控制器
  final JobDetailController jobDetailCtrl = Get.put(JobDetailController());
  final Map<String, dynamic> info;

  JobDetail({super.key, required this.info});

  // 顶部栏
  PreferredSizeWidget _getAppBar() {
    return AppBar(
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: Obx(
        () => Opacity(
          opacity: jobDetailCtrl.appBarOpacity.value,
          child: Text(info['jobName'], style: const TextStyle(fontSize: 16)),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.star_border), onPressed: () {}),
        IconButton(icon: const Icon(Icons.ios_share), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})
      ],
    );
  }

  // 职位地址
  Widget _getAddress() {
    List<String> list = [];
    if (info["cityName"] != null && info["cityName"]!.isNotEmpty) {
      list.add(info["cityName"]);
    }
    if (info["areaDistrict"] != null && info["areaDistrict"]!.isNotEmpty) {
      list.add(info["areaDistrict"]);
    }
    if (info["businessDistrict"] != null &&
        info["businessDistrict"]!.isNotEmpty) {
      list.add(info["businessDistrict"]);
    }
    return Text(list.join("·"), style: const TextStyle(fontSize: 14));
  }

  // 职位基本信息
  Widget _getJobInfo() {
    return Column(children: [
      // 职位名称
      Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 顶部对其
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 主轴两端对齐
        children: [
          Flexible(
            child: Text(
              info["jobName"],
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, height: 1.3),
            ),
          ),
          Text(
            info["salaryDesc"],
            style: const TextStyle(
                fontSize: 18,
                color: Config.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const Icon(Icons.location_on, color: Colors.grey, size: 18.0),
          const SizedBox(width: 4.0),
          _getAddress(),
          const SizedBox(width: 15.0),
          const Icon(
            Icons.work,
            color: Colors.grey,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(info["jobExperience"], style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 15.0),
          const Icon(
            Icons.school,
            color: Colors.grey,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(info["jobDegree"], style: const TextStyle(fontSize: 14)),
        ],
      ),
      const SizedBox(height: 20),
      const Divider(
        height: 0.1,
        color: Color.fromARGB(255, 240, 240, 240),
      ),
    ]);
  }

  // boss信息
  Widget _getBossInfo() {
    return Column(
      children: [
        const SizedBox(height: 20),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(info["bossAvatar"]),
            radius: 28,
          ),
          title: Text(info["bossName"],
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4.0),
              Text(
                info["brandName"] + "·" + info["bossTitle"],
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4.0),
              const Text('今日活跃',
                  style: TextStyle(fontSize: 12, color: Colors.grey))
            ],
          ),
          trailing: const Icon(Icons.navigate_next),
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 0.1,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ],
    );
  }

  // 工作地址
  Widget _getWorkAddress() {
    return const Column(
      children: [
        SizedBox(height: 20),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("工作地址",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0),
              Text("深圳福田区京基滨河时代广场A座40楼4005", style: TextStyle(fontSize: 14)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  LabelWidget(str: '距您8.7千米'),
                  SizedBox(width: 10),
                  LabelWidget(str: '地铁约44分钟')
                ],
              )
            ],
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        SizedBox(height: 20),
        Divider(
          height: 0.1,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ],
    );
  }

  // 员工福利，welfareList
  Widget _getWelfare() {
    List<Widget> list = [];

    for (var item in info["welfareList"]) {
      list.add(LabelWidget(str: item));
      list.add(const SizedBox(width: 10));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('员工福利 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Icon(
              Icons.help_outline,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 10,
          children: list,
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 0.1,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ],
    );
  }

  // 职位详情描述
  Widget _getJobDetail() {
    List<Widget> skills = [];
    const content = '''职位类型：全职、兼职
岗位职责：
1. 负责公司网站和应用的前端开发，确保界面的兼容性和性能。
2. 根据产品需求和设计稿，开发高质量、响应式的用户界面。
3. 优化前端性能，提升用户体验，解决浏览器兼容性问题。
4. 与后端开发人员密切配合，完成接口对接和数据交互。
5. 维护和更新现有系统，修复bug，提升系统稳定性。
6. 参与前端技术选型，提出技术改进建议，推动技术创新。
7. 编写前端开发文档，确保项目的可维护性和可扩展性。
岗位要求：
1. 计算机科学或相关专业本科及以上学历。
2. 3年以上前端开发经验，熟悉HTML、CSS、JavaScript等前端技术。
3. 精通至少一种前端框架，如React、Vue.js或Angular。
4. 熟悉前端构建工具和版本控制工具，如Webpack、Git等。
5. 具备良好的前端性能优化能力，了解常见的性能瓶颈及解决方案。
6. 具有良好的跨浏览器兼容性处理经验，能够解决各种浏览器中的兼容性问题。
7. 具备良好的沟通能力和团队合作精神，能够与设计师和后端工程师协作完成项目。
8. 对前端技术有浓厚兴趣，愿意持续学习和探索新的技术。
福利待遇：
- 具有竞争力的薪资和奖金制度。
- 五险一金，带薪年假，节日福利。
- 提供丰富的培训和职业发展机会。
- 良好的工作环境和团队氛围。''';

    for (var item in info["skills"]) {
      skills.add(LabelWidget(str: item));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('职位详情',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills,
        ),
        const SizedBox(height: 20),
        const Text(
          content,
          style: TextStyle(fontSize: 15, color: Color(0xff5e5e5e), height: 1.7),
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 0.1,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ],
    );
  }

  // 公司信息
  Widget _getCompanyInfo(BuildContext context) {
    List<String> list = [];

    if (info["brandStageName"] != null && info["brandStageName"]!.isNotEmpty) {
      list.add(info["brandStageName"]);
    }
    if (info["brandScaleName"] != null && info["brandScaleName"]!.isNotEmpty) {
      list.add(info["brandScaleName"]);
    }
    if (info["brandIndustry"] != null && info["brandIndustry"]!.isNotEmpty) {
      list.add(info["brandIndustry"]);
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Image(
              image: NetworkImage(info["brandLogo"]), width: 48, height: 48),
          title: Text(info["brandName"], style: const TextStyle(fontSize: 16)),
          subtitle: Text(list.join('·'), style: const TextStyle(fontSize: 13)),
          trailing: const Icon(Icons.navigate_next),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MapPage(),
              ),
            )
          },
          child: const Image(
            image: AssetImage('assets/images/map.png'),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 0.1,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
      ],
    );
  }

  // boss安全提示
  Widget _getSafeTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.privacy_tip,
              color: Colors.blue,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text('BOSS安全提示',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '''BOSS直聘严禁用人单位和招聘者用户做出任何损害求职者合法权益的违法违规行为，包括但不限于扣押求职者证件、收取求职者财物、向求职者集资、让求职者入股、诱导求职者异地入职、异地参加培训、违法违规使用求职者简历等，您一旦发现此类行为， 请立即举报''',
          style: TextStyle(fontSize: 13, height: 1.6, color: Color(0xff5e5e5e)),
        ),
        const SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            '了解更多职场安全防范知识 >',
            style: TextStyle(fontSize: 13, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: _getAppBar(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.1))),
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        // height: 60,
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xff17B3B3)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          child: const Text(
            '立即沟通',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: ListView(
        controller: jobDetailCtrl.scrollController,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
        children: [
          // 职位基本信息
          _getJobInfo(),
          // boss信息
          _getBossInfo(),
          // 工作地址
          _getWorkAddress(),
          // 员工福利
          _getWelfare(),
          // 职位详情
          _getJobDetail(),
          // 公司信息
          _getCompanyInfo(context),
          // boos安全提示
          _getSafeTips()
        ],
      ),
    );
  }
}
