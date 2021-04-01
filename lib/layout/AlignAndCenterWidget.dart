import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  Alignment Widget会以矩形的中心点作为坐标原点，即Alignment(0.0, 0.0) 。x、y的值从-1到1分别代表矩形左边到右边的距离和顶部到底边的距离，
  因此2个水平（或垂直）单位则等于矩形的宽（或高），如Alignment(-1.0, -1.0) 代表矩形的左侧顶点，而Alignment(1.0, 1.0)代表右侧底部终点，
  而Alignment(1.0, -1.0) 则正是右侧顶点，即Alignment.topRight。为了使用方便，矩形的原点、四个顶点，以及四条边的终点在Alignment类中都已经定义为了静态常量。

  Alignment可以通过其坐标转换公式将其坐标转为子元素的具体偏移坐标：
      实际偏移 = (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)

  FractionalOffset 继承自 Alignment，它和 Alignment唯一的区别就是坐标原点不同！FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致，所以理解起来会比较容易。

  FractionalOffset的坐标转换公式为：
      实际偏移 = (FractionalOffset.x * childWidth, FractionalOffset.y * childHeight)

*/
/*
  Positioned 是比较精确的定位，如果想要简单的调整一个子元素在父元素的位置，比如右下、右上，可以用 Align，如果
  是居中，更可以直接使用 Center ，Center 继承于 Align ，而把方向固定为居中了
*/
/*
                  Align 的参数说明

  alignment:          Alignment	         容器内 child 的对齐方式
  widthFactor:	      double	           宽度因子，如果为null，则尽可能的占用最大空间
  heightFactor:	      double	           高度因子，如果为null，则尽可能的占用最大空间
  child:	            Widget	           容器里显示的 Widget
 */

class AlignAndCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlignWidget();
    // return CenterWidget();
  }
}

class AlignWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 220,
            height: 220,
            color: Colors.blue[50],
            child: Align(
              // alignment: Alignment.topRight,
              alignment: Alignment(1.1,0),
              // alignment: FractionalOffset(1.5,0.5),
              // alignment: FractionalOffset.topRight,
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            color: Colors.blue[50],
            child: Align(
              // 以下两种方式是等价的，因为参考系不一样，Alignment 的坐标原点是矩形的中心点，FractionalOffset为左上顶点
              // 注意，虽然坐标原点不一致，但是偏移是从左上角开始的，不是从原点开始
              alignment: Alignment(2, 0),
              // alignment: FractionalOffset(1.5,0.5),
              // 缩放因子，会乘以子元素的宽高，所以这里的 Align 宽高为 120，120
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 60,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            // 没指定宽高因子，即为 null ，会占用尽可能多的空间
            child: Text(" I am dudu"),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
            // 宽高因子不为 null ，则宽高按因子计算
            widthFactor: 1,
            heightFactor: 1,
            child: Text("I am dudu"),
          ),
        )
      ],
    );
  }
}
