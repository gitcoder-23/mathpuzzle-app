import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/ComplexModel.dart';

import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/complexCalculation/complex_calculation_provider.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class ComplexCalculationView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  ComplexCalculationView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final List<String> list = [
    "/",
    "*",
    "+",
    "-",
  ];


  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);
    return GetBuilder<ComplexCalculationProvider>(
      init: ComplexCalculationProvider(level: colorTuple.item2),
      builder: (controller) {
      return DialogListener<ComplexCalculationProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
        level: colorTuple.item2,
        appBar: CommonAppBar<ComplexCalculationProvider>(
            infoView: CommonInfoTextView<ComplexCalculationProvider>(
                gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
            // function: (){
            //   calculatorProvider.showExitDialog();
            // },
            colorTuple: colorTuple, context: context),
        child: CommonMainWidget<ComplexCalculationProvider>(
          gameCategoryType: GameCategoryType.COMPLEX_CALCULATION,
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
                          child: Center(
                            child: GetBuilder<ComplexCalculationProvider>(
                                init: controller,
                                builder: (controller) {
                                  return getTextWidget(
                                      Theme.of(context).textTheme.titleSmall!,
                                      controller.currentState.question!,
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
                          child: Builder(builder: (context) {
                            return GetBuilder<ComplexCalculationProvider>(
                                init: controller,
                                builder: (controller) {
                                  print("valueG===true");

                                  final list = controller.currentState.optionList;

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
                                              // context
                                              //     .read<ComplexCalculationProvider>()
                                              //     .checkResult(e);
                                            },
                                            colorTuple: colorTuple);
                                      }),
                                    ),
                                  );
                                });
                          })
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
