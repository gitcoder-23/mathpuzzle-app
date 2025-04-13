import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/data/models/number_pyramid.dart';
import 'package:mathspuzzle/core/app_constant.dart';

import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumberPyramidProvider extends GameProvider<NumberPyramid> {

  int? level;

  NumberPyramidProvider({required int level})
      : super(gameCategoryType: GameCategoryType.NUMBER_PYRAMID) {
    this.level = level;

    startGame(level: this.level==null?null:level);  }

  void pyramidBoxSelection(NumPyramidCellModel model) {
    if (model.isHint) {
      return;
    }
    var previouslySelectedCell =
        currentState.list.indexWhere((cell) => cell.isActive == true);
    if (!previouslySelectedCell.isNegative) {
      currentState.list[previouslySelectedCell].isActive = false;
    }
    currentState.list[model.id - 1].isActive = true;

    update();
  }

  void pyramidBoxInputValue(String value) {
    var currentActiveCellIndex =
        currentState.list.indexWhere((cell) => cell.isActive == true);
    if (value == "Back") {
      currentState.list[currentActiveCellIndex].text = "";
      update();
      return;
    }
    var listOfCellWithValues =
        currentState.list.where((cell) => cell.text.isNotEmpty);

    if (value == "Done") {
      if (listOfCellWithValues.length == currentState.remainingCell) {
        checkCorrectValues();
        return;
      } else {
        return;
      }
    }

    var currentCellValue = currentState.list[currentActiveCellIndex].text;
    if (currentCellValue.isNotEmpty) {
      // check if already have value, then append
      var length = currentState.list[currentActiveCellIndex].text.length;
      if (length == 3) {
        // can't have more then 3 digits
        return;
      }
      currentState.list[currentActiveCellIndex].text = currentCellValue + value;
    } else {
      // fresh value
      currentState.list[currentActiveCellIndex].text = value;
    }

    update();
  }

  Future<void> checkCorrectValues() async {
    AudioPlayer audioPlayer = new AudioPlayer();

    for (int i = 0; i < currentState.list.length; i++) {
      if (!currentState.list[i].isHint) {
        if (!(currentState.list[i].numberOnCell ==
            int.parse(currentState.list[i].text))) {
          currentState.list[i].isCorrect = false;
          currentState.list[i].isDone = true;
        } else {
          currentState.list[i].isCorrect = true;
          currentState.list[i].isDone = true;
        }
      }
    }
    var correctVal = currentState.list.where((cell) => cell.isCorrect == true);

    if (correctVal.length == currentState.remainingCell) {
      audioPlayer.playRightSound();
      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level==null?null:level);
      currentScore.value =
          currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);

      if (timerStatus != TimerStatus.pause) {
        restartTimer();
      }
      update();
    }else{
      audioPlayer.playWrongSound();
    }
  }
}
