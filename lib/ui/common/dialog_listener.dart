import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/core/app_constant.dart';
import 'package:mathspuzzle/core/color_scheme.dart';
import 'package:mathspuzzle/ui/app/game_provider.dart';
import 'package:mathspuzzle/ui/common/common_alert_dialog.dart';
import 'package:mathspuzzle/ui/common/common_game_exit_dialog_view.dart';
import 'package:mathspuzzle/ui/common/common_game_over_dialog_view.dart';
import 'package:mathspuzzle/ui/common/common_game_pause_dialog_view.dart';
import 'package:mathspuzzle/ui/common/common_info_dialog_view.dart';
import 'package:mathspuzzle/ui/numericMemory/numeric_view.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';
import '../model/gradient_model.dart';
import 'common_alert_over_dialog.dart';
import 'common_dual_game_over_dialog_view.dart';
import 'common_hint_dialog.dart';

class DialogListener<T extends GameProvider> extends StatefulWidget {
  final Widget child;
  final Widget appBar;
  final GameCategoryType gameCategoryType;
  final int level;
  final Tuple2<GradientModel, int> colorTuple;
  final Function? nextQuiz;

  const DialogListener({
    Key? key,
    required this.appBar,
    required this.child,
    required this.gameCategoryType,
    required this.level,
    required this.colorTuple,
    this.nextQuiz,
  }) : super(key: key);

  @override
  State<DialogListener<T>> createState() => _DialogListenerState<T>();
}

class _DialogListenerState<T extends GameProvider>
    extends State<DialogListener<T>> {
  late final T provider;
  bool? isDialogOpen = false;

  @override
  void initState() {

    print("called---dialog----initState");
    provider = Get.find<T>();
    provider.addListener(addListener);
    super.initState();
  }

  void addListener() {
    double radius = getScreenPercentSize(context, 5);
    // print(
        // "dialog---true---${provider.dialogType}----${context.read<T>().currentScore}");

    if (isDialogOpen != null && !isDialogOpen!) {
      if (provider.dialogType == DialogType.over &&
          provider.gameCategoryType == GameCategoryType.DUAL_GAME) {
        isDialogOpen = true;
        showDialog<bool>(
          context: context,
          builder: (newContext) => CommonAlertDialog(
            isGameOver: true,
            child: CommonDualGameOverDialogView(
              gameCategoryType: widget.gameCategoryType,
              score1: provider.score1.toInt(),
              score2: provider.score2.toInt(),
              index: provider.index.toInt(),
              colorTuple: widget.colorTuple,
              totalQuestion: provider.index,
            ),
          ),
          barrierDismissible: false,
        ).then((value) {
          isDialogOpen = false;
          provider.updateScore();

          if (value != null && value) {
            provider.startGame(level: widget.level);
          } else {
            Navigator.pop(context);
          }
        });
      } else {

        print("level------${provider.levelNo}");
        int level = provider.levelNo;
        switch (provider.dialogType) {
          case DialogType.over:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertOverDialog(
                child: CommonGameOverDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: provider.currentScore.value.toInt(),
                  right: provider.rightCount.toInt(),
                  wrong: provider.wrongCount.toInt(),
                  level: provider.levelNo.toInt(),
                  function: (nextLevel) {
                    level = nextLevel;

                  },
                  updateFunction: (){
                    provider.updateScore();
                  },
                  colorTuple: widget.colorTuple,
                  totalQuestion: provider.index,
                ),
                isGameOver: true,
              ),
              barrierDismissible: false,
            ).then((value) {
              print("level===$level===${provider.currentScore}");
              isDialogOpen = false;



              if (value != null && value) {
                if (widget.gameCategoryType ==
                    GameCategoryType.NUMERIC_MEMORY) {
                  if (widget.nextQuiz != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NumericMemoryView(
                              colorTuple:
                                  Tuple2(widget.colorTuple.item1, level)),
                        ));
                  }
                } else {
                  provider.rightCount = 0;
                  provider.wrongCount = 0;
                  provider.index = 0;


                  // print("level12===$level===${(widget.gameCategoryType ==
                  //     GameCategoryType.NUMERIC_MEMORY)}===$value");
                  provider.startGame(
                      level: level, isTimer: provider.isTimer);
                }


              } else {
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.info:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (context) => CommonInfoDialogView(
                gameCategoryType: widget.gameCategoryType,
                color: widget.colorTuple.item1.primaryColor!,
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              provider.gotItFromInfoDialog(widget.level);
            });
            break;
          case DialogType.pause:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGamePauseDialogView(
                  gameCategoryType: widget.gameCategoryType,
                  score: provider.currentScore.value,
                  colorTuple: widget.colorTuple,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null) {
                if (value) {
                  provider.pauseResumeGame();
                } else {
                  provider.updateScore();
                  provider.startGame(level: widget.level);
                }
              } else {
                provider.updateScore();
                Navigator.pop(context);
              }
            });
            break;
          case DialogType.exit:
            isDialogOpen = true;
            showDialog<bool>(
              context: context,
              builder: (newContext) => CommonAlertDialog(
                child: CommonGameExitDialogView(
                  colorTuple: widget.colorTuple,
                  score: provider.currentScore.value,
                ),
              ),
              barrierDismissible: false,
            ).then((value) {
              isDialogOpen = false;
              if (value != null && value) {
                provider.updateScore();
                Navigator.pop(context);
              } else {
                provider.pauseResumeGame();
              }
            });
            break;

          case DialogType.hint:
            isDialogOpen = true;
            showModalBottomSheet(
              context: context,
              builder: (c) => CommonHintDialog(
                gameCategoryType: widget.gameCategoryType,
                colorTuple: widget.colorTuple,
                provider: provider,
              ),
              backgroundColor: Theme.of(context).colorScheme.infoDialogBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ).then((value) {
              isDialogOpen = false;
              provider.gotItFromInfoDialog(widget.level);
            });
            break;
          case DialogType.non:
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: getNoneAppBar(context),
          body: SafeArea(
            bottom: true,
            child: Column(
              children: [
                widget.appBar,
                Expanded(
                  child: widget.child,
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          provider.showExitDialog();
          return true;
        });
  }

  @override
  void dispose() {
    provider.removeListener(addListener);
    super.dispose();
  }
}
