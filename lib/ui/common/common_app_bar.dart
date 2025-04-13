import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_assets.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:tuple/tuple.dart';

import '../../utility/dialog_info_util.dart';
import '../model/gradient_model.dart';
import 'common_linear_percent_indicator3.dart';

class CommonAppBar<T extends GameProvider> extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;
  final BuildContext? context;
  final bool? isTimer;
  final bool? hint;
  final GameCategoryType? gameCategoryType;
  final Widget? infoView;

  const CommonAppBar({
    Key? key,
    required this.colorTuple,
    this.hint,
    required this.context,
    this.isTimer,
    required this.infoView,
    // required this.function,
    required this.gameCategoryType,
  }) : super(key: key);

  GameProvider get provider => Get.find<T>();

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 7.5);
    return Container(
      child: Column(
        children: [
          Container(
            height: height,
            padding: EdgeInsets.symmetric(
              horizontal: getHorizontalSpace(context),
            ),
            child: Row(
              children: [
                getDefaultIconWidget(context,
                    icon: AppAssets.backIcon,
                    folder: colorTuple.item1.folderName, function: () {
                      provider.showExitDialog();
                    }),
                // Obx(() {
                //   return ;
                // }),

                Expanded(
                  flex: 1,

                  child: Center(
                      child: getTextWidget(
                          Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                          DialogInfoUtil.getInfoDialogData(gameCategoryType!)
                              .title,
                          TextAlign.center,
                          getPercentSize(height, 35))),

                ),


                hint == null
                    ? GetBuilder<T>(builder: (controller) {
                  return getHintIcon(
                      function: () {
                        controller.showHintDialog();
                        // provider.showHintDialog();
                      },
                      color: colorTuple.item1.primaryColor);
                })
                    : Container(),

                SizedBox(
                  width: getWidthPercentSize(context, 2),
                ),



                infoView!,
                isTimer == null
                    ? GetBuilder<T>(builder: (controller) {
                        return controller.timerStatus == TimerStatus.pause
                            ? getDefaultIconWidget(context,
                                folder: colorTuple.item1.folderName,
                                changeFolderName: false,
                                icon: AppAssets.playIcon, function: () {
                              controller.pauseResumeGame();
                              })
                            : getDefaultIconWidget(context,
                                folder: colorTuple.item1.folderName,
                                icon: AppAssets.pauseIcon, function: () {
                              controller.pauseResumeGame();
                              });
                      })
                    : Container(),
              ],
            ),
          ),
          isTimer == null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: CommonLinearPercentIndicator<T>(
                    lineHeight: getScreenPercentSize(context, 0.3),
                    backgroundColor: Color(0xffeeeeee),
                    linearGradient: LinearGradient(
                      colors: [
                        colorTuple.item1.primaryColor!,
                        colorTuple.item1.primaryColor!,
                      ],
                    ),
                  ),
                )
              : Container(
                  height: getScreenPercentSize(context, 0.3),
                  width: double.infinity,
                  color: colorTuple.item1.primaryColor!,
                )
        ],
      ),
    );
  }
}
