import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/dualGame/dual_game_provider.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import 'dart:math' as math;
import '../../utility/Constants.dart';
import '../common/common_dual_button.dart';

class DualView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  DualView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 2;
    double height = getPercentSize(remainHeight, 45) / 3;

    double _crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;

    return GetBuilder<DualGameProvider>(
      init: DualGameProvider(
          level: colorTuple.item2,),
      builder: (controller) => DialogListener<DualGameProvider>(
      colorTuple: colorTuple,
      gameCategoryType: GameCategoryType.DUAL_GAME,
      level: colorTuple.item2,
      appBar: CommonAppBar<DualGameProvider>(
          hint: false,
          infoView: CommonInfoTextView<DualGameProvider>(
              gameCategoryType: GameCategoryType.DUAL_GAME,
              folder: colorTuple.item1.folderName!,
              color: colorTuple.item1.cellColor!),
          gameCategoryType: GameCategoryType.DUAL_GAME,
          colorTuple: colorTuple, context: context),
      child: getCommonWidget(
          context: context,
          bgColor:colorTuple.item1.bgColor,
          isTopMargin: false,
          child:Column(
            children: [
              Expanded(child: Transform.rotate(
                angle: math.pi,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            GetBuilder<DualGameProvider>(
                              init: controller,
                              builder: (controller) {
                                return getTextWidget(
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .titleSmall!,
                                    controller.currentState
                                        .question!,
                                    TextAlign.center,
                                    getPercentSize(
                                        remainHeight, 4));
                              },)

                          ],
                        ),
                      ),
                      flex: 1,
                    ),

                    GetBuilder<DualGameProvider>(
                      init: controller,
                      builder: (controller) {
                      final list=controller.currentState.optionList;
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

                        children: List.generate(list.length, (index) {
                          String e = list[index];
                          return CommonDualButton(
                            is4Matrix: true,
                            text: e,
                            totalHeight: remainHeight,
                            height: height,
                            onTab: () {
                              controller.checkResult1(e);
                              print(("score1====${controller.score1}"));
                            },
                            colorTuple: colorTuple,
                          );
                        }),
                      );
                    },)

                  ],
                ),
              ),flex: 1,),


              Container(
                height: 1,
                color: colorTuple.item1.primaryColor,
              ),
              Expanded(child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<DualGameProvider>(
                            init: controller,builder: (controller) => getTextWidget(
                              Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall!,
                              controller.currentState
                                  .question!,
                              TextAlign.center,
                              getPercentSize(
                                  remainHeight, 4)),)
                        ],
                      ),
                    ),
                    flex: 1,
                  ),

                  GetBuilder<DualGameProvider>(
                    init: controller,builder: (controller) {
                    final list=controller.currentState.optionList;
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
                      children: List.generate(list.length, (index) {
                        String e = list[index];
                        return CommonDualButton(
                          is4Matrix: true,
                          text: e,
                          totalHeight: remainHeight,
                          height: height,
                          onTab: () {
                            controller.checkResult2(e);
                            print(("score2====${controller.score2}"));
                          },
                          colorTuple: colorTuple,
                        );
                      }),
                    );
                    },)

                ],
              ),flex: 1,),
            ],
          ),
          subChild: Container(
          )),
    ),);
  }
}
