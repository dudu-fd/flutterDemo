import 'package:flutter/material.dart';
import 'package:flutter_demo/widget_pratice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: Scaffold(
        body: Echo(text: "hello world",),
      ),
    );
  }
}




