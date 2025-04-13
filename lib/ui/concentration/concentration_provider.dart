import 'dart:async';
import 'package:mathspuzzle/data/models/math_pairs.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class ConcentrationProvider extends GameProvider<MathPairs> {
  int first = -1;
  int second = -1;
  int? level;
  bool isTimer=true;
  Function? nextQuiz;

  ConcentrationProvider({required int level,
    required Function nextQuiz,
    bool? isTimer})

      : super(gameCategoryType: GameCategoryType.CONCENTRATION,isTimer: isTimer,) {
      this.level = level;
      this.isTimer = (isTimer==null)?true:isTimer;
      this.nextQuiz = nextQuiz;

    startGame(level: this.level==null?null:level,isTimer: isTimer);

  }

  Future<void> checkResult(Pair mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer();

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

            update();

            if (currentState.availableItem == 0) {
              print("oldScore===$oldScore====$currentScore");

              print("oldScore===$oldScore====$currentScore");

              await Future.delayed(Duration(milliseconds: 300));
              loadNewDataIfRequired(level: level==null?1:level);
              currentScore.value =
                  currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
              if(nextQuiz!=null){
                nextQuiz!();
              }
              update();
            }
          } else {
            audioPlayer.playWrongSound();
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
