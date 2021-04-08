import 'package:flutter/material.dart';
import 'package:flutter_demo/function/ColorAndThemeWidget.dart';
import 'package:flutter_demo/function/InheritedCounterWidget.dart';
import 'package:flutter_demo/function/ProviderWidget.dart';
import 'package:flutter_demo/function/WillPopScopeWidget.dart';
import 'package:flutter_demo/widget/widget_practice.dart';


void main() {
  runApp(MyApp());
}

/*
* MaterialApp 大部分情况下要作为 Flutter 的 根 Widget，并且 MaterialApp 和 Scaffold 经常是一起搭配使用的。
* */

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",  //出现在 Android 的任务管理器上或者是 iOS 程序切换管理器中
      color: Colors.lightGreen, // title 的字体颜色
      // home: Scaffold(
      //   appBar: AppBar(title: Text("Flutter Demo"),),
      //   // body:WillPopScopeWidget(),
      //   // body:InheritedCounterWidget(),
      //   // body:CartWidget(),
      //   body:ColorAndThemeWidget(),
      // ),
      home: ThemeWidget(),
    );
  }
}




