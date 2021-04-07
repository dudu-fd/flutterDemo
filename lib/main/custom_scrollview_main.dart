import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/*
* MaterialApp 大部分情况下要作为 Flutter 的 根 Widget，并且 MaterialApp 和 Scaffold 经常是一起搭配使用的。
*
* CustomScrollView才可以将多个Sliver"粘"在一起，这些 Sliver共用 CustomScrollView 的 Scrollable ，所以最终才实现了统一的滑动效果。
* CustomScrollView的子组件必须都是Sliver
* */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 这里没有使用 Scaffold，为了让子控件使用 Material Design 默认的样式风格,我们使用 Material 作为根控件。
      home: Material(
        child: CustomScrollView(
          slivers: [
            // AppBar，包含一个导航栏
            SliverAppBar(
              pinned: true, // 导航栏是否固定，如果是 false 则可以滑出屏幕
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Demo"),
                centerTitle: true,  // 标题居中
                collapseMode: CollapseMode.parallax, // 视差模式
                stretchModes: [StretchMode.blurBackground],
                background: Image.asset(  // 背景图
                  "images/watch_movie.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 4,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  // 创建子控件
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                }, childCount: 20),
              ),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  // 创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text("list item $index"),
                  );
                }, childCount: 50),
                itemExtent: 50),
          ],
        ),
      ),
    );
  }
}
