import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/picture_puzzle.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class PicturePuzzleProvider extends GameProvider<PicturePuzzle> {
  RxString result = "".obs;
  int? level;

  PicturePuzzleProvider(
      {
      required int level,
      })
      : super(gameCategoryType: GameCategoryType.PICTURE_PUZZLE,) {
    this.level = level;
    startGame(level: this.level == null ? null : level);
  }

  void checkGameResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (result.value.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result.value = result.value + answer;
      update();
      if (int.parse(result.value) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        currentScore.value =
            currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);

        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        update();
      } else if (result.value.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (result.value.length > 0) {
      result.value = result.value.substring(0, result.value.length - 1);
      update();
    }
  }

  void clearResult() {
    result.value = "";
    update();
  }
}
