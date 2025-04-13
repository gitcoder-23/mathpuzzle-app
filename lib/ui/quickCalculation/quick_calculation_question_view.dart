import 'package:flutter/material.dart';
import 'package:mathspuzzle/data/models/quick_calculation.dart';

import '../../utility/Constants.dart';

class QuickCalculationQuestionView extends StatefulWidget {
  final QuickCalculation currentState;
  final QuickCalculation nextCurrentState;
  final QuickCalculation? previousCurrentState;

  const QuickCalculationQuestionView({
    Key? key,
    required this.currentState,
    required this.nextCurrentState,
    required this.previousCurrentState,
  }) : super(key: key);

  @override
  _QuickCalculationQuestionViewState createState() =>
      _QuickCalculationQuestionViewState();
}

class _QuickCalculationQuestionViewState
    extends State<QuickCalculationQuestionView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(QuickCalculationQuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: getTextWidget(
              Theme.of(context).textTheme.titleSmall!,
              widget.currentState.question,
              TextAlign.center,
              getPercentSize(getRemainHeight(context: context), 4)),
        ),
      ],
    );
  }
}
