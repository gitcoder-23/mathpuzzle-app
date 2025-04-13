import 'dart:async';

import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/true_false_model.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import '../soundPlayer/audio_file.dart';

class TrueFalseProvider extends GameProvider<TrueFalseModel> {
  int? level;

  TrueFalseProvider({required int level,})
      : super(gameCategoryType: GameCategoryType.TRUE_FALSE) {
    this.level = level;
    startGame(level: this.level==null?null:level);
  }

  void checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (timerStatus != TimerStatus.pause) {
      result.value = answer;
      update();


        if ((result) == currentState.answer) {
          audioPlayer.playRightSound();
          rightAnswer();
          rightCount = rightCount + 1;

          await Future.delayed(Duration(milliseconds: 300));
          loadNewDataIfRequired(level: level == null ? null : level);
          if (timerStatus != TimerStatus.pause) {
            restartTimer();
          }
          update();
          // notifyListeners();
        } else {
          wrongCount = wrongCount + 1;
          audioPlayer.playWrongSound();
          wrongAnswer();
        }

    }
  }
}
