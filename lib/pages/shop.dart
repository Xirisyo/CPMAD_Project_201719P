import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_project/components/api.dart';

class Shop extends StatefulWidget {
  const Shop({super.key, required this.title});
  final String title;

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late List<dynamic> _data = [];
  Future<void> getData() async {
    var res = await CallAPI().getData('/products');

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
      body: GridView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: FittedBox(
                      child: Image.network(_data[index]['url'].toString()),
                      fit: BoxFit.fill),
                ),
                Text(_data[index]['name'].toString()),
                Text(_data[index]['price'].toString() + " coins"),
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
      ),
    );
  }
}
