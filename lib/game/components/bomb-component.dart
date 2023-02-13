import 'dart:convert';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_project/components/api.dart';
import 'package:game_project/game/components/character-component.dart';
import 'package:game_project/game/components/gameover-screen.dart';
import 'package:game_project/game/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/global.dart';

class BombComponent extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final double _length = 50;
  final double _speed = 200;
  final Vector2 _position = Vector2(0, 0);
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.bombSprite);
    size = gameRef.size;
    height = width = _length;
    anchor = Anchor.center;

    _position.x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    _position.y = 0;
    position = _position;
    add(CircleHitbox());
  }

  @override
  void update(dt) {
    _position.y += _speed * dt;
    position = _position;
    super.update(dt);

    if (_position.y >= gameRef.size.y) {
      _position.x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
      _position.y = 0;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is CharacterComponent) {
      FlameAudio.play(Globals.explosionSound);
      removeFromParent();
      gameRef.add(BombComponent());
      print('Game Over');
      gameOver();
      saveResults(gameRef);
    }
  }

  void gameOver() {
    gameRef.pauseEngine();
    gameRef.overlays.add(Gameover.ID);
  }

  void saveResults(gameRef) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = {
      'token': localStorage.get('token'),
      'score': gameRef.score,
      'time': gameRef.time,
    };

    var res = await CallAPI().sendData(data, '/new/score');
    var body = json.decode(res.body);
    print(body);
    gameRef.reset();
    gameRef.remove(this);
  }
}
