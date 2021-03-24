import 'package:flutter/material.dart';
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
        body:TextWidget(),
      ),
    );
  }
}




