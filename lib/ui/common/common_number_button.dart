import 'package:flutter/material.dart';
import 'package:mathspuzzle/ui/common/common_tab_animation_view.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/soundPlayer/audio_file.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class CommonNumberButton extends StatelessWidget {
  final Function onTab;
  final String text;

  final double totalHeight;
  final double height;
  final double fontSize;
  final bool is4Matrix;
  final bool isDarken;
  final double? btnRadius;

  final Tuple2<GradientModel, int> colorTuple;

  const CommonNumberButton({
    Key? key,
    required this.text,
    required this.onTab,
     this.btnRadius,

    this.is4Matrix = false,
    this.isDarken = true,
    this.fontSize = 24,
    this.height = 24,
    this.totalHeight = 24,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = new AudioPlayer();

    double radius = btnRadius==null?getCommonCalculatorRadius(context):btnRadius;

    return CommonTabAnimationView(
      onTab:(){
        onTab();
        audioPlayer.playTickSound();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
            alignment: Alignment.center,
            // height: height,

            decoration:getDefaultDecoration(
              // bgColor: "#FFDB7C".toColor(),
              bgColor: colorTuple.item1.backgroundColor,
                radius: radius,
              borderColor: Theme.of(context).textTheme.titleMedium!.color
                ,borderWidth: 1.2
            ) ,
            margin: EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2),vertical: 2),

            child:Center(
              child: getTextWidget(Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),text,TextAlign.center,
                  getPercentSize(height, 28)
              ),
            )),
      ),
    );
  }
}
