import 'dart:async';

import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/mental_arithmetic.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MentalArithmeticProvider extends GameProvider<MentalArithmetic> {
  RxString result = "".obs;

  int? level;
  MentalArithmeticProvider({required int level})
      : super(

            gameCategoryType: GameCategoryType.MENTAL_ARITHMETIC) {
    this.level = level;
    startGame(level: this.level==null?null:level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();
    if (timerStatus != TimerStatus.pause &&
        result.value.length < currentState.answer.toString().length &&
        ((result.value.length == 0 && answer == "-") || (answer != "-"))) {
      result.value = result.value + answer;
      update();
      if (result != "-" && int.parse(result.value) == currentState.answer) {
        audioPlayer.playRightSound();

        currentScore.value =
            currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level==null?null:level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }
        update();
      } else if (result.value.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        if (currentScore.value > 0) {
          wrongAnswer();
        }
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
