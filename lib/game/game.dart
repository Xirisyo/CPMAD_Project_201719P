import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game_project/game/components/background-components.dart';
import 'package:game_project/game/components/bomb-component.dart';
import 'package:game_project/game/components/character-component.dart';
import 'package:game_project/game/components/coin-component.dart';
import 'package:game_project/game/components/gameover-screen.dart';

import '../components/global.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(),
        overlayBuilderMap: {
          Gameover.ID: (BuildContext context, MyGame gameRef) => Gameover(
                gameRef: gameRef,
              )
        },
      ),
    );
  }
}

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  int score = 0;
  late Timer _timer;
  late Timer _bombTimer;
  late TextComponent _scoreDisplay;
  late TextComponent _levelDisplay;
  late int time = 0;
  late int level = 1;
  CharacterComponent _character = CharacterComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // ignore: avoid_print
    print('Game Loading');

    add(BackgroundComponent());
    add(CoinComponent());
    add(_character);
    add(BombComponent());

    FlameAudio.audioCache
        .loadAll([Globals.coinCollectSound, Globals.explosionSound]);

    _scoreDisplay = TextComponent(
        text: 'Score: $score',
        position: Vector2(300, 50),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                backgroundColor: Colors.black)));
    add(_scoreDisplay);

    _levelDisplay = TextComponent(
        text: 'Level: $level',
        position: Vector2(30, 50),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                backgroundColor: Colors.black)));
    add(_levelDisplay);
    // ignore: no_leading_underscores_for_local_identifiers
    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        score += 1;
        time += 1.toInt();
      },
    );
    _timer.start();

    _bombTimer = Timer(
      30,
      repeat: true,
      onTick: () {
        add(BombComponent());
        level += 1.toInt();
        if (level % 3 == 0) {
          add(CoinComponent());
        }
      },
    );
    _bombTimer.start();
  }

  @override
  void update(dt) {
    _timer.update(dt);
    _bombTimer.update(dt);
    _scoreDisplay.text = 'Score: $score';
    _levelDisplay.text = 'Level: $level';

    super.update(dt);
  }

  void reset() {
    score = 0;
    time = 0.toInt();
    level = 1.toInt();
    _timer.reset();
    _bombTimer.reset();
    remove(_character);
    _character = CharacterComponent();
    add(_character);
  }
}
