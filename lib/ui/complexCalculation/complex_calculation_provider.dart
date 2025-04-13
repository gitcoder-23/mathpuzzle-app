import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import '../../data/models/ComplexModel.dart';

import '../soundPlayer/audio_file.dart';

class ComplexCalculationProvider extends GameProvider<ComplexModel> {
  int? level;
  // BuildContext? context;

  ComplexCalculationProvider({required int level})
      : super(gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,) {
    this.level = level;
    // this.context = context;
    startGame(level: this.level==null?null:level);
  }

  void checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (timerStatus != TimerStatus.pause) {
      result.value = answer;
      update();
      // notifyListeners();

      print("result===${result}====${currentState.finalAnswer}");

      if ((result) == currentState.finalAnswer) {
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount = rightCount + 1;
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }

      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level == null ? null : level);
      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      update();

    }
  }
}
