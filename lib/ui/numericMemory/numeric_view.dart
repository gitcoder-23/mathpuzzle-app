import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/numericMemory/numeric_button.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import 'numeric_provider.dart';

class NumericMemoryView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const NumericMemoryView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = true;

    bool isContinue = false;
    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;
    double height1 = getScreenPercentSize(context, Platform.isIOS?54:57);
    double height = getPercentSize(remainHeight, 70) / 5;

    double _crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    double mainHeight = getMainHeight(context);

    return StatefulBuilder(builder: (context, snapshot) {
      if (isFirstTime) {
        Future.delayed(
          Duration(seconds: 2),
          () {
            snapshot(() {
              isContinue = true;
              isFirstTime = false;
            });
          },
        );
      }
      print("hello===true");
      return GetBuilder<NumericMemoryProvider>(
        init: NumericMemoryProvider(
            level: colorTuple.item2,
            isTimer: false,
            nextQuiz: () {
              snapshot(() {
                isContinue = false;
              });
              print("isContinue====$isContinue");
              Future.delayed(
                Duration(seconds: 2),
                    () {
                  snapshot(() {
                    isContinue = true;
                  });
                },
              );


            },),
        builder: (controller) {
        return DialogListener<NumericMemoryProvider>(
          colorTuple: colorTuple,
          gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
          level: colorTuple.item2,
          nextQuiz: (){

          },

          appBar: CommonAppBar<NumericMemoryProvider>(

              hint: false,
              infoView: CommonInfoTextView<NumericMemoryProvider>(
                  gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
                  folder: colorTuple.item1.folderName!,
                  color: colorTuple.item1.cellColor!),
              gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
              colorTuple: colorTuple,
              context: context,
              isTimer: false),

          child: CommonMainWidget<NumericMemoryProvider>(
            gameCategoryType: GameCategoryType.NUMERIC_MEMORY,
            color: colorTuple.item1.bgColor!,
            levelNo: colorTuple.item2,
            provider: controller,
            isTimer: false,
            primaryColor: colorTuple.item1.primaryColor!,
            subChild: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 55)),
                  child: Container(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                margin: EdgeInsets.only(
                                    bottom: getPercentSize(mainHeight, 10)),


                                child: GetBuilder<NumericMemoryProvider>(
                                    init: controller,
                                    builder: (controller) {
                                      return Center(
                                        child: getTextWidget(
                                            Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                fontWeight: FontWeight.bold),
                                            controller.currentState.question.toString(),
                                            TextAlign.center,
                                            getPercentSize(remainHeight, 5)),
                                      );
                                    }),
                              ),
                            ),
                            Container(
                              height: height1,
                              decoration: getCommonDecoration(context),
                              alignment: Alignment.bottomCenter,
                              child: GetBuilder<NumericMemoryProvider>(
                                  builder: (controller) {
                                    return GridView.count(
                                      crossAxisCount: _crossAxisCount,
                                      childAspectRatio: _aspectRatio,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getHorizontalSpace(context),
                                          vertical: getHorizontalSpace(context)),
                                      crossAxisSpacing: _crossAxisSpacing,
                                      mainAxisSpacing: _crossAxisSpacing,
                                      primary: false,
                                      children: List.generate(
                                          controller.currentState.list.length, (index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: getHorizontalSpace(context)/1.5,
                                              vertical: getHorizontalSpace(context)/1.5),
                                          child: NumericMemoryButton(
                                            height: height,
                                            mathPairs: controller.currentState,
                                            index: index,
                                            function: () {
                                              if (controller.currentState.list[index].key ==
                                                  controller.currentState.answer) {
                                                controller.currentState.list[index]
                                                    .isCheck = true;
                                              } else {
                                                controller.currentState.list[index]
                                                    .isCheck = false;
                                              }
                                              setState(() {
                                                isContinue = false;
                                              });
                                              controller
                                                  .checkResult(
                                                  controller
                                                      .currentState.list[index].key!,
                                                  index);
                                            },
                                            isContinue: isContinue,
                                            colorTuple: Tuple2(
                                                colorTuple.item1.primaryColor!,
                                                colorTuple.item1.backgroundColor!),
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            context: context,
            isTopMargin: false,
          ),
        );
      },);
    });
  }
}
