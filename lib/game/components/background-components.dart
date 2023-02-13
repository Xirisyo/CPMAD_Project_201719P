import 'package:flame/components.dart';
import 'package:game_project/game/game.dart';

import '../../components/global.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<MyGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.backgroundSprite);
    size = gameRef.size;
  }
}
