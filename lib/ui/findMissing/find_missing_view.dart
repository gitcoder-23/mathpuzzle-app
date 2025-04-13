import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/findMissing/find_missing_provider.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class FindMissingView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  FindMissingView({
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

    return GetBuilder<FindMissingProvider>(
      init: FindMissingProvider(level: colorTuple.item2),
      builder: (controller) {
      return DialogListener<FindMissingProvider>(
        colorTuple: colorTuple,
        gameCategoryType: GameCategoryType.FIND_MISSING,
        level: colorTuple.item2,
        appBar: CommonAppBar<FindMissingProvider>(
            infoView: CommonInfoTextView<FindMissingProvider>(
                gameCategoryType: GameCategoryType.FIND_MISSING,
                folder: colorTuple.item1.folderName!,
                color: colorTuple.item1.cellColor!),
            gameCategoryType: GameCategoryType.FIND_MISSING,
            colorTuple: colorTuple,
            context: context),

        child: CommonMainWidget<FindMissingProvider>(
          gameCategoryType: GameCategoryType.FIND_MISSING,
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
                          child: Center(
                            child: GetBuilder<FindMissingProvider>(
                                init: controller,builder: (controller) => getTextWidget(
                                Theme.of(context).textTheme.titleSmall!,
                              controller.currentState.question!,
                              TextAlign.center,
                              getPercentSize(remainHeight, 4)),),

                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child: Builder(builder: (context) {

                          return GetBuilder<FindMissingProvider>(
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
                                          },
                                          colorTuple: colorTuple);
                                    }),
                                  ),
                                );
                              });

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
