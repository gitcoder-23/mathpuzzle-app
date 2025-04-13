import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/calculator/calculator_provider.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_back_button.dart';
import 'package:mathspuzzle/ui/common/common_clear_button.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/common_main_widget.dart';
import 'package:mathspuzzle/ui/common/common_neumorphic_view.dart';
import 'package:mathspuzzle/ui/common/common_number_button.dart';
import 'package:mathspuzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';

class CalculatorView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  CalculatorView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Clear",
    "0",
    "Back"
  ];


  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;

    double height1 = getScreenPercentSize(context, Platform.isIOS?50:57);
    double height = getScreenPercentSize(context, Platform.isIOS?50:57) / 5.3;

    double _crossAxisSpacing = getPercentSize(height, 30);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);

    return GetBuilder<CalculatorProvider>(
      init: CalculatorProvider(level: colorTuple.item2),
      builder: (controller) {

        print("levelNo----------${colorTuple.item2}");
      return DialogListener<CalculatorProvider>(
        gameCategoryType: GameCategoryType.CALCULATOR,
        colorTuple: colorTuple,
        level: colorTuple.item2,
        // appBar: AppBar(),
        appBar: CommonAppBar<CalculatorProvider>(
            infoView: CommonInfoTextView<CalculatorProvider>(
                gameCategoryType: GameCategoryType.CALCULATOR,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.CALCULATOR,
            // function: (){
            //   calculatorProvider.showExitDialog();
            // },
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<CalculatorProvider>(
          gameCategoryType: GameCategoryType.CALCULATOR,
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
                              top: getPercentSize(mainHeight, 3)),
                          child: GetBuilder<CalculatorProvider>(
                              init: controller,
                              builder: (controller) {
                                return getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    controller.currentState.question,
                                    TextAlign.center,
                                    getPercentSize(remainHeight, 4));
                              }),
                        ),
                      ),
                      Container(
                        height: height1,


                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {
                          return GridView.count(
                            crossAxisCount: _crossAxisCount,
                            childAspectRatio: _aspectRatio,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              right: (margin * 2),
                              left: (margin * 2),
                              bottom: getHorizontalSpace(context),
                            ),
                            crossAxisSpacing: _crossAxisSpacing,
                            mainAxisSpacing: _crossAxisSpacing,
                            primary: false,
                            // padding: EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                            children: List.generate(list.length, (index) {
                              String e = list[index];
                              if (e == "Clear") {
                                return CommonClearButton(
                                    text: "Clear",
                                    height: height,
                                    onTab: () {
                                      controller.clearResult();
                                      // context
                                      //     .read<CalculatorProvider>()
                                      //     .clearResult();
                                    });
                              } else if (e == "Back") {
                                return CommonBackButton(
                                  onTab: () {

                                    controller
                                        .backPress();
                                    // context
                                    //     .read<CalculatorProvider>()
                                    //     .backPress();
                                  },
                                  height: height,
                                );
                              } else {
                                return CommonNumberButton(
                                  text: e,
                                  totalHeight: remainHeight,
                                  height: height,
                                  onTab: () {
                                    controller.checkResult(e);
                                    // context.read<CalculatorProvider>().checkResult(e);
                                  },
                                  colorTuple: colorTuple,
                                );
                              }
                            }),
                          );
                        }),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: getPercentSize(height1, 17)),
                    child: Obx(() {
                      return CommonWrongAnswerAnimationView(
                        currentScore: controller.currentScore.value.toInt(),
                        oldScore: controller.oldScore.value.toInt(),
                        child: CommonNeumorphicView(
                          isLarge: true,
                          isMargin: false,
                          height: getPercentSize(height1, 12),
                          color: getBackGroundColor(context),

                          child: Obx((){
                            return getTextWidget(
                                Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                                controller.result.value.length > 0 ? controller.result.value : '?',
                                TextAlign.center,
                                getPercentSize(height1, 7));
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
