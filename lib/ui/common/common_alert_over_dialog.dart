import 'package:flutter/material.dart';
import 'package:mathspuzzle/utility/Constants.dart';

class CommonAlertOverDialog extends AlertDialog {
  final Widget child;
  final bool? isGameOver;
  final Color? bgColor;

  CommonAlertOverDialog({required this.child, this.isGameOver, this.bgColor})
      : super();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.transparent,
        margin:
            EdgeInsets.symmetric(horizontal: getHorizontalSpace(context) * 2),

        child: child,
      ),
    );
  }
}
