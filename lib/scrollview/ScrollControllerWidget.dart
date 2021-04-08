import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollControllerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollControllerWidgetState();
}

class _ScrollControllerWidgetState extends State<ScrollControllerWidget> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; // 是否显示 "返回到顶部" 按钮

  @override
  void initState() {
    super.initState();
    // 监听滚动事件，打印滚动位置
    _controller.addListener(() {
      // 打印当前滚动位置
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 为了避免内存泄露
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo"),
      ),
      body: Scrollbar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
              );
            },
            itemCount: 100,
            itemExtent: 50, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
            controller: _controller,
          )),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
        onPressed: () {
          // 返回到顶部时执行动画
          _controller.animateTo(0, duration: Duration(milliseconds: 200),
              curve: Curves.ease);
        }, child: Icon(Icons.arrow_upward),),
    );
  }
}
