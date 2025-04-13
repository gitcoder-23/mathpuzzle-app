import 'dart:async';

import 'package:mathspuzzle/data/models/square_root.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class SquareRootProvider extends GameProvider<SquareRoot> {
  int? level;


  SquareRootProvider({required int level,})
      : super(gameCategoryType: GameCategoryType.SQUARE_ROOT,) {
    this.level = level;


    startGame(level: this.level==null?null:level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (int.parse(answer) == currentState.answer &&
        timerStatus != TimerStatus.pause) {
      rightAnswer();
      audioPlayer.playRightSound();
      rightCount = rightCount +1;

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
    update();

  }
}
