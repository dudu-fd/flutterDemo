import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/widget_practice.dart';

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
        // body: Echo(text: "hello world",),
        // body: ContextRoute(),
        body: CounterWidget(initValue: 11,),
        // body:ShowSnackBarWidget(),
        // body:TapboxA(),
        // body:ParentWidget(),
        // body: ParentWidgetC(),
      ),
    );
  }
}




