import 'dart:async';

import 'package:mathspuzzle/data/models/magic_triangle.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class MagicTriangleProvider extends GameProvider<MagicTriangle> {
  int selectedTriangleIndex = 0;
  int? level;
  // BuildContext? context;

  MagicTriangleProvider({required int level,})
      : super(gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,) {
    this.level = level;
    // this.context = context;
    startGame(level: this.level==null?null:level);
  }

  void inputTriangleSelection(int index, MagicTriangleInput input) {
    if (timerStatus != TimerStatus.pause) {
      if (input.value.isEmpty) {
        for (int i = 0; i < currentState.listTriangle.length; i++) {
          currentState.listTriangle[i].isActive = false;
        }
        selectedTriangleIndex = index;
        currentState.listTriangle[index].isActive = true;
        update();
      } else {
        int listGridIndex = currentState.listGrid.indexWhere(
            (val) => val.value == input.value && val.isVisible == false);
        currentState.listTriangle[index].isActive = false;
        currentState.listTriangle[index].value = "";
        currentState.availableDigit = currentState.availableDigit + 1;
        currentState.listGrid[listGridIndex].isVisible = true;
        update();
        // notifyListeners();
      }
    }
  }

  Future<void> checkResult(int index, MagicTriangleGrid digit) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (timerStatus != TimerStatus.pause) {
      int activeTriangleIndex =
          currentState.listTriangle.indexWhere((val) => val.isActive == true);
      if (currentState.listTriangle[activeTriangleIndex].value.isNotEmpty) {
        return;
      }
      currentState.listTriangle[selectedTriangleIndex].value = digit.value;
      currentState.listGrid[index].isVisible = false;
      currentState.availableDigit = currentState.availableDigit - 1;

      if (currentState.availableDigit == 0) {
        if (currentState.checkTotal()) {
          audioPlayer.playRightSound();
          await Future.delayed(Duration(milliseconds: 300));
          loadNewDataIfRequired(level: level==null?null:level);
          selectedTriangleIndex = 0;
          currentScore.value =
              currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
          if (timerStatus != TimerStatus.pause) {
            restartTimer();
          }
          update();
          // notifyListeners();
        }else{
          audioPlayer.playWrongSound();
          print("wrong---true");
        }
      }
      update();
      // notifyListeners();
    }
  }
}
