import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/data/RandomFindMissingData.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/common_wrong_answer_animation_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/correctAnswer/correct_answer_question_view.dart';
import 'package:mathspuzzle/ui/correctAnswer/correct_answer_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_neumorphic_view.dart';
import '../common/common_vertical_button.dart';

class CorrectAnswerView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  CorrectAnswerView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final RxBool isShuffle = true.obs;

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);


    return GetBuilder<CorrectAnswerProvider>(
      init: CorrectAnswerProvider(level: colorTuple.item2),
      builder: (controller) {
      return DialogListener<CorrectAnswerProvider>(
        gameCategoryType: GameCategoryType.CORRECT_ANSWER,
        level: colorTuple.item2,
        colorTuple: colorTuple,
        appBar: CommonAppBar<CorrectAnswerProvider>(
            infoView: CommonInfoTextView<CorrectAnswerProvider>(
                gameCategoryType: GameCategoryType.CORRECT_ANSWER,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.CORRECT_ANSWER,
            colorTuple: colorTuple,
            context: context),
        child: CommonMainWidget<CorrectAnswerProvider>(
          gameCategoryType: GameCategoryType.CORRECT_ANSWER,
          color: colorTuple.item1.bgColor!,
          provider: controller,
          levelNo: colorTuple.item2,
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
                              GetBuilder<CorrectAnswerProvider>(
                                builder: (controller) {
                                  return CorrectAnswerQuestionView(
                                    question: controller.currentState.question,
                                    questionView: Obx((){
                                      return CommonWrongAnswerAnimationView(
                                        currentScore: controller.currentScore.value.toInt(),
                                        oldScore: controller.oldScore.value.toInt(),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: getWidthPercentSize(
                                                  context, 2)),
                                          child: CommonNeumorphicView(
                                            isMargin: true,
                                            color: getBackGroundColor(context),
                                            width: getWidthPercentSize(
                                                context, 14),
                                            height: getWidthPercentSize(
                                                context, 14),
                                            child: Obx(() {
                                              return getTextWidget(
                                                  Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!,
                                                  controller.result.value == ""
                                                      ? "?"
                                                      :controller.result.value,
                                                  TextAlign.center,
                                                  getPercentSize(remainHeight, 4));
                                            }),

                                          ),
                                        ),
                                      );
                                    }),

                                  );
                                },),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {

                          final list = [
                            controller.currentState.firstAns,
                            controller.currentState.secondAns,
                            controller.currentState.thirdAns,
                            controller.currentState.fourthAns,
                          ];

                          if(isShuffle.value){
                            shuffle(list);
                            isShuffle.value = false;
                          }


                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getPercentSize(height1, 10)),
                            child: Column(
                              children:
                              List.generate(list.length, (index) {
                                String e = list[index];
                                return CommonVerticalButton(
                                    text: e,
                                    isNumber: true,
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
