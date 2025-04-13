import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/data/models/quick_calculation.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class QuickCalculationProvider extends GameProvider<QuickCalculation> {

  late QuickCalculation nextCurrentState;
  QuickCalculation? previousCurrentState;
  int? level;


  QuickCalculationProvider({required int level})
      : super(
            gameCategoryType: GameCategoryType.QUICK_CALCULATION,) {
    this.level = level;

    startGame(level: this.level==null?null:level);    nextCurrentState = list[index + 1];
  }

  Future<void> checkResult(String answer) async {

    AudioPlayer audioPlayer = new AudioPlayer();
    if (result.value.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result.value = result.value + answer;
      update();
      if (int.parse(result.value) == currentState.answer) {
        audioPlayer.playRightSound();
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level==null?null:level);
        previousCurrentState = list[index - 1];
        nextCurrentState = list[index + 1];
        currentScore.value =
            currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
        update();
      } else if (result.value.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        if (currentScore.value > 0) {
          wrongAnswer();
        }
      }
    }
  }

  clearResult() {
    result.value = "";
    update();
  }

  void backPress() {
    if (result.value.length > 0) {
      result.value = result.value.substring(0, result.value.length - 1);
      update();
    }
  }
}
