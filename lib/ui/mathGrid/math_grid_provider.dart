import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/data/models/math_grid.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MathGridProvider extends GameProvider<MathGrid> {
  int answerIndex = 0;
  int? level;


  MathGridProvider({required int level})
      : super(gameCategoryType: GameCategoryType.MATH_GRID,) {
    this.level = level;
    startGame(level: this.level==null?1:level);
  }

  void checkResult(int index, MathGridCellModel gridModel) {
    if (timerStatus != TimerStatus.pause) {
      if (gridModel.isActive) {
        gridModel.isActive = false;
        update();
      } else {
        gridModel.isActive = true;
        update();
      }
      checkForCorrectAnswer();
    }
  }

  Future<void> checkForCorrectAnswer() async {
    AudioPlayer audioPlayer = new AudioPlayer();
    int total = 0;
    var listOfIndex = currentState.listForSquare
        .where((result) => result.isActive== true)
        .toList();

    for (int i = 0; i < listOfIndex.length; i++) {
      total = total + listOfIndex[i].value;
    }

    if (currentState.currentAnswer == total) {
      for (int i = 0; i < listOfIndex.length; i++) {
        listOfIndex[i].isActive = false;
        listOfIndex[i].isRemoved = true;
      }
      answerIndex = answerIndex + 1;
      if (currentState.listForSquare
          .where((element) => !element.isRemoved)
          .isEmpty) {


        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired( level: level==null?1:level);
        answerIndex = 0;
        currentScore.value =
            currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        update();

      } else {
        audioPlayer.playRightSound();
        currentState.currentAnswer = currentState.getNewAnswer();
      }
    }
  }

  clear() {
    update();
  }
}
