import 'package:flutter/material.dart';
import 'package:game_project/game/game.dart';
import 'package:game_project/main.dart';

class Gameover extends StatelessWidget {
  final MyGame gameRef;
  static const String ID = 'GOM';

  const Gameover({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Image(image: AssetImage('resources/logo/Logo.png')),
            const SizedBox(
              height: 80,
            ),
            Container(
              child: Text('Score: ${gameRef.score}',
                  style: TextStyle(fontSize: 30)),
            ),
            Container(
              child:
                  Text('Time: ${gameRef.time}', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(Gameover.ID);
                  gameRef.reset();
                  gameRef.resumeEngine();
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.fromLTRB(125, 10, 125, 10),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Restart')),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(Gameover.ID);
                  gameRef.reset();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(105, 10, 105, 10),
                    textStyle:
                        const TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                    side: const BorderSide(
                      color: Colors.white,
                    )),
                child: const Text('Main Menu')),
          ],
        ),
      ),
    );
  }
}
