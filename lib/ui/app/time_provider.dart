import 'dart:async';

import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/coin_provider.dart';

class TimeProvider extends CoinProvider {
  Timer? timer;

  RxInt currentTime = 0.obs;

  TimeProvider({
    required this.totalTime,
  }) {


  }

  startMethod(int seconds) {
    print("start====true");
    if (timer != null) {
      timer!.cancel();
    }
    var oneSec = Duration(seconds: 1);
    currentTime.value = seconds;

    print("timerMethod------${timerStatus}");

    timer = new Timer.periodic(oneSec, (Timer timer) {
      print("timerMethod--zdxfxgdfg----${timer}");

      if (currentTime.value <= 1) {
        timer.cancel();
        currentTime.value = 0;

        print("current-xzvcvnvbnbnm------${currentTime.value}-----${timerStatus}---");

        if (dialogType == DialogType.non) {
          print("dialog-----${dialogType}");
          dialogType = DialogType.over;
          timerStatus = TimerStatus.pause;
          update();
          // notifyListeners();
        }
      } else {
        currentTime.value = currentTime.value - 1;


        print("current-------${currentTime.value}-----${timerStatus}---");
        update();
        // notifyListeners();
      }

      print("${currentTime.value}");
    });
    
    print("overTimer-------${timer.toString()}");
  }

  final int totalTime;

  DialogType dialogType = DialogType.non;
  TimerStatus timerStatus = TimerStatus.restart;


  void startTimer() {
    // _animationController.reverse();
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    // _animationController.stop();
    timerStatus = TimerStatus.pause;
  }

  void resumeTimer() {

    print("callerd0---------resume");
    if (timer != null) {
      timer!.cancel();
    }
    startMethod(currentTime.value);
    // _animationController.reverse();
    timerStatus = TimerStatus.play;
  }

  void reset() {
    startMethod(totalTime);
    // _animationController.value = 1.0;
  }

  void restartTimer() {
    print("callerd0---------resume");
    // _animationController.reverse(from: 1.0);
    startMethod(totalTime);
    timerStatus = TimerStatus.play;
    dialogType = DialogType.non;
  }

  void increase() {

  }

  @override
  void dispose() {
    print("dispose---true");
    // _animationController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}
