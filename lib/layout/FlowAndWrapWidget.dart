import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*              Wrap 的特有属性

  spacing :          double	          主轴方向控件间的间距
  runSpacing:	       double	          纵轴(即主轴的交叉轴)方向控件间的间距
  runAlignment:	     WrapAlignment	  纵轴(即主轴的交叉轴)方向的对齐方式
*/

/* 流布局，会将超出屏幕显示范围的内容自动折行，主轴高度超过屏幕高度,是不会滑动的,想要滑动还是要嵌套滑动控件*/
class FlowAndWrapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return WrapWidget();
    return FlowWidget();
  }
}

class WrapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        // 加上 ConstrainedBox，强制更改宽度和高度限制
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 0,
          // 默认宽度自适应，尽量占用最少空间，所以会看不出来效果
          alignment: WrapAlignment.spaceAround,
          children: [
            Chip(
              label: Text("Android"),
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("A"),
              ),
            ),
            Chip(
              label: Text("Ios"),
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("I"),
              ),
            ),
            Chip(
              label: Text("Flutter"),
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("F"),
              ),
            ),
            Chip(
              label: Text("Web"),
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("W"),
              ),
            ),
            Chip(
              label: Text("React Native"),
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("R"),
              ),
            ),
          ],
        ));
  }
}

class FlowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: CustomFlowDelegate(margin: EdgeInsets.all(10)),
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.red,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.black,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.purple,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
      ],
    );
  }
}

class CustomFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  CustomFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每一个子控件的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 绘制子控件
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定 Flow 的大小
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
