import 'package:flutter/cupertino.dart';

// WillPopScope 用于拦截导航返回按钮及Android物理返回按钮，当返回 true 时出栈，返回 false 时不出栈
class WillPopScopeWidget extends StatefulWidget {
  @override
  _WillPopScopeWidgetState createState() => _WillPopScopeWidgetState();
}

class _WillPopScopeWidgetState extends State<WillPopScopeWidget> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          child: Text("1秒内连续按两次返回键退出"),
          alignment: Alignment.center,
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            print("两次点击间隔超过1秒则重新计时");
            _lastPressedAt = DateTime.now();
            return false;
          }
          print("1秒内连续按两次返回键退出");
          return true;
        });
  }
}
