import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathspuzzle/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathspuzzle/ui/magicTriangle/triangle_input_button.dart';

import 'package:tuple/tuple.dart';

class Triangle3x3 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;

  Triangle3x3({
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Get.find<MagicTriangleProvider>();

    double remainHeight = triangleHeight;
    double height = remainHeight / 14;

    remainHeight = remainHeight - (height * 2.5);

    double cellHeight = remainHeight / 6;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: TriangleInputButton(
                  cellHeight: cellHeight,
                  input: magicTriangleProvider.currentState.listTriangle[0],
                  index: 0,
                  colorTuple: colorTuple,
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
              child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[1],
                      index: 1,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[2],
                      index: 2,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                )
              ],
            ),
          )),
          Expanded(
              child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[3],
                      index: 3,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[4],
                      index: 4,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[5],
                      index: 5,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
        ],
      ),
    );

  }
}
