import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  mainAxisAlignment:          MainAxisAlignment	         主轴方向对齐方式，如果是 Row 则主轴是水平方向，为 Column 则主轴为垂直方向
  crossAxisAlignment:	        CrossAxisAlignment	       纵轴(即主轴的交叉轴)方向对齐方式
  mainAxisSize:	              MainAxisSize	             表示主轴方向占用的空间，默认尽可能占用最大的空间
  verticalDirection:	        VerticalDirection	         纵轴的对齐方式（crossAxisAlignment的参考系），有 Down 和 Up 两种
  children:	                  List< Widget>	             子控件组
  textBaseline:	              TextBaseline	             排列子控件组时使用哪条基线
*/

/* Row 和 Column 都继承于 Flex ，如果子控件超出屏幕范围，会出错*/
class RowAndColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return RowWidget();
    // return ColumnWidget();
    return ColumnInColumn();
  }
}

class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("hello world"), Text("I am dudu")],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("hello world"), Text("I am dudu")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          // 注意文本的显示是倒着的
          children: [Text("hello world"), Text("I am dudu")],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // 从上往下排列
          verticalDirection: VerticalDirection.down,
          children: [
            Text(
              "hello world",
              style: TextStyle(fontSize: 30),
            ),
            Text("I am dudu")
          ],
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("hello world"), Text("I am dudu")],
        )
      ],
    );
  }
}

class ColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 加上 ConstrainedBox，让纵轴的占用空间为无限大，则可让 Column 的子控件横向居中
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Column(
        // 因为设置了 MainAxisSize.min ,在垂直方向占用尽可能少的空间，则 MainAxisAlignment.center 不生效
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("hi"), Text("I am dudu")],
      ),
    );
  }
}

class ColumnInColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        // 这里外层的 Column 会尽可能的占用最大空间
        child: Column(
          children: [
            // 这里使用 Expanded 才可以让内层的 Column 尽可能的占用最大空间
            Expanded(
                child: Container(
              color: Colors.blue,
              // 内层的 column 所占空间为实际大小
              child: Column(
                // 这里的属性无效
                mainAxisSize: MainAxisSize.max,
                children: [Text("hi"), Text("I am dudu")],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
