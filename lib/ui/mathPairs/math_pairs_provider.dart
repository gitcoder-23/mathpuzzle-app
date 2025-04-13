import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/data/models/math_pairs.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MathPairsProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;

  MathPairsProvider({required int level})
      : super(gameCategoryType: GameCategoryType.MATH_PAIRS) {
      this.level = level;  this.context = context;

    startGame(level: this.level==null?null:level);  }

  Future<void> checkResult(Pair mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (timerStatus != TimerStatus.pause) {
      if (!currentState.list[index].isActive) {
        currentState.list[index].isActive = true;
        update();
        if (first != -1) {
          if (currentState.list[first].uid == currentState.list[index].uid) {
            audioPlayer.playRightSound();

            currentState.list[first].isVisible = false;
            currentState.list[index].isVisible = false;
            currentState.availableItem = currentState.availableItem - 2;
            first = -1;
            oldScore.value = currentScore.value;
            currentScore.value = currentScore.value + KeyUtil.mathematicalPairsScore;
            update();
            if (currentState.availableItem == 0) {
              await Future.delayed(Duration(milliseconds: 300));
              loadNewDataIfRequired(level: level==null?1:level);
              currentScore.value =
                  currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);

              if (timerStatus != TimerStatus.pause) {
                restartTimer();
              }
              update();
            }
          } else {
            audioPlayer.playWrongSound();
            wrongAnswer();
            currentState.list[first].isActive = false;
            currentState.list[index].isActive = false;
            first = -1;
            update();
          }
        } else {
          first = index;
        }
      } else {
        first = -1;
        currentState.list[index].isActive = false;
        update();
      }
    }
  }
}
