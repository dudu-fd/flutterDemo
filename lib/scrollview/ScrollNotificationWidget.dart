import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollNotificationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScrollNotificationWidgetState();
}

class _ScrollNotificationWidgetState extends State<ScrollNotificationWidget> {
  String _progress = "0%"; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo"),
      ),
      body: Scrollbar(
        // 监听滚动通知
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            // print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            //pixels：当前滚动位置。
            // maxScrollExtent：最大可滚动长度。
            // extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
            // extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
            // extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
            // atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）
            print(
                "maxScrollExtent: ${notification.metrics.maxScrollExtent} || pixels: ${notification.metrics.pixels} || "
                "extentBefore: ${notification.metrics.extentBefore} || extentInside: ${notification.metrics.extentInside} || "
                "extentAfter: ${notification.metrics.extentAfter} || atEdge: ${notification.metrics.atEdge} ");
            return false; // 如果返回 true ，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                  );
                },
                itemExtent: 50,
                itemCount: 50,
              ),
              CircleAvatar(
                child: Text(_progress),
                radius: 30,
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
