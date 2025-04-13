import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/mathGrid/math_grid_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/mathGrid/math_grid_button.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

class MathGridView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathGridView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = screenWidth / 9;

    print("screenSize ====$screenWidth-----$screenHeight");
    if (screenHeight < screenWidth) {
      width = getScreenPercentSize(context, 3);
      print("width ====$width");
    }

    return GetBuilder<MathGridProvider>(
      init: MathGridProvider(level: colorTuple.item2),
      builder: (controller) => DialogListener<MathGridProvider>(
      colorTuple: colorTuple,
      appBar: CommonAppBar<MathGridProvider>(
          hint: false,
          infoView: CommonInfoTextView<MathGridProvider>(
              gameCategoryType: GameCategoryType.MATH_GRID,
              folder: colorTuple.item1.folderName!,
              color: colorTuple.item1.cellColor!),
          gameCategoryType: GameCategoryType.MATH_GRID,
          colorTuple: colorTuple,
          context: context),

      gameCategoryType: GameCategoryType.MATH_GRID,
      level: colorTuple.item2,

      child: CommonMainWidget<MathGridProvider>(
        gameCategoryType: GameCategoryType.MATH_GRID,
        color: colorTuple.item1.bgColor!,
        levelNo: colorTuple.item2,
        provider: controller,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
          child: Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: getPercentSize(mainHeight, 9)),
                        child: Center(
                          child: GetBuilder<MathGridProvider>(
                            init: controller,
                            builder: (controller) {
                              return getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                      fontWeight: FontWeight.bold),
                                  controller.currentState.currentAnswer.toString(),
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 4));
                            }),
                        ),
                      ),
                    ),
                    Container(
                      height: height1,
                      decoration: getCommonDecoration(context),
                      alignment: Alignment.bottomCenter,
                      child: GetBuilder<MathGridProvider>(
                        init: controller,
                          builder: (controller) {
                            return Container(
                              decoration: getDefaultDecoration(
                                  bgColor: colorTuple.item1.gridColor,
                                  borderColor: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color,
                                  radius: getCommonRadius(context)),
                              margin: EdgeInsets.all(getHorizontalSpace(context)),
                              child: GridView.builder(
                                  padding: EdgeInsets.all(
                                      getScreenPercentSize(context, 0.7)),
                                  gridDelegate: (screenHeight < screenWidth)
                                      ? SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 9,
                                    childAspectRatio:
                                    getScreenPercentSize(context, 0.3),
                                  )
                                      : SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 9,
                                  ),
                                  itemCount: controller
                                      .currentState.listForSquare.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return MathGridButton(
                                      gridModel: controller
                                          .currentState.listForSquare[index],
                                      index: index,
                                      colorTuple: Tuple2(
                                          colorTuple.item1.primaryColor!,
                                          colorTuple.item1.backgroundColor!),
                                    );
                                  }),
                            );
                          }),

                      // return ListView.builder(
                      //   itemCount: list.length,
                      //
                      //   itemBuilder: (context, index) {
                      //   return Container(
                      //     height: btnHeight,
                      //     decoration: getDefaultDecoration(
                      //       bgColor: colorTuple.item1.backgroundColor
                      //     ),
                      //   );
                      // },);
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        context: context,
        isTopMargin: false,
      ),

    ),);
  }
}
