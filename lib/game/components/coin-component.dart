import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_project/game/components/character-component.dart';
import 'package:game_project/game/game.dart';

import '../../components/global.dart';

class CoinComponent extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final double _length = 50;
  final Random _random = Random();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.coinSprite);
    height = width = _length;
    position = _randomXY();
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  Vector2 _randomXY() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is CharacterComponent) {
      FlameAudio.play(Globals.coinCollectSound);
      removeFromParent();
      gameRef.score += 10;
      print(gameRef.score);
      gameRef.add(CoinComponent());
    }
  }
}
