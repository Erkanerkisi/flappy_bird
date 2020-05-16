import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

import 'components/game.dart';
import 'components/start_game.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  var size = await Flame.util.initialDimensions();
  BirdGame game = BirdGame(size);
  runApp(game.widget);
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.onTap(evt));
  //flameUtil.fullScreen();
  //flameUtil.setOrientation(DeviceOrientation.portraitUp);
}
