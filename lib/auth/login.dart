import 'dart:convert';
import 'package:game_project/pages/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:game_project/auth/register.dart';
import 'package:game_project/components/api.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
    //
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

  _login() async {
    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };

    var res = await CallAPI().sendData(data, '/login');
    var body = json.decode(res.body);
    print(body);
    if (body['Token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['Token']);
      localStorage.setString('user', json.encode(usernameController.text));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Index(title: 'Gamz Hub')));
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
                height: 45,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
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
              ElevatedButton(
                  onPressed: () {
                    _login();
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
                  child: const Text('Login')),
              SizedBox(
                width: 300,
                child: Row(
                  children: <Widget>[
                    const Text('New user?'),
                    TextButton(
                        onPressed: () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register(
                                            title: 'Register',
                                          )))
                            },
                        child: const Text('Sign up here!'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
