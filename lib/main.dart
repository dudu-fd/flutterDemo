import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/ButtonWidget.dart';
import 'package:flutter_demo/widget/ImageAndIconWidget.dart';
import 'package:flutter_demo/widget/ProgressIndicatorWidget.dart';
import 'package:flutter_demo/widget/SwitchAndCheckBoxWidget.dart';
import 'package:flutter_demo/widget/TextFieldAndFormWidget.dart';
import 'package:flutter_demo/widget/TextWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Demo"),),
        // body:TextWidget(),
        // body:ButtonWidget(),
        // body:ImageOrIconWidget(),
        // body:SwitchAndCheckBoxWidget(),
        // body:TextFieldAndFormWidget(),
        body:ProgressIndicatorWidget(),
        // body:ProgessIndicatorInAnimation(),
      ),
    );
  }
}




