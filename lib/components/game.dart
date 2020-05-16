import 'dart:ui';
import 'package:angry_erkan/components/background.dart';
import 'package:angry_erkan/components/game_over.dart';
import 'package:angry_erkan/components/pipe.dart';
import 'package:angry_erkan/components/pipe_spawner.dart';
import 'package:angry_erkan/components/score.dart';
import 'package:angry_erkan/components/start_game.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Bird.dart';

enum GameScreen { START, PLAYING, GAME_OVER }

class BirdGame extends Game {
  Size screenSize;
  Background background;
  Bird bird;
  Pipe pipe;
  double tileSize;
  PipeSpawner pipeSpawner;
  GameOver go;
  GameScreen gs;
  StartGame sg;
  Score score;

  BirdGame(size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
    background = Background(this);
    bird = Bird(this);
    score = Score(this);
    pipeSpawner = PipeSpawner(this);
    go = GameOver(this);
    sg = StartGame(this);
    gs = GameScreen.START;
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    if (gs == GameScreen.START) {
      sg.render(canvas);
    } else if (gs == GameScreen.PLAYING) {
      if (!bird.isDead) {
        bird.render(canvas);
        pipeSpawner.render(canvas);
        score.render(canvas);
      } else {
        gs = GameScreen.GAME_OVER;
      }
    } else {
      go.render(canvas, score);
    }
  }

  @override
  void update(double t) {
    if (gs == GameScreen.PLAYING) {
      bird.update(t, pipeSpawner);
      pipeSpawner.update(t);
      score.update(t,bird,pipeSpawner);
    }
  }

  void onTap(TapDownDetails evt) {
    print("GameScreen nedir: " + gs.toString());
    if (GameScreen.PLAYING == gs) {
      bird.onTap(evt);
    } else if (GameScreen.GAME_OVER == gs) {
      go.onTap(evt, callbackSetGameScreenRetry);
    } else if (GameScreen.START == gs) {
      sg.onTap(evt, callbackSetGameScreenStart);
    }
  }

  void callbackSetGameScreenStart(GameScreen gs) {
    print("callback " + gs.toString());
    this.gs = gs;
  }

  void callbackSetGameScreenRetry(GameScreen gs) {
    print("callback " + gs.toString());
    this.gs = gs;
    bird = Bird(this);
    pipeSpawner = PipeSpawner(this);
  }
}
