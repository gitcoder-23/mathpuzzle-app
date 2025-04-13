import 'dart:async';


import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../../data/models/cube_root.dart';
import '../soundPlayer/audio_file.dart';

class CubeRootProvider extends GameProvider<CubeRoot> {
  int? level;

  CubeRootProvider({required int level})
      : super(gameCategoryType: GameCategoryType.CUBE_ROOT,) {
    this.level = level;


    startGame(level: this.level==null?null:level);
  }

  Future<void> checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    print("result===${int.parse(answer) == currentState.answer && timerStatus != TimerStatus.pause}");

    if (int.parse(answer) == currentState.answer && timerStatus != TimerStatus.pause) {
      rightAnswer();
      audioPlayer.playRightSound();
      rightCount = rightCount + 1;
      await Future.delayed(Duration(milliseconds: 300));
      loadNewDataIfRequired(level: level==null?null:level);

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
