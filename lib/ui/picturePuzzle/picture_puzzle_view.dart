import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/common/common_back_button.dart';
import 'package:mathspuzzle/ui/common/common_clear_button.dart';
import 'package:mathspuzzle/ui/common/common_app_bar.dart';
import 'package:mathspuzzle/ui/common/common_info_text_view.dart';
import 'package:mathspuzzle/ui/common/dialog_listener.dart';
import 'package:mathspuzzle/ui/model/gradient_model.dart';
import 'package:mathspuzzle/ui/picturePuzzle/picture_puzzle_provider.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/ui/picturePuzzle/picture_puzzle_button.dart';
import 'package:tuple/tuple.dart';
import '../../utility/Constants.dart';
import '../common/common_main_widget.dart';
import '../common/common_number_button.dart';

class PicturePuzzleView extends StatelessWidget {
  final Tuple2<GradientModel, int> colorTuple;

   PicturePuzzleView({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);


  final List list = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "Clear",
    "0",
    "Back"
  ];


  @override
  Widget build(BuildContext context) {

    double remainHeight = getRemainHeight(context: context);
    int _crossAxisCount = 3;

    double height1 = getScreenPercentSize(context, 42);
    double height = height1 / 4.5;
    double radius = getPercentSize(height, 35);

    double _crossAxisSpacing = getPercentSize(height, 20);
    var widthItem = (getWidthPercentSize(context, 100) -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    double _aspectRatio = widthItem / height;
    var margin = getHorizontalSpace(context);

    double mainHeight = getMainHeight(context);



    return GetBuilder<PicturePuzzleProvider>(
      init: PicturePuzzleProvider(level: colorTuple.item2),
      builder: (controller) => DialogListener<PicturePuzzleProvider>(
      colorTuple:  colorTuple,
      appBar: CommonAppBar<PicturePuzzleProvider>(

          hint: false,
          infoView: CommonInfoTextView<PicturePuzzleProvider>(
              gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
              folder: colorTuple.item1.folderName!,
              color: colorTuple.item1.cellColor!),

          gameCategoryType: GameCategoryType.PICTURE_PUZZLE,colorTuple: colorTuple,context: context),

      gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
      level: colorTuple.item2,

      child: CommonMainWidget<PicturePuzzleProvider>(
        gameCategoryType: GameCategoryType.PICTURE_PUZZLE,
        color: colorTuple.item1.bgColor!,
        provider: controller,
        levelNo: colorTuple.item2,
        primaryColor: colorTuple.item1.primaryColor!,
        subChild: Container(
          margin: EdgeInsets.only(top: getPercentSize(mainHeight, 40)),

          child: Container(
            child:   Column(
              children: <Widget>[

                SizedBox(height: getPercentSize(remainHeight, 5),),
                Expanded(
                  flex: 1,
                  child: GetBuilder<PicturePuzzleProvider>(
                      init: controller,
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.list.map((e) {
                            return Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: (margin*2)),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: e.list[list.indexOf(e)+1].shapeList.map((subList) {
                                    return PicturePuzzleButton(
                                      picturePuzzleShape: subList,
                                      shapeColor: colorTuple.item1.primaryColor!,
                                      colorTuple: Tuple2(
                                          colorTuple.item1.cellColor!,colorTuple.item1.primaryColor!
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),

                ),
                SizedBox(height: getPercentSize(remainHeight, 1),),

                Container(
                  height: height1,
                  decoration: getCommonDecoration(context),
                  alignment: Alignment.bottomCenter,
                  child: Builder(builder: (context) {
                    return Center(
                      child: GridView.count(
                        crossAxisCount: _crossAxisCount,
                        childAspectRatio: _aspectRatio,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          right: (margin * 2),
                          left: (margin * 2),
                        ),
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _crossAxisSpacing,
                        primary: false,
                        // padding: EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                        children: List.generate(list.length, (index) {
                          String e = list[index];
                          if (e == "Clear") {
                            return CommonClearButton(
                                text: "Clear",
                                btnRadius: radius,
                                height: height,
                                onTab: () {
                                  controller
                                      .clearResult();
                                });
                          } else if (e == "Back") {
                            return CommonBackButton(
                              onTab: () {
                                controller
                                    .backPress();
                              },

                              height: height,
                              btnRadius: radius,
                            );
                          } else {
                            return CommonNumberButton(
                              text: e,
                              totalHeight: remainHeight,
                              height: height,  btnRadius: radius,
                              onTab: () {
                                controller
                                    .checkGameResult(e);
                              },
                              colorTuple: colorTuple,
                            );
                          }
                        }),
                      ),
                    );
                  }),
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
