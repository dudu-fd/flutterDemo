import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* 通过继承 InheritedWidget，将当前计数器点击次数保存在 ShareDataWidget 的 data 属性中 */
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data; // 需要在子树中共享的数据，这里是点击次数

  // 定义一个便捷方法，方便子树中的 Widget 获取共享数据
  static ShareDataWidget of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    // 这个方法可以不让依赖了 InheritedWidget 的子 Widget 回调 didChangeDependencies()方法
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
        .widget;
  }

  //  该回调决定当 data 发生变化时，是否通过子树中依赖 data 的 Widget
  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}

/* 在其 build方法中引用ShareDataWidget中的数据。同时，在其 didChangeDependencies() 回调中打印日志 */
class UseShareDataWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UseShareDataWidgetState();
}

class _UseShareDataWidgetState extends State<UseShareDataWidget> {
  @override
  Widget build(BuildContext context) {
    print("build change");
    // 使用 InheritedWidget 中的共享数据
    // 这里通过 context 让 InheritedWidget 注册了依赖关系
    return Text(ShareDataWidget.of(context).data.toString());
    // return Text("no use ShareDataWidget"); // 没有依赖 InheritedWidget，所以只会回调 build 不会回调 didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖 InheritedWidget，则此回调不会被调用。
    print("Dependencies change");

    //如 果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是在此方法中执行，
    // 这样可以避免每次 build() 都执行这些昂贵操作。
  }
}

class InheritedCounterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InheritedCounterWidgetState();
}

class _InheritedCounterWidgetState extends State<InheritedCounterWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        // 这里用到了 count
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              // 子 widget 中依赖 ShareDataWidget
              child: UseShareDataWidget(),
            ),
            ElevatedButton(
                // 每点击一次，将 count自增，然后重新 build,ShareDataWidget的data将被更新
                // 而 UseShareDataWidget 中依赖 ShareDataWidget，也会重新 build ，数据也被更新了
                onPressed: () {
                  // 所有子节点都会被重新 build，这很没必要，实际上，我们只想更新子树中依赖了ShareDataWidget的组件，应该怎么优化呢？
                  setState(() {
                    ++count;
                  });
                },
                child: Text("+1"))
          ],
        ),
      ),
    );
  }
}
