import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
   Transform 可以在其子控件绘制时对其应用一些矩阵变换来实现一些特效，而矩阵变化时发生在绘制时期，
   而无需重新布局和构建等过程，性能很好
*/
class TransformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.deepOrange,
                child: const Text("I am dudu"),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Container(
            color: Colors.blue,
            child: Transform.translate(
                // 默认原点为左上角，这里的文本会向左下偏移
                offset: Offset(-20, 5),
                child: const Text("I am dudu")),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Container(
            color: Colors.blue,
            child: Transform.rotate(
                // 旋转45度 ，一个pi大小为180度
                angle: math.pi / 4,
                child: const Text("I am dudu")),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Container(
            color: Colors.blue,
            child: Transform.scale(
                // 放大到 1.5 倍
                scale: 1.5,
                child: const Text("I am dudu")),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green),
              // Transform 只在绘制阶段进行，此时布局已经完成，所以不会影响实际的位置，因此这里会有文本重叠
              child: Transform.scale(
                scale: 1.5,
                child: Text("I am jack"),
              ),
            ),
            Text(
              "I am dudu",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          ]),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Transform.scale(
            scale: 1.5,
            child: DecoratedBox(
              // 就算这样写，也只会缩放 Text ，背景色不会跟着缩放
              decoration: BoxDecoration(color: Colors.green),
              child: Transform.scale(
                scale: 1.5,
                child: Text("I am jack"),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.green),
              // RotatedBox 是在布局阶段进行，所以会影响实际的位置，背景色也会跟着变化，因此这里的文本不会重叠
              child: RotatedBox(
                quarterTurns: 1, // 旋转90度(1/4圈)，只能是90度的倍数
                child: Text("I am jack"),
              ),
            ),
            Text(
              "I am dudu",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          ]),
        ],
      ),
    );
  }
}
