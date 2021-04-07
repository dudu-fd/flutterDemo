import 'package:flutter/material.dart';
import 'package:flutter_demo/container/BoxWidget.dart';
import 'package:flutter_demo/container/ContainerWidget.dart';
import 'package:flutter_demo/container/DecoratedBoxWidget.dart';
import 'package:flutter_demo/container/PaddingWidget.dart';
import 'package:flutter_demo/container/TransformWidget.dart';
import 'package:flutter_demo/layout/AlignAndCenterWidget.dart';
import 'package:flutter_demo/layout/FlexWidget.dart';
import 'package:flutter_demo/layout/FlowAndWrapWidget.dart';
import 'package:flutter_demo/layout/RowAndColumnWidget.dart';
import 'package:flutter_demo/widget/ButtonWidget.dart';
import 'package:flutter_demo/widget/ImageAndIconWidget.dart';
import 'package:flutter_demo/widget/ProgressIndicatorWidget.dart';
import 'package:flutter_demo/widget/SwitchAndCheckBoxWidget.dart';
import 'package:flutter_demo/widget/TextFieldAndFormWidget.dart';
import 'package:flutter_demo/widget/TextWidget.dart';


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
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Demo"),),
        // body:TextWidget(),
        // body:ButtonWidget(),
        // body:ImageOrIconWidget(),
        // body:SwitchAndCheckBoxWidget(),
        // body:TextFieldAndFormWidget(),
        // body:ProgressIndicatorWidget(),
        // body:ProgessIndicatorInAnimation(),
        // body:RowAndColumnWidget(),
        // body:FlexWidget(),
        // body:FlowAndWrapWidget(),
        // body:StackAndPositionedWidget(),
        // body:AlignAndCenterWidget(),
        // body:PaddingWidget(),
        // body:BoxWidget(),
        // body:DecoratedBoxWidget(),
        // body:TransformWidget(),
        body:ContainerWidget(),
      ),
    );
  }
}




