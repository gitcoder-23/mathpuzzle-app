import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/picture_puzzle.dart';
import 'package:mathspuzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathspuzzle/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class PicturePuzzleAnswerButton extends StatelessWidget {
  final PicturePuzzleShape picturePuzzleShape;
  final Tuple2<Color, Color> colorTuple;
  final double height;
  final double width;

  PicturePuzzleAnswerButton({
    required this.picturePuzzleShape,
    required this.colorTuple,
    required this.height,
    required this.width,
  });

  PicturePuzzleProvider picturePuzzleProvider =
      Get.find<PicturePuzzleProvider>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return CommonWrongAnswerAnimationView(
        currentScore: picturePuzzleProvider.currentScore.value.toInt(),
        oldScore: picturePuzzleProvider.oldScore.value.toInt(),
        child: Container(


          decoration: getDefaultDecoration(
              borderColor: Theme.of(context).textTheme.titleSmall!.color,
              bgColor: lighten(colorTuple.item1),
              radius: getPercentSize(height, 20 )

          ),
child: Obx(() {
  return Center(
    child: getTextWidget(Theme.of(context).textTheme.titleSmall!.copyWith(


    ),
        picturePuzzleProvider.result.value == "" ? "?" : picturePuzzleProvider.result.value, TextAlign.center, getPercentSize(height, 60)),
  );
}),




        ),
      );
    });

  }
}
