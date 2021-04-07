import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  alignment:                AlignmentGeometry	              容器内 child 的对齐方式
  padding:	                EdgeInsetsGeometry	            容器内边距
  color:	                  Color	                          背景色，跟 Decoration 互斥， 同时设置会报错
  decoration:	              Decoration	                    背景装饰
  foregroundDecoration:	    Decoration	                    前景装饰
  width:	                  double	                        容器的宽度
  height:	                  double	                        容器的高度
  constraints:	            BoxConstraints	                容器大小的限制条件
  margin:	                  EdgeInsetsGeometry	            容器外边距，不属于 decoration 的装饰范围
  transform:	              Matrix4	                        变换
  child:	                  Widget	                        容器里显示的 Widget
 */

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 120),
      constraints: BoxConstraints.tightFor(width: 200, height: 150),
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: 0.98),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, offset: Offset(3, 2), blurRadius: 6)
          ]),
      transform: Matrix4.rotationZ(0.2),
      alignment: Alignment.center,
      child: Text(
        "5.20",
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}
