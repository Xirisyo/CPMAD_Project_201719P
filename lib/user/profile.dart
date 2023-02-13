import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_project/auth/updateProfile.dart';
import 'package:game_project/components/api.dart';
import 'package:game_project/pages/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../pages/index_guest.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});
  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String imageUrl = '';
  late String coins = '';
  late String username = '';

  void initState() {
    super.initState();
    _getImageUrl();
  }

  _getImageUrl() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = {
      'token': localStorage.get('token'),
    };
    var res = await CallAPI().sendData(data, '/get/profile');
    var body = json.decode(res.body);
    print(body);
    if (body['image'] != null) {
      setState(() {
        imageUrl = body['url'] + body['image'];
        coins = body['coins'].toString();
        username = body['username'];
        print(imageUrl);
      });
    } else {
      // ignore: avoid_print
      print('Request failed');
    }
  }

  _logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const IndexGuest(title: 'Gamz Hub')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: imageUrl == ''
                  ? const CircularProgressIndicator()
                  : FittedBox(child: Image.network(imageUrl), fit: BoxFit.fill),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              username,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Coins: " + coins,
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfile(
                              title: 'Update Profile',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.fromLTRB(115, 10, 115, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Update Profile')),
            ElevatedButton(
                onPressed: () {
                  _logout();
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(125, 10, 125, 10),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Logout')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Index(
                              title: 'Index',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(115, 10, 115, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Back')),
          ],
        ),
      ),
    );
  }
}
