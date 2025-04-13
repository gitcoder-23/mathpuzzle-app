import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/math_grid.dart';
import 'package:mathspuzzle/ui/app/theme_provider.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:mathspuzzle/ui/mathGrid/math_grid_provider.dart';
import 'package:tuple/tuple.dart';

import '../soundPlayer/audio_file.dart';

class MathGridButton extends StatelessWidget {
  final MathGridCellModel gridModel;
  final int index;
  final Tuple2<Color, Color> colorTuple;

  MathGridButton({
    required this.gridModel,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer();

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;
    double fontSize = getPercentSize(width, 40);

    print("screenSize ====$screenWidth-----$screenHeight");
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 0.3);
      fontSize = getScreenPercentSize(context, 1.7);
      print("width ====$width---${getPercentSize(width, 100)}");
    }

    ThemeProvider themeProvider = Get.find<ThemeProvider>();
    Color color = "#383838".toColor();

    color = colorTuple.item2;

    return Container(
      decoration: getDefaultDecoration(
          bgColor: gridModel.isRemoved
              ? Colors.transparent
              : gridModel.isActive
                  ? Theme.of(context).scaffoldBackgroundColor
                  : color,
          borderColor: Theme.of(context).textTheme.titleSmall!.color,
          radius: getScreenPercentSize(context, 2)),

      child: Visibility(
        visible: !(gridModel.isRemoved),
        child: InkWell(
          onTap: () {
            audioPlayer.playTickSound();
            MathGridProvider concentrationProvider = Get.find<MathGridProvider>();
            concentrationProvider.checkResult(index, gridModel);
          },
          child: Center(
            child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: gridModel.isActive
                      ? themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white
                      : Colors.black),
              gridModel.value.toString(),
              TextAlign.center,
              fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
