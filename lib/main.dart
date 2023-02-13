import 'package:game_project/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:game_project/pages/index_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame/flame.dart';
import 'dart:developer';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<String>(
          future: _getToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData && snapshot.data != '') {
              return const Index(title: 'Game');
            } else {
              return const IndexGuest(title: 'Game');
            }
          },
        ));
  }
}
