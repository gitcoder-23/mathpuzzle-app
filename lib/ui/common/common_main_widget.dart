import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/color_scheme.dart';
import 'package:mathspuzzle/ui/app/time_provider.dart';
import 'package:mathspuzzle/ui/resizer/fetch_pixels.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/app_assets.dart';
import '../../core/app_constant.dart';
import '../../utility/Constants.dart';
import '../app/game_provider.dart';
import '../dashboard/dashboard_provider.dart';

class CommonMainWidget<T extends GameProvider> extends StatelessWidget {
  final BuildContext? context;
  final GameCategoryType? gameCategoryType;
  final bool? isTopMargin;
  final Widget? subChild;
  final Color? color;
  final bool? isTimer;
  final int? levelNo;
  final GameProvider provider;

  final Color? primaryColor;

  CommonMainWidget({
    required this.context,
    required this.subChild,
    this.isTimer,
    required this.color,
    required this.primaryColor,
    required this.gameCategoryType,
    required this.levelNo,
    this.isTopMargin,
    required this.provider,
  });

  DashboardProvider dashboardProvider = Get.find<DashboardProvider>();
  

  @override
  Widget build(BuildContext context) {
    // final model = Get.find<GameProvider>();
    // final model = Provider.of<T>(context);



    double appBarHeight = getScreenPercentSize(context, 25);
    double mainHeight = getMainHeight(context);
    var circle = getScreenPercentSize(context, 12);
    var margin = getHorizontalSpace(context);
    var stepSize = getScreenPercentSize(context, 1.3);

    // print("type===${KeyUtil.getTimeUtil(gameCategoryType!)}");

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Stack(
              children: [
                Visibility(
                  visible: isTimer == null,
                  child: SizedBox(
                    height: mainHeight,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      primary: false,
                      appBar: AppBar(
                        bottomOpacity: 0.0,
                        title: const Text(''),
                        toolbarHeight: 0,
                        elevation: 0,
                      ),
                      floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: SizedBox(
                        width: (circle),
                        height: (circle),
                        child: Stack(
                          children: [
                            Container(



                              child: Obx(() {
                                // TimeProvider timeProvider = Get.put(TimeProvider(totalTime: KeyUtil.getTimeUtil(gameCategoryType!),));
                                print("currentTime==${provider.currentTime.value}-----${KeyUtil.getTimeUtil(gameCategoryType!)}");
                                return CircularStepProgressIndicator(
                                  totalSteps:
                                  KeyUtil.getTimeUtil(gameCategoryType!),
                                  currentStep: provider.currentTime.value.toInt(),
                                  stepSize: stepSize,
                                  selectedColor: primaryColor,
                                  unselectedColor: Theme.of(context)
                                      .colorScheme
                                      .unSelectedProgressColor,
                                  padding: 0,
                                  width: circle,
                                  height: circle,
                                  selectedStepSize: stepSize,
                                  roundedCap: (_, __) => true,
                                );
                              }),

                              // decoration:
                              // BoxDecoration(color: transpar, shape: BoxShape.circle),
                            ),
                            Center(
                              child: Obx(() => getTextWidget(
                                  Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  secToTime(provider.currentTime.value),
                                  TextAlign.center,
                                  getPercentSize(circle, 18))),
                            )
                          ],
                        ),
                      ),
                      bottomNavigationBar: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                getScreenPercentSize(context, 4)),
                            topRight: Radius.circular(
                                getScreenPercentSize(context, 4))),
                        child: Container(
                          height: (appBarHeight),
                          child: BottomAppBar(
                            color: color,
                            elevation: 0,
                            shape: CircularNotchedRectangle(),
                            notchMargin: (10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Expanded(
                                  child: SizedBox(width: 0),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: isTimer != null,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin:
                    EdgeInsets.only(top: getPercentSize(mainHeight, 25)),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(getScreenPercentSize(context, 4)),
                          topRight: Radius.circular(
                              getScreenPercentSize(context, 4))),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: getPercentSize(mainHeight, 35)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin),
                        child: Stack(
                          children: [
                            Opacity(
                              opacity: 1,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: getTextWidget(
                                    Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.w500),
                                    // 'Level : 100',
                                    'Level : ${levelNo}',
                                    TextAlign.center,
                                    getPercentSize(mainHeight, 7)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      getTextWidget(
                                          Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                              fontWeight: FontWeight.bold),
                                          'Total Coin :',
                                          TextAlign.center,
                                          getPercentSize(mainHeight, 5)),
                                      SizedBox(
                                        width:
                                        getWidthPercentSize(context, 1.2),
                                      ),
                                      
                                      Obx(() {

                                        print("overAllScore-------${dashboardProvider.overallScore.value}");
                                        return getTextWidget(
                                            Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.w600),
                                            dashboardProvider.overallScore.value.toString(),
                                            TextAlign.center,
                                            getPercentSize(mainHeight, 5));
                                      })

                                      // GetBuilder<DashboardProvider>(
                                      //   init: DashboardProvider(),
                                      //   builder: (controller) {
                                      //     return ;
                                      //   },)

                                      // Consumer<DashboardProvider>(
                                      //   builder: (context, model, child) {
                                      //
                                      //     // print("model===${model.overallScore}");
                                      //
                                      //     return getTextWidget(
                                      //         Theme.of(context)
                                      //             .textTheme
                                      //             .titleSmall!
                                      //             .copyWith(
                                      //             fontWeight:
                                      //             FontWeight.w600),
                                      //         model.overallScore.value.toString(),
                                      //         TextAlign.center,
                                      //         getPercentSize(mainHeight, 5));
                                      //   }
                                      //       ,
                                      // ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: getPercentSize(mainHeight, 3.5),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icTrophy,
                                        height: getPercentSize(mainHeight, 6),
                                        width: getPercentSize(mainHeight, 6),
                                      ),
                                      SizedBox(
                                        width:
                                        getWidthPercentSize(context, 1.2),
                                      ),

                                      Obx(() {
                                        RxInt currentScore =
                                            provider!.currentScore.value.toInt().obs;

                                        print("currentScore------4{${currentScore.value}");
                                        return getTextWidget(
                                            Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.w600),
                                            currentScore.value.toString(),
                                            TextAlign.center,
                                            getPercentSize(mainHeight, 5));
                                      })


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: FetchPixels.getPixelHeight(50)),
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: color,
                              // color: color,
                            ),
                          ))
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        subChild!,
      ],
    );
  }
}
