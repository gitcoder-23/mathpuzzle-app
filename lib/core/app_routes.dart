import 'package:flutter/material.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/dashboard.dart';
import 'package:mathspuzzle/ui/calculator/calculator_view.dart';
import 'package:mathspuzzle/ui/complexCalculation/complex_calculation_view.dart';
import 'package:mathspuzzle/ui/concentration/concentration_view.dart';
import 'package:mathspuzzle/ui/correctAnswer/correct_answer_view.dart';
import 'package:mathspuzzle/ui/cubeRoot/cube_root_view.dart';
import 'package:mathspuzzle/ui/dashboard/dashboard_view.dart';
import 'package:mathspuzzle/ui/dualGame/dual_view.dart';
import 'package:mathspuzzle/ui/home/home_view.dart';
import 'package:mathspuzzle/ui/magicTriangle/magic_triangle_view.dart';
import 'package:mathspuzzle/ui/mathGrid/math_grid_view.dart';
import 'package:mathspuzzle/ui/mathPairs/math_pairs_view.dart';
import 'package:mathspuzzle/ui/mentalArithmetic/mental_arithmetic_view.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/picturePuzzle/picture_puzzle_view.dart';
import 'package:mathspuzzle/ui/numberPyramid/number_pyramid_view.dart';
import 'package:mathspuzzle/ui/quickCalculation/quick_calculation_view.dart';
import 'package:mathspuzzle/ui/splash/splash_view.dart';
import 'package:mathspuzzle/ui/squareRoot/square_root_view.dart';
import 'package:mathspuzzle/ui/guessTheSign/guess_sign_view.dart';
import 'package:tuple/tuple.dart';

import '../data/models/game_category.dart';
import '../ui/findMissing/find_missing_view.dart';
import '../ui/level/level_view.dart';
import '../ui/numericMemory/numeric_view.dart';
import '../ui/trueFalseQuiz/true_false_view.dart';

var appRoutes = {
  KeyUtil.dashboard: (context) => DashboardView(),
  // KeyUtil.splash: (context) => SplashView(),
  KeyUtil.home: (context) => HomeView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<Dashboard, double>),

  KeyUtil.level: (context) => LevelView(
      tuple2: ModalRoute.of(context)?.settings.arguments
          as Tuple2<GameCategory, Dashboard>),

  KeyUtil.calculator: (context) => CalculatorView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.guessSign: (context) => GuessSignView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.trueFalse: (context) => TrueFalseView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.complexCalculation: (context) => ComplexCalculationView(
      colorTuple:
      ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),


  KeyUtil.findMissing: (context) => FindMissingView(
      colorTuple:
      ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.dualGame: (context) => DualView(
      colorTuple:
      ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>  ),


  KeyUtil.correctAnswer: (context) => CorrectAnswerView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.quickCalculation: (context) => QuickCalculationView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.mentalArithmetic: (context) => MentalArithmeticView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.squareRoot: (context) => SquareRootView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.numericMemory: (context) => NumericMemoryView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.cubeRoot: (context) => CubeRootView(
      colorTuple:
      ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),
  KeyUtil.mathPairs: (context) => MathPairsView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.concentration: (context) => ConcentrationView(
      colorTuple:
      ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.magicTriangle: (context) => MagicTriangleView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),
  KeyUtil.mathGrid: (context) => MathGridView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),
  KeyUtil.picturePuzzle: (context) => PicturePuzzleView(
      colorTuple:
          ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),

  KeyUtil.numberPyramid: (context) => NumberPyramidView(
      colorTuple1: ModalRoute.of(context)?.settings.arguments as Tuple2<GradientModel, int>),



};
