import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/game_info_dialog.dart';
import 'package:mathspuzzle/utility/dialog_info_util.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';

class CommonGamePauseDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final double score;
  final Tuple2<GradientModel, int> colorTuple;


  const CommonGamePauseDialogView({
    required this.gameCategoryType,
    required this.score,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double iconSize=getScreenPercentSize(context, 3);

    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Align(
          alignment: Alignment.topRight,
          child:  GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              getFolderName(context, colorTuple.item1.folderName!)+AppAssets.closeIcon,

              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
        SizedBox(height: getScreenPercentSize(context, 1.8)),

        getTextWidget(Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
    gameInfoDialog.title, TextAlign.center, getScreenPercentSize(context,2.5)),



        SizedBox(height: getScreenPercentSize(context, 4)),

        getTextWidget(Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600), score.toInt().toString(), TextAlign.center, getScreenPercentSize(context,6)),
        SizedBox(height: getScreenPercentSize(context, 1)),

        getTextWidget(Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500,
         ),
            "Your current score", TextAlign.center, getScreenPercentSize(context,2.2)),

        SizedBox(height: getScreenPercentSize(context, 5)),

        Row(
          children: [
            Expanded(
              child: getButtonWidget(context, "Resume".toUpperCase(), colorTuple.item1.primaryColor, (){
                Navigator.pop(context, true);
              },textColor: Colors.black),
            ),

            SizedBox(width: getHorizontalSpace(context),),

            InkWell(
              onTap: (){
                Navigator.pop(context, false);
              },
              child: Container(
                height: getDefaultButtonSize(context),
                width: getDefaultButtonSize(context),

                decoration: getDefaultDecoration(radius: getPercentSize(getDefaultButtonSize(context), 20)
                    ,bgColor:  colorTuple.item1.primaryColor),
                child: Center(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),



      ],
    );
  }
}
