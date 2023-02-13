import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key, required this.title});
  final String title;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
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
            Container(
                height: 398,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 8),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Container(
                    child: const Text(
                      'How To Play?',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    child: const Text(
                      'Your goal is to survive as long as possible while collecting coins. There are also bombs in the game, game starts with 1 bomb and every 1 level, a new bomb appears permanently and every 3 levels a new coin appears permanently.',
                      style: TextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Gamz Hub is a place for games with new beginning, where all the gaming that are being develop are. Contact us at +6599991232 or email us at abc@gmail.com. Created by Senz Studio, All Rights Reserved.'),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      _urlLauncher(
                          'mailto:abc@gmail.com?subject=Feedback&body=Write%20your%20message%20here.');
                    },
                    child: const Icon(Icons.mail),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _urlLauncher('tel:+6599911243');
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          // padding: const EdgeInsets.fromLTRB(108, 10, 108, 10),
                          textStyle: const TextStyle(fontSize: 20),
                          side: const BorderSide(
                            color: Colors.white,
                          )),
                      child: const Icon(Icons.phone)),
                ])),
          ],
        ),
      ),
    );
  }

  Future<void> _urlLauncher(String s) async {
    if (await canLaunch(s)) {
      await launch(s);
    } else {
      throw 'Could not launch $s';
    }
  }
}
