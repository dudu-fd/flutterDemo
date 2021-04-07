import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    SingleChildScrollView 是只能包含一个 子Widget 的可滚动Widget。如果有很多 子Widget，那么需要用 ListBody 或者
    Column 或者其他 Widget 来嵌套这些 子Widget，然后在 SingleChildScrollView 里使用。

    需要注意的是，通常 SingleChildScrollView 只应在期望的内容不会超过屏幕太多时使用，这是因为 SingleChildScrollView 不支持
    基于 Sliver 的延迟实例化模型，所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用 SingleChildScrollView 将会非常
    昂贵（性能差），此时应该使用一些支持Sliver延迟加载的可滚动组件，如 ListView 。
 */

/*
    scrollDirection:        	Axis	                      滚动方向，默认是垂直方向
    padding:      	          EdgeInsetsGeometry	        插入子 Widget 时的内边距
    reverse:     	            bool	                      控制 SingleChildScrollView 是从头开始滑，还是从尾开始滑，默认为 false，就是从头开始滑
    primary:                  bool	                      指是否使用 widget 树中默认的 PrimaryScrollController
    physics:   	              ScrollPhysics     	        它决定可滚动组件如何响应用户操作，ClampingScrollPhysics：Android下微光效果，BouncingScrollPhysics：iOS下弹性效果
    controller:          	    ScrollController	          控制滚动位置和监听滚动事件
    child:        	          Widget	                    SingleChildScrollView 的列表项
    dragStartBehavior:       	DragStartBehavior    	      确定处理拖动开始行为的方式
*/

class SingleChildScrollViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return VerticalScrollWidget();
    return HorizontalScrollWidget();
  }
}

/*垂直滚动演示*/
class VerticalScrollWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String words = "ABCDEFGHIJKLMNOPQRSTUVWSYZ";
    return Scrollbar(
        // 滚动条控件
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          // 动态创建一个 List<Widget>
          children: words
              .split("")
              // 每一个字母用一个 Text 显示，字体放大两倍
              .map((e) => Text(
                    e,
                    textScaleFactor: 2,
                  ))
              .toList(),
        ),
      ),
    ));
  }
}

/*水平滚动演示*/
class HorizontalScrollWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      reverse: true, // 从尾开始滑
      scrollDirection: Axis.horizontal, // 水平滚动
      child: Text(
        "dudu" * 100,
        textScaleFactor: 2,
      ),
    ));
  }
}
