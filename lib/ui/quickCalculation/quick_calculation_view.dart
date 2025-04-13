import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_back_button.dart';
import 'package:mathspuzzle/ui/common/common_clear_button.dart';
import 'package:mathspuzzle/ui/common/common_neumorphic_view.dart';
import 'package:mathspuzzle/ui/common/common_number_button.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/quickCalculation/quick_calculation_question_view.dart';
import 'package:mathspuzzle/ui/quickCalculation/quick_calculation_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../model/gradient_model.dart';

class QuickCalculationView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  QuickCalculationView({
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

  QuickCalculationProvider controller = Get.find<QuickCalculationProvider>();

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
    return GetBuilder<QuickCalculationProvider>(
      init: QuickCalculationProvider(
          level: colorTuple.item2,
          ),
      builder: (controller) => DialogListener<QuickCalculationProvider>(
      colorTuple: colorTuple,
      appBar: CommonAppBar<QuickCalculationProvider>(
          infoView: CommonInfoTextView<QuickCalculationProvider>(
              gameCategoryType: GameCategoryType.QUICK_CALCULATION,
              folder: colorTuple.item1.folderName!,
              color: colorTuple.item1.cellColor!),
          gameCategoryType: GameCategoryType.QUICK_CALCULATION,
          colorTuple: colorTuple,
          context: context),
      gameCategoryType: GameCategoryType.QUICK_CALCULATION,
      level: colorTuple.item2,

      child: CommonMainWidget<QuickCalculationProvider>(
        gameCategoryType: GameCategoryType.QUICK_CALCULATION,
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
                        margin: EdgeInsets.symmetric(
                            horizontal: (getHorizontalSpace(context) * 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0,
                              child: getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: Colors.grey),
                                  "NEXT",
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 1.8)),
                            ),


                            Stack(
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: GetBuilder<QuickCalculationProvider>(
                                        init: controller,
                                        builder: (controller) {
                                          return QuickCalculationQuestionView(
                                            currentState: controller.currentState,
                                            nextCurrentState: controller.nextCurrentState,
                                            previousCurrentState: controller.nextCurrentState,
                                          );
                                        },
                                      ),

                                    ),
                                    getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        " = ",
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4)),

                                    SizedBox(width: getWidthPercentSize(context,3),),

                                    Obx(() {
                                      return CommonWrongAnswerAnimationView(
                                        currentScore: controller.currentScore.value.toInt(),
                                        oldScore: controller.oldScore.value.toInt(),
                                        child: CommonNeumorphicView(
                                          isMargin: true,
                                          color: getBackGroundColor(context),

                                          height: getPercentSize(mainHeight, 22),
                                          width: getPercentSize(mainHeight, 22),
                                          child: Obx(() {
                                            return getTextWidget(
                                                Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                ,
                                                controller.result.value.length > 0
                                                    ? controller.result.value
                                                    : "?",
                                                TextAlign.center,
                                                getPercentSize(
                                                    remainHeight, 4));
                                          }),

                                        ),
                                      );
                                    }),


                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                    controller
                                        .clearResult();
                                  });
                            } else if (e == "Back") {
                              return CommonBackButton(
                                onTab: () {
                                  controller
                                      .backPress();
                                },
                                height: height,
                              );
                            } else {
                              return CommonNumberButton(
                                text: e,
                                totalHeight: remainHeight,
                                height: height,
                                onTab: () {
                                  controller
                                      .checkResult(e);
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
