import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/models/number_pyramid.dart';
import 'package:mathspuzzle/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import 'package:figma_squircle/figma_squircle.dart';

class PyramidNumberButton extends StatelessWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;
  final double buttonHeight;
  final Tuple2<Color, Color> colorTuple;

  PyramidNumberButton({
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required this.height,
    required this.buttonHeight,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final numberProvider = Get.find<NumberPyramidProvider>();

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = getWidthPercentSize(context, 100) / 8.5;
    double btnHeight = (buttonHeight / 10);
    double fontSize = getPercentSize(btnHeight, 23);

    print("screenSize ====$screenWidth-----$screenHeight--${(btnHeight)}");
    if (screenHeight < screenWidth) {
      fontSize = getPercentSize((btnHeight), 30);
    }

    return InkWell(
      onTap: () {
        numberProvider.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        width: width,

        alignment: Alignment.center,

        decoration: ShapeDecoration(
          gradient: numPyramidCellModel.isHint
              ? LinearGradient(
                  colors: [
                    colorTuple.item1,
                    colorTuple.item1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: numPyramidCellModel.isHint
              ? null
              : (numPyramidCellModel.isDone
                  ? (numPyramidCellModel.isCorrect
                      ? Colors.transparent
                      : Colors.redAccent)
                  : Colors.transparent),
          shape: SmoothRectangleBorder(
            side: BorderSide(
                color:
                    numPyramidCellModel.isActive ? Colors.black : Colors.black,
                width: 0.8),
            borderRadius: SmoothBorderRadius(
              cornerRadius: getPercentSize(height, 30),
            ),
          ),
        ),

        child: getTextWidget(
            Theme.of(context).textTheme.titleSmall!.copyWith(

                color: Colors.black)

            ,
            numPyramidCellModel.isHidden
                ? numPyramidCellModel.text
                : numPyramidCellModel.numberOnCell.toString(),
            TextAlign.center,
            fontSize),
      ),
    );
  }
}
