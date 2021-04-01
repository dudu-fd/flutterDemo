import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*              Stack 的特有属性

  alignment  :    AlignmentGeometry	   用来定位未使用 Positioned 或部分定位的控件
  fit:	          StackFit	           用来确定没有定位的控件如何去适应 Stack 的大小(不包括部分定位控件)
                                       StackFit.loose 表示使用子控件的大小，StackFit.expand 表示扩伸到 Stack 的大小
  overflow:	      Overflow	           决定如何显示超出 Stack 显示空间的子组件；值为 Overflow.clip 时，超出部分会被剪裁（隐藏），值为 Overflow.visible 时则不会
*/

/*
    const Positioned({
      Key key,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.width,
      this.height,
      @required Widget child,
    })

    left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离。width和height用于指定需要定位元素的宽度和高度。
    注意，Positioned的width、height 和其它地方的意义稍微有点区别，此处用于配合left、top 、right、 bottom来定位组件，
    举个例子，在水平方向时，你只能指定left、right、width三个属性中的两个，如指定left和width后，right会自动算出(left+width)，
    如果同时指定三个属性则会报错，垂直方向同理
*/

/* 层叠布局，通常要配合 Positioned 使用*/
class StackAndPositionedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        // 未定位的控件会占满 Stack 整个空间
        // fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // 此控件为部分定位控件
          Positioned(
            child: Text("I am jack"),
            // 水平方向有定位，则垂直位置被 alignment 影响
            left: 10,
          ),
          // 此控件为未定位控件
          Container(
            child: Text(
              "I am dudu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            color: Colors.blue,
          ),
          // 此控件为完全定位控件，不再受 alignment 属性影响
          Positioned(
            child: Text("I am nothing"),
            left: 10,
            top: 15,
          ),
          Align(
              // alignment: Alignment.bottomRight,
              // alignment: FractionalOffset(1, 0),
              // alignment: Alignment(1, 0),
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.green,
                width: 100,
                height: 100,
                child: Text(
                  "I am Align",

                ),
              ))
        ],
      ),
    );
  }
}
