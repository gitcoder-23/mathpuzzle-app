import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
// import 'package:get_it/get_it.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/repository/calculator_repository.dart';
import 'package:mathspuzzle/data/repository/complex_calcualtion_repository.dart';
import 'package:mathspuzzle/data/repository/correct_answer_repository.dart';
import 'package:mathspuzzle/data/repository/cube_root_repository.dart';
import 'package:mathspuzzle/data/repository/dual_repository.dart';
import 'package:mathspuzzle/data/repository/find_missing_repository.dart';
import 'package:mathspuzzle/data/repository/magic_triangle_repository.dart';
import 'package:mathspuzzle/data/repository/math_grid_repository.dart';
import 'package:mathspuzzle/data/repository/math_pairs_repository.dart';
import 'package:mathspuzzle/data/repository/mental_arithmetic_repository.dart';
import 'package:mathspuzzle/data/repository/number_pyramid_repository.dart';
import 'package:mathspuzzle/data/repository/picture_puzzle_repository.dart';
import 'package:mathspuzzle/data/repository/quick_calculation_repository.dart';
import 'package:mathspuzzle/data/repository/sign_repository.dart';
import 'package:mathspuzzle/data/repository/square_root_repository.dart';
import 'package:mathspuzzle/data/repository/true_false_repository.dart';
import 'package:mathspuzzle/ui/app/time_provider.dart';
import 'package:mathspuzzle/ui/dashboard/dashboard_provider.dart';

import '../../ads/AdsFile.dart';
import '../../data/repository/numeric_memory_repository.dart';


int rightCoin = 10;
int wrongCoin = 5;
int hintCoin = 10;



class GameProvider<T> extends TimeProvider with WidgetsBindingObserver {
  final GameCategoryType gameCategoryType;
  final homeViewModel = Get.find<DashboardProvider>();
  // final homeViewModel = GetIt.I<DashboardProvider>();

  late List<T> list;
  late int index;
  RxDouble currentScore = 0.0.obs;
  late double score1 = 0;
  late double score2 = 0;
  late int rightCount = 0;
  late int wrongCount = 0;
  RxDouble oldScore = 0.0.obs;
  late T currentState;
  RxString result = "".obs;
  late bool isTimer;
  late bool isRewardedComplete = false;
  late int levelNo;
  late AdsFile adsFile;
  // late BuildContext c;


  GameProvider(
      {
        // required TickerProvider vsync,
      required this.gameCategoryType,
        // required this.c,
      bool? isTimer})
      : super(
          // vsync: TickerProvider,
          totalTime: KeyUtil.getTimeUtil(gameCategoryType),
        ) {
    this.isTimer = (isTimer == null) ? true : isTimer;
    adsFile = new AdsFile();

    adsFile.createRewardedAd();
    print("isTimer12===$isTimer");
  }

  @override
  void dispose() {
    disposeRewardedAd(adsFile);
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void startGame({int? level, bool? isTimer}) async {
    isTimer = (isTimer == null) ? true : isTimer;
    result.value = "";

    list = [];

    print("level--$level");
    list = getList(level == null ? 1 : level);

    print("level--$level");

    print("list--${list.length}====");
    index = 0;
    currentScore.value = 0;
    oldScore.value = 0;
    currentState = list[index];
    if (homeViewModel.isFirstTime(gameCategoryType)) {
      await Future.delayed(Duration(milliseconds: 100));
      showInfoDialog();
    } else {
      print("isTimerStart==$isTimer");
      if (isTimer) {
        restartTimer();
        update();
        // notifyListeners();
      }
    }
    WidgetsBinding.instance.addObserver(this);
  }


  void showHintDialog() {
    // print("dialog---true2");
    pauseTimer();
    // print("dialog---true3");
    dialogType = DialogType.hint;
    // print("dialog---true1");
    update();
    // notifyListeners();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:

        print("resume===true");
        break;
      case AppLifecycleState.inactive:
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        if (isTimer && dialogType != DialogType.pause) {
          pauseTimer();
          dialogType = DialogType.pause;
          update();
          // notifyListeners();
        }
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }

  void loadNewDataIfRequired({int? level, bool? isScoreAdd}) {
    isFirstClick = false;
    isSecondClick = false;
    print("list12===${list.length}");

    if (index < 19) {
      if (gameCategoryType == GameCategoryType.QUICK_CALCULATION &&
          list.length - 2 == index) {
        list.addAll(getList(level == null ? index ~/ 5 + 1 : level));
      } else if (list.length - 1 == index) {
        print("level---${index ~/ 5 + 1}");
        if (gameCategoryType == GameCategoryType.SQUARE_ROOT)
          list.addAll(getList(level == null ? index ~/ 5 + 2 : level));
        else
          list.addAll(getList(level == null ? index ~/ 5 + 1 : level));
      }
      print("list1212===${list.length}");
      result.value = "";
      index = index + 1;

      print("index===$index");
      // if(isScoreAdd==null) {
      //   oldScore = currentScore;
      //   currentScore = currentScore + KeyUtil.getScoreUtil(gameCategoryType);
      //
      //
      //   print("currentScore===$currentScore==${KeyUtil.getScoreUtil(
      //       gameCategoryType)}");
      // }
      currentState = list[index];
    } else {
      dialogType = DialogType.over;
      if (isTimer) {
        pauseTimer();
      }
      update();
      // notifyListeners();
    }
  }

  bool isFirstClick = false;
  bool isSecondClick = false;

  void wrongDualAnswer(bool isFirst) {
    if (isFirst) {
      if (score1 > 0) {
        score1--;
        update();
        // notifyListeners();
      } else if (score1 == 0 && isSecondClick && score2 <= 0) {
        dialogType = DialogType.over;
        pauseTimer();
        update();
        // notifyListeners();
      } else {
        update();
        // notifyListeners();
      }
    } else {
      if (score2 > 0) {
        score2--;
        update();
        // notifyListeners();
      } else if (score2 == 0 && isFirstClick && score1 <= 0) {
        dialogType = DialogType.over;
        pauseTimer();
        update();
        // notifyListeners();
      } else {
        update();
        // notifyListeners();
      }
    }
  }

  void rightAnswer() {
    print("currentScoreRight===$currentScore");
    oldScore.value = currentScore.value;
    currentScore.value = currentScore.value + KeyUtil.getScoreUtil(gameCategoryType);
    print("currentScore===12 $currentScore");
    update();
    // notifyListeners();
  }

  void wrongAnswer() {

    if (currentScore > 0) {
      oldScore = currentScore;

      double minusScore = KeyUtil.getScoreMinusUtil(gameCategoryType);

      if (minusScore < 0) {
        minusScore = minusScore.abs();
      }

      currentScore.value = currentScore.value - minusScore;
      update();
      // notifyListeners();

    }
    else if (currentScore == 0

        ) {

      dialogType = DialogType.over;
      pauseTimer();
      update();
      // notifyListeners();

    }
    // }
  }

  void pauseResumeGame() {
    dialogType = DialogType.non;
    if (isTimer) {
      if (timerStatus == TimerStatus.play) {
        pauseTimer();
        dialogType = DialogType.pause;
        update();
        // notifyListeners();
      } else {
        resumeTimer();
        dialogType = DialogType.non;
        update();
        // notifyListeners();
      }
    }

    // print("dialogType====${dialogType}");
  }

  void showInfoDialog() {
    pauseTimer();
    dialogType = DialogType.info;
    update();
    // notifyListeners();
  }

  void showExitDialog() {
    // print("dialog---true2");
    pauseTimer();
    // print("dialog---true3");
    dialogType = DialogType.exit;
    // print("dialog---true1");
    update();
    // notifyListeners();
  }

  void updateScore() {

    print("current===$currentScore");
    homeViewModel.updateScoreboard(gameCategoryType, currentScore.value);
  }

  void gotItFromInfoDialog(int? level) {
    if (homeViewModel.isFirstTime(gameCategoryType)) {
      homeViewModel.setFirstTime(gameCategoryType);
      if (gameCategoryType == GameCategoryType.MENTAL_ARITHMETIC) {
        startGame(level: level);
      }
      if (isTimer) {
        restartTimer();
      }
    } else {
      pauseResumeGame();
    }

    print("home-==${homeViewModel.isFirstTime(gameCategoryType)}");
  }

  List<T> getList(int level) {
    this.levelNo = level;

    switch (gameCategoryType) {
      case GameCategoryType.CALCULATOR:
        return CalculatorRepository.getCalculatorDataList(level);
      case GameCategoryType.GUESS_SIGN:
        return SignRepository.getSignDataList(level);
      case GameCategoryType.FIND_MISSING:
        return FindMissingRepository.getFindMissingDataList(level);
      case GameCategoryType.TRUE_FALSE:
        return TrueFalseRepository.getTrueFalseDataList(level);
      case GameCategoryType.SQUARE_ROOT:
        return SquareRootRepository.getSquareDataList(level);
      case GameCategoryType.MATH_PAIRS:
        return MathPairsRepository.getMathPairsDataList(level);
      case GameCategoryType.CONCENTRATION:
        return MathPairsRepository.getMathPairsDataList(level);
      case GameCategoryType.NUMERIC_MEMORY:
        return NumericMemoryRepository.getNumericMemoryDataList(level);
      case GameCategoryType.CORRECT_ANSWER:
        return CorrectAnswerRepository.getCorrectAnswerDataList(level);
      case GameCategoryType.MAGIC_TRIANGLE:
        if (level > 15) {
          return MagicTriangleRepository.getNextLevelTriangleDataProviderList();
        } else {
          return MagicTriangleRepository.getTriangleDataProviderList();
        }
      case GameCategoryType.MENTAL_ARITHMETIC:
        return MentalArithmeticRepository.getMentalArithmeticDataList(level);
      case GameCategoryType.QUICK_CALCULATION:
        return QuickCalculationRepository.getQuickCalculationDataList(level, 5);
      case GameCategoryType.MATH_GRID:
        return MathGridRepository.getMathGridData(level);
      case GameCategoryType.PICTURE_PUZZLE:
        return PicturePuzzleRepository.getPicturePuzzleDataList(level);
      case GameCategoryType.NUMBER_PYRAMID:
        return NumberPyramidRepository.getPyramidDataList(level);
      case GameCategoryType.DUAL_GAME:
        return DualRepository.getDualData(level);
      case GameCategoryType.COMPLEX_CALCULATION:
        return ComplexCalculationRepository.getComplexData(level);
      case GameCategoryType.CUBE_ROOT:
        return CubeRootRepository.getCubeDataList(level);
    }
  }
}
