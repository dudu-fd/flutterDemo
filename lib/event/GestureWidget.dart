import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetectorWidget();
  }
}

class GestureDetectorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GestureDetectorWidgetState();
}

/*
  注意： 当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，
  这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。
  如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。
*/
class _GestureDetectorWidgetState extends State<GestureDetectorWidget> {
  String _operation = "No Gesture Detected!"; //事件名

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200,
          height: 100,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("onTap"), // 单击
        onDoubleTap: () => updateText("onDoubleTap"), // 双击
        onLongPress: () => updateText("onLongPress"), // 长按
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class DragWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget>{
  double _top =0; // 距离顶部的偏移
  double _left =0; // 距离左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child:GestureDetector(

        ),top: _top,left: _left,),
      ],
    );
  }
}