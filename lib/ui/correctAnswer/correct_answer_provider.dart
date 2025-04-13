import 'dart:async';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/correct_answer.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class CorrectAnswerProvider extends GameProvider<CorrectAnswer> {
  RxString result = "".obs;
  int? level;

  CorrectAnswerProvider({required int level,})
      : super(gameCategoryType: GameCategoryType.CORRECT_ANSWER,) {
    this.level = level;
    startGame(level: this.level==null?null:level);
  }

  Future<void> checkResult(String answer) async {

    AudioPlayer audioPlayer = new AudioPlayer();


    if (timerStatus != TimerStatus.pause) {
      result.value = answer;
      update();
      if (int.parse(result.value) == currentState.answer) {
        audioPlayer.playRightSound();
        rightAnswer();
        rightCount = rightCount + 1;
        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        update();
      } else {
        wrongCount = wrongCount + 1;
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }
}
