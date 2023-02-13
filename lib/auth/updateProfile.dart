import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_project/auth/login.dart';
import 'package:game_project/components/api.dart';
import 'package:game_project/pages/index.dart';
import 'package:game_project/user/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.title});
  final String title;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _updateProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = {
      'password': passwordController.text,
      'confirmPassword': confirmPasswordController.text,
      'token': localStorage.get('token')
    };

    var res = await CallAPI().sendData(data, '/update/profile');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode < 300) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Profile(title: 'Gamz Hub')));
    } else {
      _showMsg(body['Message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              const Image(image: AssetImage('resources/logo/Logo.png')),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: passwordController,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: confirmPasswordController,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _updateProfile();
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.fromLTRB(115, 10, 115, 10),
                      textStyle: const TextStyle(fontSize: 20),
                      side: const BorderSide(
                        color: Colors.white,
                      )),
                  child: const Text('Update Profile')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Profile(
                                title: 'Profile',
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
      ),
    );
  }
}
