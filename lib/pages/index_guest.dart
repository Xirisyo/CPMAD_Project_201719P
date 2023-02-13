import 'package:flutter/material.dart';
import 'package:game_project/auth/login.dart';
import 'package:game_project/pages/leaderboard.dart';
import 'package:game_project/pages/shop.dart';

import '../game/game.dart';
import 'about.dart';

class IndexGuest extends StatefulWidget {
  const IndexGuest({super.key, required this.title});
  final String title;

  @override
  State<IndexGuest> createState() => _IndexGuestState();
}

class _IndexGuestState extends State<IndexGuest> {
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
              height: 80,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Game()),
                )
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: const EdgeInsets.fromLTRB(120, 10, 120, 10),
                textStyle: const TextStyle(fontSize: 20),
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
              child: const Text('Play'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeaderBoard(
                              title: 'Leaderboard',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.fromLTRB(83, 10, 83, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Leaderboard')),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Shop(
                              title: 'Shop',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.fromLTRB(115, 10, 115, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Shop')),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const About(
                              title: 'About',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.fromLTRB(110, 10, 110, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('About')),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login(
                              title: 'Login',
                            )),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.fromLTRB(112, 10, 112, 10),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
