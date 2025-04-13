import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/magicTriangle/triangle_3x3.dart';
import 'package:mathspuzzle/ui/magicTriangle/triangle_4x4.dart';
import 'package:mathspuzzle/ui/magicTriangle/triangle_input_3x3.dart';
import 'package:mathspuzzle/ui/magicTriangle/triangle_input_4x4.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';

class MagicTriangleView extends StatelessWidget {
  final double padding = 0;
  final double  radius = 30;
  final Tuple2<GradientModel, int> colorTuple1;

  const MagicTriangleView({
    Key? key,
    required this.colorTuple1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple2<Color, Color> colorTuple = Tuple2(colorTuple1.item1.primaryColor!, colorTuple1.item1.cellColor!);
    double mainHeight = getMainHeight(context);


    double height1 = getScreenPercentSize(context, Platform.isIOS?55:58);



    return GetBuilder<MagicTriangleProvider>(
      init: MagicTriangleProvider(level: colorTuple1.item2),
      builder: (controller) {
      return DialogListener<MagicTriangleProvider>(
        colorTuple:  colorTuple1,
        gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        level: colorTuple1.item2,
        appBar: CommonAppBar<MagicTriangleProvider>(
            hint: false,
            infoView: CommonInfoTextView<MagicTriangleProvider>(
                gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
                folder: colorTuple1.item1.folderName!,
                color: colorTuple1.item1.cellColor!),

            gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,colorTuple: colorTuple1,context: context),

        child: CommonMainWidget<MagicTriangleProvider>(
          gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
          color: colorTuple1.item1.bgColor!,
          levelNo: colorTuple1.item2,
          primaryColor: colorTuple1.item1.primaryColor!,
          provider: controller,
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
                          margin: EdgeInsets.only(bottom: getPercentSize(mainHeight, 9)),
                          child: Center(
                            child: GetBuilder<MagicTriangleProvider>(
                                init: controller,
                                builder: (controller) {
                                  return getTextWidget(
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall!.copyWith(fontWeight: FontWeight.bold),
                                      controller.currentState.answer.toString(),
                                      TextAlign.center,
                                      getPercentSize(
                                          mainHeight, 10));
                                }),

                          ),
                        ),
                      ),
                      Container(
                        height: height1,
                        decoration: getCommonDecoration(context),
                        alignment: Alignment.bottomCenter,
                        child:
                        Column(
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    print(
                                        "size---${constraints.maxWidth}----${constraints.maxWidth}");
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[

                                        GetBuilder<MagicTriangleProvider>(
                                            init: controller,
                                            builder: (controller) {
                                              return controller.currentState.is3x3
                                                  ? Triangle3x3(
                                                radius: radius,
                                                padding: padding,
                                                triangleHeight:
                                                getScreenPercentSize(context, 58),
                                                // constraints.maxWidth,
                                                triangleWidth:
                                                constraints.maxWidth,
                                                colorTuple: colorTuple,
                                              )
                                                  : Triangle4x4(
                                                radius: radius,
                                                padding: padding,
                                                triangleHeight:
                                                constraints.maxWidth,
                                                triangleWidth:
                                                constraints.maxWidth,
                                                colorTuple: colorTuple,
                                              );
                                            }),
                                        // Selector<MagicTriangleProvider, bool>(
                                        //     selector: (p0, p1) =>
                                        //     p1.currentState.is3x3,
                                        //     builder: (context, is3x3, child) {
                                        //       return is3x3
                                        //           ? Triangle3x3(
                                        //         radius: radius,
                                        //         padding: padding,
                                        //         triangleHeight:
                                        //         getScreenPercentSize(context, 58),
                                        //         // constraints.maxWidth,
                                        //         triangleWidth:
                                        //         constraints.maxWidth,
                                        //         colorTuple: colorTuple,
                                        //       )
                                        //           : Triangle4x4(
                                        //         radius: radius,
                                        //         padding: padding,
                                        //         triangleHeight:
                                        //         constraints.maxWidth,
                                        //         triangleWidth:
                                        //         constraints.maxWidth,
                                        //         colorTuple: colorTuple,
                                        //       );
                                        //     }),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: getPercentSize(height1, 3),
                            ),
                            GetBuilder<MagicTriangleProvider>(
                              init: controller,
                                builder: (controller) {
                                  return controller.currentState.is3x3
                                      ? TriangleInput3x3(colorTuple: colorTuple)
                                      : TriangleInput4x4(
                                      colorTuple: colorTuple);
                                }),
                            // Selector<MagicTriangleProvider, bool>(
                            //     selector: (p0, p1) => p1.currentState.is3x3,
                            //     builder: (context, is3x3, child) {
                            //       return is3x3
                            //           ? TriangleInput3x3(colorTuple: colorTuple)
                            //           : TriangleInput4x4(
                            //           colorTuple: colorTuple);
                            //     }),
                            SizedBox(
                              height: getPercentSize(height1, 3),
                            ),
                          ],
                        ),

                        // return ListView.builder(
                        //   itemCount: list.length,
                        //
                        //   itemBuilder: (context, index) {
                        //   return Container(
                        //     height: btnHeight,
                        //     decoration: getDefaultDecoration(
                        //       bgColor: colorTuple.item1.backgroundColor
                        //     ),
                        //   );
                        // },);

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

        // child: getCommonWidget(context: context, child: Column(
        //   children: <Widget>[
        //
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Selector<MagicTriangleProvider, int>(
        //             selector: (p0, p1) => p1.currentState.answer,
        //             builder: (context, answer, child) {
        //               return getTextWidget(
        //                   Theme
        //                       .of(context)
        //                       .textTheme
        //                       .titleSmall!.copyWith(fontWeight: FontWeight.bold),
        //                   answer.toString(),
        //                   TextAlign.center,
        //                   getPercentSize(
        //                       remainHeight, 4));
        //             }),
        //       ],
        //     ),
        //     SizedBox(height: getPercentSize(remainHeight, 3),),
        //
        //     Expanded(
        //       child: LayoutBuilder(builder: (context, constraints) {
        //
        //         print("size---${constraints.maxWidth}----${constraints.maxWidth}");
        //         return Stack(
        //           alignment: Alignment.center,
        //           children: <Widget>[
        //
        //
        //             Selector<MagicTriangleProvider, bool>(
        //                 selector: (p0, p1) => p1.currentState.is3x3,
        //                 builder: (context, is3x3, child) {
        //                   return is3x3
        //                       ? Triangle3x3(
        //                     radius: radius,
        //                     padding: padding,
        //                     triangleHeight: constraints.maxWidth,
        //                     triangleWidth: constraints.maxWidth,
        //                     colorTuple: colorTuple,
        //                   )
        //                       : Triangle4x4(
        //                     radius: radius,
        //                     padding: padding,
        //                     triangleHeight: constraints.maxWidth,
        //                     triangleWidth: constraints.maxWidth,
        //                     colorTuple: colorTuple,
        //                   );
        //                 }),
        //           ],
        //         );
        //       }),
        //     ),
        //
        //     SizedBox(height: getPercentSize(remainHeight, 3),),
        //     Selector<MagicTriangleProvider, bool>(
        //         selector: (p0, p1) => p1.currentState.is3x3,
        //         builder: (context, is3x3, child) {
        //           return
        //             is3x3
        //               ? TriangleInput3x3(colorTuple: colorTuple)
        //               :
        //             TriangleInput4x4(colorTuple: colorTuple);
        //         }),
        //     SizedBox(height: getPercentSize(remainHeight, 3),),
        //
        //   ],
        // ), subChild:     CommonInfoTextView<MagicTriangleProvider>(
        //     gameCategoryType: GameCategoryType.MAGIC_TRIANGLE,
        //     folder: colorTuple1.item1.folderName!,
        //     color: colorTuple1.item1.cellColor!),),
      );
    },);
  }
}
