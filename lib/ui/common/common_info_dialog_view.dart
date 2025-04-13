import 'package:flutter/material.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/data/models/game_info_dialog.dart';
import 'package:mathspuzzle/utility/Constants.dart';
import 'package:mathspuzzle/utility/dialog_info_util.dart';

class CommonInfoDialogView extends StatelessWidget {
  final GameCategoryType gameCategoryType;
  final Color color;

  const CommonInfoDialogView({
    required this.gameCategoryType,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameInfoDialog gameInfoDialog =
        DialogInfoUtil.getInfoDialogData(gameCategoryType);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getScreenPercentSize(context, 2),
          horizontal: getHorizontalSpace(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getTextWidget(
              Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              gameInfoDialog.title,
              TextAlign.center,
              getScreenPercentSize(context, 3.5)),

          SizedBox(height: getScreenPercentSize(context, 5)),
          // Container(
          //   height: getScreenPercentSize(context, 25),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: gameInfoDialog.colorTuple.item2,
          //     borderRadius: BorderRadius.all(Radius.circular(radius)),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.all(Radius.circular(radius)),
          //     child: Image.asset(
          //       gameInfoDialog.image,
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          // SizedBox(height: getScreenPercentSize(context, 3.5)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 10)),
            child: getTextWidgetWithMaxLine(
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
                gameInfoDialog.dec,
                TextAlign.center,
                getScreenPercentSize(context, 2),
                4),
          ),
          SizedBox(height: getScreenPercentSize(context, 4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                      "${gameInfoDialog.correctAnswerScore}",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                  SizedBox(
                    height: getScreenPercentSize(context, 1.8),
                  ),
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                      "${gameInfoDialog.wrongAnswerScore}",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),
                ],
              ),
              SizedBox(width: getWidthPercentSize(context, 2)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                      "for correct answer",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),

                  SizedBox(
                    height: getScreenPercentSize(context, 1.8),
                  ),
                  getTextWidget(
                      Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                      "for wrong answer",
                      TextAlign.center,
                      getScreenPercentSize(context, 2)),


                ],
              ),
            ],
          ),
          SizedBox(height: getScreenPercentSize(context, 5)),

          Row(
            children: [
              Expanded(
                  child: getButtonWidget(context, "Cancel",
                      Theme.of(context).textTheme.bodySmall!.color, () {
                Navigator.pop(context);
              },
                      isBorder: true,
                      textColor: Theme.of(context).textTheme.bodySmall!.color)),
              SizedBox(
                width: getWidthPercentSize(context, 5),
              ),
              Expanded(
                  child: getButtonWidget(context, "Go", color, () {
                Navigator.pop(context);
              }, textColor: Colors.black))
            ],
          ),

        ],
      ),
    );
  }
}
