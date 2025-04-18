import 'package:flutter/material.dart';
import 'package:mathspuzzle/ui/common/common_tab_animation_view.dart';

import '../../utility/Constants.dart';
import '../soundPlayer/audio_file.dart';

class CommonBackButton extends StatelessWidget {
  final Function onTab;
  final double height;
  final double? btnRadius;

  const CommonBackButton({
    Key? key,
    required this.onTab,
    this.btnRadius,
    this.height = 112,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = new AudioPlayer();

    double radius =
        btnRadius == null ? getCommonCalculatorRadius(context) : btnRadius;

    return CommonTabAnimationView(
        onTab: () {
          onTab();
          audioPlayer.playTickSound();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            alignment: Alignment.center,
            // height: height,

            decoration: getDefaultDecoration(
                bgColor: Colors.white,
                radius: radius,
                borderColor: Theme.of(context).textTheme.titleMedium!.color,
                borderWidth: 1.2),
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 2), vertical: 2),

            child: Center(
              child: Icon(
                Icons.backspace,
                size: getPercentSize(height, 20),
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
