import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/math_pairs.dart';
import 'package:mathspuzzle/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../soundPlayer/audio_file.dart';

class MathPairsButton extends StatelessWidget {
  final Pair mathPairs;
  final int index;
  final Tuple2<Color, Color> colorTuple;
  final double height;

  MathPairsButton({
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.colorTuple,
  });

  MathPairsProvider mathPairsProvider = Get.find<MathPairsProvider>();

  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = new AudioPlayer();


    double radius = getPercentSize(height, 35);


    return AnimatedOpacity(
      opacity: mathPairs.isVisible ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: InkWell(
        onTap: () {
          audioPlayer.playTickSound();
          mathPairsProvider.checkResult(mathPairs, index);
        },
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(

          decoration:
          !mathPairs.isActive?
          getDefaultDecorationWithBorder(

                borderColor: Theme.of(context).textTheme.titleSmall!.color,
                radius: radius
              )
              :
          getDefaultDecorationWithGradient(
            radius: radius,
              borderColor: Theme.of(context).textTheme.titleSmall!.color,
              colors: LinearGradient(
            colors: [colorTuple.item2,colorTuple.item2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,)
          ),


          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,

            child: getTextWidget(Theme.of(context).textTheme.titleMedium!.copyWith(
              color: mathPairs.isActive
                        ? Colors.black
                        : null,
              fontWeight: FontWeight.bold
            ), mathPairs.text, TextAlign.center,
                getPercentSize(height, 20)),

          ),
        ),
      ),
    );
  }
}
