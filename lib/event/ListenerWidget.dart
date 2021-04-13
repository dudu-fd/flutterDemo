import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListenerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  @override
  Widget build(BuildContext context) {
    // return DeferTochild();
    // return Opaque();
    // return AllBehavior();
    return IgnoreAndAbsorbPointer();
  }
}

/* deferToChild 为默认的命中测试行为*/
class DeferTochild extends StatefulWidget {
  @override
  _DeferTochildState createState() => _DeferTochildState();
}

class _DeferTochildState extends State<DeferTochild> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300,
          height: 150,
          child: Text(
            _event?.toString() ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPointerDown: (event) {
          setState(() {
            _event = event;
          });
        },
        onPointerMove: (event) {
          setState(() {
            _event = event;
          });
        },
        onPointerUp: (event) {
          setState(() {
            _event = event;
          });
        },
      ),
    );
  }
}

class Opaque extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 300, height: 150),
          child: Center(
            child: Text("Box A"),
          ),
        ),
        onPointerDown: (event) => print("Down A"),
        // 这里设置为 opaque ，所以整个300×150的矩形区域都能点击，否则只能点击文本
        behavior: HitTestBehavior.opaque,
      ),
    );
  }
}

class AllBehavior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300, 200)),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          onPointerDown: (event) => print("point 300,200"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200, 100)),
            child: Center(
              child: Text("这是 200 *100 范围内的文本"),
            ),
          ),
          onPointerDown: (event) => print("point 200,100"),
          behavior: HitTestBehavior.deferToChild, // 默认值，只会打印 "point 300,200"
          // behavior: HitTestBehavior.translucent, // 会同时打印 "point 300,200" 和 "point 200,100"
          // behavior: HitTestBehavior.opaque, // 只会打印 "point 200,100"
        )
      ],
    );
  }
}

class IgnoreAndAbsorbPointer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: IgnorePointer(
          // AbsorbPointer 的子树不能接收指针事件，本身是可以接收指针事件
          // IgnorePointer 的子树不能接收指针事件，本身也不可以接收指针事件
          child: Listener(
            child: Container(
              color: Colors.blueGrey,
              width: 200,
              height: 100,
            ),
            onPointerDown: (event) => print("in"),
          ),
        ),
        onPointerDown: (event) => print("out"),
      ),
    );
  }
}
