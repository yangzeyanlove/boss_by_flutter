import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  final String todo;

  JobDetail({
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => SecondDetail(todo: 'Hello')),
                // );
              },
            );
          }),
    );
  }
}
