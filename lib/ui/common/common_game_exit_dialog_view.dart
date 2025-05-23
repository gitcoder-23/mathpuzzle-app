import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_assets.dart';
import '../../utility/Constants.dart';
import '../model/gradient_model.dart';

class CommonGameExitDialogView extends StatelessWidget {
  final double score;
  final Tuple2<GradientModel, int> colorTuple;

  const CommonGameExitDialogView({
    required this.score,
    required this.colorTuple,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize=getScreenPercentSize(context, 3);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Align(
          alignment: Alignment.topRight,
          child:  GestureDetector(
            onTap: (){
              Navigator.pop(context, false);
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
            "Quit!!!", TextAlign.center, getScreenPercentSize(context,2.5)),




        SizedBox(height: getScreenPercentSize(context, 1.5)),




        getTextWidget(Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400,
     ),
            "Are you sure you want to quit the game?", TextAlign.center, getScreenPercentSize(context,2.2)),



        SizedBox(height: getScreenPercentSize(context, 3)),

        Row(
          children: [
            Expanded(child: getButtonWidget(context, "Yes", colorTuple.item1.primaryColor, (){
              Navigator.pop(context, true);
            },textColor: darken(colorTuple.item1.primaryColor!),isBorder: true),flex: 1,),
            SizedBox(width: getWidthPercentSize(context, 3),),
            Expanded(child: getButtonWidget(context, "No", colorTuple.item1.primaryColor, (){
              Navigator.pop(context, false);
            },textColor: Colors.black),flex: 1,),
          ],
        )

      ],
    );
  }
}
