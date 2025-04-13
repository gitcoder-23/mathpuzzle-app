import 'dart:async';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/calculator.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import 'package:mathspuzzle/ui/soundPlayer/audio_file.dart';

class CalculatorProvider extends GameProvider<Calculator> {
  RxString result = "".obs;

  // BuildContext? context;
  int? level;


  CalculatorProvider(
      {
        // required TickerProvider vsync,
        required int level,
      })
          : super(gameCategoryType: GameCategoryType.CALCULATOR) {
    this.level = level;
    // this.context = context;
    startGame(level: this.level == null ? 1 : level,isTimer: true);
  }

  bool isClick = false;

  void checkResult(String answer) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    if (result.value.length < currentState.answer.toString().length &&
        timerStatus != TimerStatus.pause) {
      result.value = result.value + answer;
      update();


      if (int.parse(result.value) == currentState.answer) {

        audioPlayer.playRightSound();
        isClick=false;

        await Future.delayed(Duration(milliseconds: 300));
        loadNewDataIfRequired(level: level == null ? null : level);
        if (timerStatus != TimerStatus.pause) {
          restartTimer();
        }

        currentScore.value =
            currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
        update();
        // notifyListeners();
      } else if (result.value.length == currentState.answer.toString().length) {
        audioPlayer.playWrongSound();
        wrongAnswer();
      }
    }
  }

  void backPress() {
    if (result.value.length > 0) {
      result.value = result.value.substring(0, result.value.length - 1);
      update();
      // notifyListeners();
    }
  }

  void clearResult() {
    result.value = "";
    update();
    // notifyListeners();
  }
}
