import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/magic_triangle.dart';
import 'package:mathspuzzle/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathspuzzle/ui/soundPlayer/audio_file.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_traingle_view.dart';

class TriangleInputButton extends StatelessWidget {
  final MagicTriangleInput input;
  final int index;
  final double cellHeight;
  final Tuple2<Color, Color> colorTuple;

  TriangleInputButton({
    required this.input,
    required this.cellHeight,
    required this.index,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer();
    // double height = remainHeight/10;
    double radius = getPercentSize(cellHeight, 25);

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      onTap: () {
        audioPlayer.playTickSound();
        MagicTriangleProvider concentrationProvider = Get.find<MagicTriangleProvider>();
        concentrationProvider
            .inputTriangleSelection(index, input);
      },
      child: CommonTriangleView(
        isMargin: true,
        height: cellHeight,
        width: cellHeight,
        color: Colors.transparent,
        child: Container(
          decoration: input.value.isNotEmpty
              ? getDefaultDecorationWithGradient(
                  radius: radius,
                  colors: LinearGradient(
                    colors: [lighten(colorTuple.item1, 0.05), colorTuple.item1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ))
              : getDefaultDecoration(
                  radius: radius,
                  bgColor: colorTuple.item2,
                  borderColor: input.isActive ? colorTuple.item1 : null),

          alignment: Alignment.center,

          child: getTextWidget(
              Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              input.value.toString(),
              TextAlign.center,
              getPercentSize(cellHeight, 45)),
        ),
      ),
    );
  }
}
