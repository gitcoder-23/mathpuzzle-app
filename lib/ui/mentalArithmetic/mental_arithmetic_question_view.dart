import 'package:flutter/material.dart';
import 'package:mathspuzzle/data/models/mental_arithmetic.dart';

import '../../utility/Constants.dart';

class MentalArithmeticQuestionView extends StatefulWidget {
  final MentalArithmetic currentState;

  const MentalArithmeticQuestionView({
    Key? key,
    required this.currentState,
  }) : super(key: key);

  @override
  _MentalArithmeticQuestionViewState createState() =>
      _MentalArithmeticQuestionViewState();
}

class _MentalArithmeticQuestionViewState
    extends State<MentalArithmeticQuestionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  late Animation<AlignmentGeometry> _animation1;
  late final Animation<double> _opacityAnimationOut;
  late final Animation<double> _opacityAnimationIn;
  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      )
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            if (index < 3) {
              index++;
              _controller.forward(from: 0);
            }
          }
        })
        ..forward();

      _animation = Tween<AlignmentGeometry>(
        begin: Alignment.centerRight,
        end: Alignment.center,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.0,
            0.8,
            curve: Curves.ease,
          ),
        ),
      );

      _animation1 = Tween<AlignmentGeometry>(
        begin: Alignment.center,
        end: Alignment.centerLeft,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2,
            1.0,
            curve: Curves.ease,
          ),
        ),
      );

      _opacityAnimationOut = Tween<double>(
        begin: 1.0,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.8,
          curve: Curves.ease,
        ),
      ));

      _opacityAnimationIn = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.ease,
        ),
      ));

    });
  }

  @override
  void didUpdateWidget(MentalArithmeticQuestionView oldWidget) {
    if (oldWidget.currentState != widget.currentState) {
        _controller.forward(from:0.0);
        index = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Align(
              alignment: _animation.value,
              child: Opacity(
                opacity: _opacityAnimationIn.value,
                child: getTextWidget(
                    Theme
                        .of(context)
                        .textTheme
                        .titleSmall!
                        ,
                    index != 3 ? widget.currentState.questionList[index] : "",
                    TextAlign.center,
                    getPercentSize(
                        getRemainHeight(context: context), 3.5)),


              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) {
            return Align(
              alignment: _animation1.value,
              child: Opacity(
                opacity: _opacityAnimationOut.value,
                child:   getTextWidget(
                  Theme
                  .of(context)
                  .textTheme
                  .titleSmall!
                ,
                      index == 0 ? "" : widget.currentState.questionList[index - 1],
                TextAlign.center,
                getPercentSize(
                    getRemainHeight(context: context), 3.5)),

              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
