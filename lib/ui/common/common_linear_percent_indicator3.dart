import 'package:flutter/material.dart';
import '../app/game_provider.dart';

class CommonLinearPercentIndicator<T extends GameProvider>
    extends StatelessWidget {
  final double lineHeight;
  final LinearGradient linearGradient;
  final Color backgroundColor;

  CommonLinearPercentIndicator({
    this.lineHeight = 5.0,
    required this.linearGradient,
    this.backgroundColor = Colors.black12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: backgroundColor, height: lineHeight);
  }
}
