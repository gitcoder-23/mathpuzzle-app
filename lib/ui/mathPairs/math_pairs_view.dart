import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/mathPairs/math_pairs_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/mathPairs/math_pairs_button.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

class MathPairsView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  const MathPairsView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double mainHeight = getMainHeight(context);

    int _crossAxisCount = 3;
    double height = getPercentSize(remainHeight, Platform.isIOS?65:75) / 5;

    double _crossAxisSpacing = getPercentSize(height, 14);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    return GetBuilder<MathPairsProvider>(
      init: MathPairsProvider(level: colorTuple.item2),builder: (controller) {
      return DialogListener<MathPairsProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.MATH_PAIRS,
        level: colorTuple.item2,
        appBar: CommonAppBar<MathPairsProvider>(
            hint: false,
            infoView: CommonInfoTextView<MathPairsProvider>(
                gameCategoryType: GameCategoryType.MATH_PAIRS,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.MATH_PAIRS,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<MathPairsProvider>(
          gameCategoryType: GameCategoryType.MATH_PAIRS,
          color: colorTuple.item1.bgColor!,
          levelNo: colorTuple.item2,
          provider: controller,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 80)),
            child: Container(
              decoration: getCommonDecoration(context),
              child: Center(
                child: GetBuilder<MathPairsProvider>(
                  init: controller,
                    builder: (controller) {
                      return GridView.count(
                        crossAxisCount: _crossAxisCount,
                        childAspectRatio: _aspectRatio,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalSpace(context),
                            vertical: (getHorizontalSpace(context) * 2.5)),
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _crossAxisSpacing,
                        primary: false,
                        children: List.generate(
                            controller.currentState.list.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: getHorizontalSpace(context) / 1.5,
                                vertical: getHorizontalSpace(context) / 1.3),
                            child: MathPairsButton(
                              height: height,
                              mathPairs: controller.currentState.list[index],
                              index: index,
                              colorTuple: Tuple2(colorTuple.item1.primaryColor!,
                                  colorTuple.item1.backgroundColor!),
                            ),
                          );
                        }),
                      );
                    }),
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
