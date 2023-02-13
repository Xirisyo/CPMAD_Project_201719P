import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:game_project/game/game.dart';
import 'package:flutter/widgets.dart';

import '../../components/global.dart';

class CharacterComponent extends SpriteComponent
    with HasGameRef<MyGame>, KeyboardHandler, CollisionCallbacks {
  final double _spriteHeight = 65;
  final double _spriteWidth = 87;

  int _hAxisInput = 0;
  int _vAxisInput = 0;
  final double _speed = 500;
  final Vector2 _velocity = Vector2.zero();
  late double screenWidth;
  late double screenHeight;
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.characterSprite);
    size = gameRef.size;
    position.x = gameRef.size.x / 2;
    position.y = 500;
    height = _spriteHeight;
    width = _spriteWidth;
    anchor = Anchor.topCenter;
    add(CircleHitbox());
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;
    _vAxisInput = 0;

    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;

    _vAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowUp) ? -1 : 0;
    _vAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowDown) ? 1 : 0;

    return true;
  }

  @override
  void update(double dt) {
    _velocity.x = _hAxisInput * _speed;
    _velocity.y = _vAxisInput * _speed;

    if (position.x >= gameRef.size.x) {
      position.x = 0;
    }
    if (position.x <= 0) {
      position.x = gameRef.size.x - 30;
    }
    if (position.y <= 0) {
      position.y = gameRef.size.y - 30;
    }
    if (position.y >= gameRef.size.y) {
      position.y = 0;
    }

    position += _velocity * dt;
    print(position);
    super.update(dt);
  }
}
