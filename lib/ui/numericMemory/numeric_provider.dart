import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/numeric_memory_pair.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';

import '../soundPlayer/audio_file.dart';

class NumericMemoryProvider extends GameProvider<NumericMemoryPair> {
  int first = -1;
  int second = -1;
  int? level;
  BuildContext? context;
  bool isTimer = true;
  Function? nextQuiz;

  NumericMemoryProvider(
      {
      required int level,
      required Function nextQuiz,
      bool? isTimer})
      : super(
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            isTimer: isTimer,) {
    this.level = level;
    this.isTimer = (isTimer == null) ? true : isTimer;
    this.nextQuiz = nextQuiz;

    startGame(level: this.level == null ? null : level, isTimer: isTimer);
  }

  Future<void> checkResult(String mathPair, int index) async {
    AudioPlayer audioPlayer = new AudioPlayer();

    print("mathPair===$mathPair===${currentState.answer}");

    if (mathPair == currentState.answer) {
      audioPlayer.playRightSound();
      currentScore.value = currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
    } else {
      wrongAnswer();
      audioPlayer.playWrongSound();
      first = -1;
    }

    await Future.delayed(Duration(seconds: 1));
    loadNewDataIfRequired(level: level == null ? 1 : level, isScoreAdd: false);

    if (nextQuiz != null) {
      nextQuiz!();
    }
    update();
  }
}
