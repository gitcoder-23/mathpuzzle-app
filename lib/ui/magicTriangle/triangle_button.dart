import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/magic_triangle.dart';
import 'package:mathspuzzle/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathspuzzle/ui/soundPlayer/audio_file.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';

class TriangleButton extends StatelessWidget {
  final MagicTriangleGrid digit;
  final int index;
  final bool is3x3;
  final Tuple2<Color, Color> colorTuple;

  const TriangleButton({
    Key? key,
    required this.colorTuple,
    required this.digit,
    required this.index,
    required this.is3x3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = new AudioPlayer();

    double remainHeight = getRemainHeight(context: context);
    double height = remainHeight/11;

    if(!is3x3){
      height = remainHeight/14;
    }
    double radius = getPercentSize(height, 25);


    return Visibility(
      visible: digit.isVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: InkWell(
        onTap: () {
          audioPlayer.playTickSound();
          MagicTriangleProvider magicTriangleProvider = Get.find<MagicTriangleProvider>();
          magicTriangleProvider.checkResult(index, digit);
        },
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: height,
          decoration: getDefaultDecorationWithBorder(radius: radius,borderColor:  colorTuple.item1),

          alignment: Alignment.center,

          child: getTextWidget(Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
              digit.value, TextAlign.center, getPercentSize(height, 40)),

        ),
      ),
    );
  }
}
