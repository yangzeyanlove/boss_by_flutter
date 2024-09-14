import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../common/http_request.dart';
import 'dart:convert';
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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Response response = await _http.get(
          'https://result.eolink.com/1PU8uLH9435a64bcd63e35fcb4dd6948bff5e7ebb444977?uri=/job/new-list');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.data);
        setState(() {
          _list = jsonMap['zpData']['jobList'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return JobCard(
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
    );
  }
}
