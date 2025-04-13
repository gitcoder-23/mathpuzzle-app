import 'dart:async';

import 'package:mathspuzzle/data/models/sign.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class GuessSignProvider extends GameProvider<Sign> {
  int? level;

  GuessSignProvider(
      {
      required int level,
      })
      : super(gameCategoryType: GameCategoryType.GUESS_SIGN,) {
    this.level = level;
    startGame(level: this.level == null ? null : level);
  }

  void checkResult(
    String answer,
  ) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (timerStatus != TimerStatus.pause) {
      result.value = answer;
      update();
      if (result == currentState.sign) {
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
