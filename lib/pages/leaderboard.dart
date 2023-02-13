import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_project/auth/login.dart';
import 'package:game_project/components/api.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key, required this.title});
  final String title;

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late List<dynamic> _data = [];
  Future<void> getData() async {
    var res = await CallAPI().getData('/leaderboard');

    setState(() {
      _data = jsonDecode(res.body);
      print(_data);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: FittedBox(
                            child:
                                Image.network(_data[index]['url'].toString()),
                            fit: BoxFit.fill),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              _data[index]['username'].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              'Score: ' + _data[index]['score'].toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              'Time: ' + _data[index]['time'].toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            );
          },
        ));
  }
}
