import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    const AlertDialog({
      Key key,
      this.title, //对话框标题组件
      this.titlePadding, // 标题填充
      this.titleTextStyle, //标题文本样式
      this.content, // 对话框内容组件
      this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), //内容的填充
      this.contentTextStyle,// 内容文本样式
      this.actions, // 对话框操作按钮组
      this.backgroundColor, // 对话框背景色
      this.elevation,// 对话框的阴影
      this.semanticLabel, //对话框语义化标签(用于读屏软件)
      this.shape, // 对话框外形
    })
*/

class DialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyAlertDialog(),
        SimpleDialogWidget(),
        MyDialog(),
        LoadingDialog(),
        DatePickerWidget(),
      ],
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  // 显示对话框
  Future<bool> showDeleteConfirmDialog(BuildContext context) {
    return showCustomDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "我是标题",
              style: TextStyle(color: Colors.blue),
            ),
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            // titleTextStyle: TextStyle(color: Colors.blue),
            content: Text("您确定要删除当前文件吗?"),
            contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            contentTextStyle: TextStyle(color: Colors.black),
            actions: [
              // 关闭对话框
              TextButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              // 关闭对话框并返回 true ，带返回值
              TextButton(
                child: Text("删除"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            // 弹出对话框并等待其关闭
            bool delete = await showDeleteConfirmDialog(context);
            if (delete == null) {
              print("取消删除");
            } else {
              print("确认删除");
            }
          },
          child: Text("简单的对话框")),
    );
  }

  // 自定义 showDialog 方法，可以自定义遮罩样式，Dialog显示的动画样式等
  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    final ThemeData themeData = Theme.of(context);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(child: Builder(
            builder: (BuildContext context) {
              return themeData != null
                  ? Theme(data: themeData, child: pageChild)
                  : pageChild;
            },
          ));
        },
        barrierDismissible: barrierDismissible,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        // 自定义遮罩颜色
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: _buildMaterialDialogTransitions);
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }
}

/// 它会展示一个列表，用于列表选择的场景
class SimpleDialogWidget extends StatelessWidget {
  Future<void> changeLanguage(BuildContext context) async {
    int i = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("请选择语言"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  // 返回 1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("简体中文"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回 2
                  Navigator.of(context).pop(2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("美式英文"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回 2
                  Navigator.of(context).pop(3);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("英式英文"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回 2
                  Navigator.of(context).pop(4);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text("繁体中文"),
                ),
              )
            ],
          );
        });
    if (i != null) {
      print("选择的语言为： $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          changeLanguage(context);
        },
        child: Text("切换语言"),
      ),
    );
  }
}

/// 由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
/// 这就导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）

/// 可以显示延迟加载控件的 Dialog ，AlertDialog 和 SimpleDialog 内部都用到了 Dialog 类
class MyDialog extends StatelessWidget {
  Future<void> showListDialog(BuildContext context) async {
    // showModalBottomSheet 可以弹出一个Material风格的底部菜单列表模态对话框
    int index = await showDialog(
        context: context,
        builder: (context) {
          var child = Column(
            children: [
              ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
                itemCount: 10,
              ))
            ],
          );

          // 这里只能用 Dialog ，不能用 AlertDialog
          return Dialog(
            child: child,
          );
          // 完全可以自定义对话框样式，不一定要用 AlertDialog 、Dialog 、SimpleDialog
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        });
    if (index != null) {
      print("选中的索引为： $index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showListDialog(context);
        },
        child: Text("弹出列表对话框"),
      ),
    );
  }
}

// 通过 showDialog + AlertDialog 来自定义 Loading 框
class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                // 先抵消 showDialog 对宽度的限制
                return UnconstrainedBox(
                  // 再用 SizedBox 限制大小
                  child: SizedBox(
                    width: 280,
                    child: AlertDialog(
                      content: Column(
                        // 在主轴方向占用尽可能的少，默认是max ，会充满全屏
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.only(top: 26),
                            child: Text("正在加载，请稍后..."),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Text("弹出 Loading 框"),
      ),
    );
  }
}

// 日历选择器
class DatePickerWidget extends StatelessWidget {
  Future<DateTime> _showDatePicker(BuildContext context) {
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(Duration(days: 30)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          DateTime dateTime = await _showDatePicker(context);
          if (dateTime != null) {
            print(dateTime.toString());
          }
        },
        child: Text("日历选择器"),
      ),
    );
  }
}
