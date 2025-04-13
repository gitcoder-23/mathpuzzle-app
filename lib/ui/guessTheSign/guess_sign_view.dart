
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/common_neumorphic_view.dart';
import 'package:mathspuzzle/ui/common/common_vertical_button.dart';
import 'package:mathspuzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/guessTheSign/guess_sign_provider.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

class GuessSignView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  GuessSignView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List<String> list = [
    "/",
    "*",
    "+",
    "-",
  ];
  final RxBool isShuffle = true.obs;

  RxString question = "".obs;
  RxString oldQuestion = "".obs;

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);

    print("value===1");
    return GetBuilder<GuessSignProvider>(
      init: GuessSignProvider(level: colorTuple.item2),
      builder: (controller) {
        print("change=====question");
      return DialogListener<GuessSignProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.GUESS_SIGN,
        level: colorTuple.item2,
        appBar: CommonAppBar<GuessSignProvider>(
            infoView: CommonInfoTextView<GuessSignProvider>(
                gameCategoryType: GameCategoryType.GUESS_SIGN,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.GUESS_SIGN,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<GuessSignProvider>(
          gameCategoryType: GameCategoryType.GUESS_SIGN,
          color: colorTuple.item1.bgColor!,
          levelNo: colorTuple.item2,
          provider: controller,
          primaryColor: colorTuple.item1.primaryColor!,
          subChild: Container(
            margin: EdgeInsets.only(top: getPercentSize(mainHeight, 50)),
            child: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GetBuilder<GuessSignProvider>(
                                init: controller,
                                builder: (controller){

                                  return getTextWidget(
                                      Theme.of(context).textTheme.titleSmall!,
                                      controller.currentState.firstDigit,
                                      TextAlign.center,
                                      getPercentSize(remainHeight, 4));
                                },),

                              SizedBox(width: getWidthPercentSize(context, 2)),
                              Obx(() {
                                return CommonWrongAnswerAnimationView(
                                  currentScore: controller.currentScore.value.toInt(),
                                  oldScore: controller.oldScore.value.toInt(),
                                  child: CommonNeumorphicView(
                                    color: getBackGroundColor(context),
                                    isMargin: true,
                                    width: getWidthPercentSize(context, 15),
                                    height: getWidthPercentSize(context, 15),
                                    child: Obx(() {
                                      return getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!,
                                          (controller.result.value.length > 0) ? controller.result.value : "?",
                                          TextAlign.center,
                                          getPercentSize(remainHeight, 4));
                                    }),

                                  ),
                                );
                              }),

                              SizedBox(width: getWidthPercentSize(context, 2)),
                              GetBuilder<GuessSignProvider>(
                                  init: controller,
                                  builder: (controller) {
                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        controller.currentState.secondDigit,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),

                              SizedBox(width: getWidthPercentSize(context, 2)),
                              getTextWidget(
                                  Theme.of(context).textTheme.titleSmall!,
                                  '=',
                                  TextAlign.center,
                                  getPercentSize(remainHeight, 4)),
                              SizedBox(width: getWidthPercentSize(context, 2)),
                              GetBuilder<GuessSignProvider>(
                                  init: controller,
                                  builder: (controller) {
                                    print("valueG===true");

                                    return getTextWidget(
                                        Theme.of(context).textTheme.titleSmall!,
                                        controller.currentState.answer,
                                        TextAlign.center,
                                        getPercentSize(remainHeight, 4));
                                  }),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {

                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getPercentSize(height1, 10)),
                            child: Column(
                              children:
                              List.generate(list.length, (index) {
                                String e = list[index];
                                return CommonVerticalButton(
                                    text: e,
                                    onTab: () {
                                      controller
                                          .checkResult(e);
                                    },
                                    colorTuple: colorTuple);
                              }),
                            ),
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

      );
    },);
  }
}
