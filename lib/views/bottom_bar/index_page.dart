import 'package:flutter/material.dart';
import '../../common/http_request.dart';
import './job_card.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const JobList());
  }
}

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final _http = HttpRequest();
  List<dynamic> _list = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    // 监听滚动
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent <=
              _scrollController.offset &&
          !_isLoading) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData({bool isFresh = false}) async {
    setState(() {
      _isLoading = true;
    });

    // 模拟延迟2s
    await Future.delayed(const Duration(seconds: 2));

    try {
      Map<String, dynamic> data = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/job/new-list');
      setState(() {
        _list = isFresh
            ? data['zpData']['jobList']
            : [..._list, ...data['zpData']['jobList']];
        _isLoading = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _onRefresh() async {
    await _fetchData(isFresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _list.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return index == _list.length - 1
                ? Column(
                    children: [
                      JobCard(
                        title: _list[index]['jobName'],
                        salary: _list[index]['salaryDesc'],
                        brandName: _list[index]['brandName'],
                        brandStageName: _list[index]['brandStageName'],
                        brandScaleName: _list[index]['brandScaleName'],
                        jobLabels: _list[index]['jobLabels'],
                        bossAvatar: _list[index]['bossAvatar'],
                        bossName: _list[index]['bossName'],
                        bossTitle: _list[index]['bossTitle'],
                        areaDistrict: _list[index]['areaDistrict'],
                        businessDistrict: _list[index]['businessDistrict'],
                      ),
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : JobCard(
                    title: _list[index]['jobName'],
                    salary: _list[index]['salaryDesc'],
                    brandName: _list[index]['brandName'],
                    brandStageName: _list[index]['brandStageName'],
                    brandScaleName: _list[index]['brandScaleName'],
                    jobLabels: _list[index]['jobLabels'],
                    bossAvatar: _list[index]['bossAvatar'],
                    bossName: _list[index]['bossName'],
                    bossTitle: _list[index]['bossTitle'],
                    areaDistrict: _list[index]['areaDistrict'],
                    businessDistrict: _list[index]['businessDistrict'],
                  );
          },
        ));
  }

  @override
  void dispose() {
    // 清除监听器以避免内存泄漏
    _scrollController.removeListener(() {});
    super.dispose();
  }
}
