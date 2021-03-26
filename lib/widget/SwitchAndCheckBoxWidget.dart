import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchAndCheckBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchAndCheckBoxWidgetState();
}

/* 控件的状态由父组件来维护*/
class _SwitchAndCheckBoxWidgetState extends State<SwitchAndCheckBoxWidget> {
  bool _switchSelected = true; // 维护单选开关状态
  bool _checkboxSelected = true; // 维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: _switchSelected,
          onChanged: (bool value) {
            setState(() {
              _switchSelected = value;
            });
          },
          activeTrackColor: Colors.green,
          inactiveTrackColor: Colors.yellow,
          activeColor: Colors.black,
          inactiveThumbColor: Colors.red,
        ),
        Checkbox(
          value: _checkboxSelected,
          onChanged: (value) {
            print(value);
            // 不调用 setState 则 UI 一直不变，本身不维护状态
            setState(() {
              _checkboxSelected = value;
            });
          },
          activeColor: Colors.green,
        )
      ],
    );
  }
}
