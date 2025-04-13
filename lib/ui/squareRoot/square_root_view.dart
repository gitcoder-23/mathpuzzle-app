import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_assets.dart';
import 'package:mathspuzzle/data/RandomFindMissingData.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/squareRoot/square_root_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_vertical_button.dart';

class SquareRootView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

  SquareRootView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  final RxBool isShuffle = true.obs;

  @override
  Widget build(BuildContext context) {
    double remainHeight = getRemainHeight(context: context);
    double height1 = getScreenPercentSize(context, 54);
    double mainHeight = getMainHeight(context);
    return GetBuilder<SquareRootProvider>(
      init: SquareRootProvider(
          level: colorTuple.item2,
          ),
      builder: (controller) => DialogListener<SquareRootProvider>(
      colorTuple: colorTuple,

      appBar: CommonAppBar<SquareRootProvider>(
          infoView: CommonInfoTextView<SquareRootProvider>(
              gameCategoryType: GameCategoryType.SQUARE_ROOT,
              folder: colorTuple.item1.folderName!,
              color: colorTuple.item1.cellColor!),
          gameCategoryType: GameCategoryType.SQUARE_ROOT,
          colorTuple: colorTuple,
          context: context),

      gameCategoryType: GameCategoryType.SQUARE_ROOT,
      level: colorTuple.item2,

      child: CommonMainWidget<SquareRootProvider>(
        gameCategoryType: GameCategoryType.SQUARE_ROOT,
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
                            SvgPicture.asset(
                              AppAssets.icRoot,
                              height: getPercentSize(remainHeight, 6),
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color,
                            ),

                            GetBuilder<SquareRootProvider>(
                                init: controller,
                                builder:
                                    (controller) {
                                  return getTextWidget(
                                      Theme.of(context).textTheme.titleSmall!,
                                      controller.currentState.question,
                                      TextAlign.center,
                                      getPercentSize(remainHeight, 4));
                                })

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

    ),);
  }
}
