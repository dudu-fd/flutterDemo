import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';

/* StatelessWidget 演示*/
class Echo extends StatelessWidget {
  // final 修饰字段
  final String text;
  final Color backgroundColor;

  //构造函数约定规则： const 修饰 ,key 放在首位，必要参数用@required修饰，child放在最后
  const Echo({Key key, @required this.text, this.backgroundColor: Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

/* 演示 Context 的使用*/
class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          // 在 Widget 树中向上查找最近的父级 Scaffold Widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 返回 appbar 的 title Widget
          return (scaffold.appBar as AppBar).title;
        },
      ),
    );
  }
}

/* StatefulWidget 演示*/
class CounterWidget extends StatefulWidget {
  final int initValue;

  const CounterWidget({Key key, this.initValue: 0});

  @override
  State<StatefulWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    // 当 Widget 第一次插入到树时会被调用，只会调用一次，通常在此回调初始化数据
    super.initState();
    // 初始化状态
    _counter = widget.initValue;
    print("initState: $_counter");
  }

  @override
  Widget build(BuildContext context) {
    // 构建 Widget 子树时回调，回调时机比较多
    print("build");
    return Center(
        child: TextButton(
      child: Text(
        "$_counter",
        style: TextStyle(fontSize: 32),
      ),
      // 点击后计数器自增
      onPressed: () {
        // 该方法可让 Widget 重新调用 build 来刷新界面
        setState(() {
          ++_counter;
        });
      },
    ));
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    // 当 Widget.canUpdate 返回 true 时，会回调该方法
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    // 当 State 对象从树中移除时，会回调，比如 Widget 位置的移动
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // 当 State 对象从树中被永久移除时调用，通常在此回调释放资源
    super.dispose();
    print("dispose");
  }

  @override
  void didChangeDependencies() {
    // 当 State 对象的依赖发生变化时会被回调
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void reassemble() {
    // 开发调试而用，在 hot reload 时会被调用，release 模式永远不会调用
    super.reassemble();
    print("reassemble");
  }
}

/*获取 Scaffold State 实例演示*/
class ShowSnackBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("显示 SnackBar"),
        onPressed: () {
          // 找到父级最近的 ScaffoldMessengerState 对象
          // ScaffoldMessengerState _state = context.findAncestorStateOfType<ScaffoldMessengerState>();
          ScaffoldMessengerState _state = ScaffoldMessenger.of(context);

          /*注意，of方法是约定方法，如果想暴露 Widget 对应的 State ，可增加一个of方法供外部调用拿到 State 对象*/

          // 下面这两种方法已过时，不建议使用
          // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
          // ScaffoldState _state = Scaffold.of(context);

          // 调用 ScaffoldMessengerState 的方法来显示 SnackBar
          _state.showSnackBar(SnackBar(content: Text("我是 SnackBar")));
        },
      ),
    );
  }
}

