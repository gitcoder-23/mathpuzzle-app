import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_back_button.dart';
import 'package:mathspuzzle/ui/common/common_clear_button.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';
import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';
import 'number_pyramid_button.dart';

class NumberPyramidView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple1;

  NumberPyramidView({
    Key? key,
    required this.colorTuple1,
  }) : super(key: key);

  final List<String> list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Done",
    "0",
    "Back"
  ];

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;

    double height1 = getScreenPercentSize(context, 42);
    double height = height1 / 4.5;
    double radius = getPercentSize(height, 35);

    double _crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);

    Tuple2<Color, Color> colorTuple = Tuple2(
        colorTuple1.item1.primaryColor!, colorTuple1.item1.primaryColor!);

    double space = 0.8;
    double verticalSpace = 0.6;

    return GetBuilder<NumberPyramidProvider>(
      init: NumberPyramidProvider(level: colorTuple1.item2),
      builder: (controller) {
      return DialogListener<NumberPyramidProvider>(
        colorTuple: colorTuple1,
        gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
        level: colorTuple1.item2,
        appBar: CommonAppBar<NumberPyramidProvider>(
            hint: false,
            infoView: CommonInfoTextView<NumberPyramidProvider>(
                gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
                folder: colorTuple1.item1.folderName!,
                color: colorTuple1.item1.cellColor!),
            gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
            colorTuple: colorTuple1,
            context: context),


        child: CommonMainWidget<NumberPyramidProvider>(
          gameCategoryType: GameCategoryType.NUMBER_PYRAMID,
          color: colorTuple1.item1.bgColor!,
          levelNo: colorTuple1.item2,
          provider: controller,
          primaryColor: colorTuple1.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 40)),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: getPercentSize(remainHeight, 6),
                  ),
                  Expanded(
                    flex: 1,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Center(
                        child: GetBuilder<NumberPyramidProvider>(
                            builder: (controller) {
                              print(
                                  "value---${controller.currentState.list[10]}");
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: PyramidNumberButton(
                                      numPyramidCellModel: controller
                                          .currentState.list[27],
                                      isLeftRadius: true,
                                      isRightRadius: true,
                                      height: constraints.maxWidth,
                                      buttonHeight: remainHeight,
                                      colorTuple: colorTuple,
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[26],
                                          isLeftRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[25],
                                          buttonHeight: remainHeight,
                                          isRightRadius: true,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[24],
                                          isLeftRadius: true,
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[23],
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                          buttonHeight: remainHeight,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[22],
                                          isRightRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[21],
                                          isLeftRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[20],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[19],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[18],
                                          isRightRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[17],
                                          isLeftRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[16],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[15],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[14],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[13],
                                          buttonHeight: remainHeight,
                                          isRightRadius: true,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[12],
                                          isLeftRadius: true,
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[11],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[10],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[9],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[8],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[7],
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                          isRightRadius: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: verticalSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[6],
                                          isLeftRadius: true,
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[5],
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[4],
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                          buttonHeight: remainHeight,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[3],
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                          buttonHeight: remainHeight,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[2],
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[1],
                                          height: constraints.maxWidth,
                                          buttonHeight: remainHeight,
                                          colorTuple: colorTuple,
                                        ),
                                        SizedBox(
                                          width: space,
                                        ),
                                        PyramidNumberButton(
                                          numPyramidCellModel: controller
                                              .currentState.list[0],
                                          isRightRadius: true,
                                          buttonHeight: remainHeight,
                                          height: constraints.maxWidth,
                                          colorTuple: colorTuple,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }),
                  ),
                  SizedBox(
                    height: getPercentSize(remainHeight, 2),
                  ),
                  Container(
                    height: height1,
                    decoration: getCommonDecoration(context),
                    alignment: Alignment.bottomCenter,
                    child: Builder(builder: (context) {
                      return Center(
                        child: GridView.count(
                          crossAxisCount: _crossAxisCount,
                          childAspectRatio: _aspectRatio,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            right: (margin * 2),
                            left: (margin * 2),
                          ),
                          crossAxisSpacing: _crossAxisSpacing,
                          mainAxisSpacing: _crossAxisSpacing,
                          primary: false,
                          children: List.generate(list.length, (index) {
                            String e = list[index];


                            if (e == "Done") {
                              return CommonClearButton(
                                  text: "Done",
                                  height: height,
                                  btnRadius: radius,
                                  onTab: () {
                                    controller
                                        .pyramidBoxInputValue(e);
                                  });
                            } else if (e == "Back") {
                              return CommonBackButton(
                                btnRadius: radius,
                                onTab: () {
                                  controller
                                      .pyramidBoxInputValue(e);
                                },
                                height: height,
                              );
                            } else {
                              return CommonNumberButton(
                                text: e,
                                totalHeight: remainHeight,
                                height: height,
                                btnRadius: radius,
                                onTab: () {
                                  controller
                                      .pyramidBoxInputValue(e);
                                },
                                colorTuple: colorTuple1,
                              );
                            }
                          }),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          context: context,
          isTopMargin: false,
        ),
      );
    },);
  }
}
