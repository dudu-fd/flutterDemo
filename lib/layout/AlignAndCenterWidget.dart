
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* 代码演示 */
class AlignAndCenterWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return AlignWidget();
  }
}

class AlignWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,height: 120,
          color: Colors.blue[50],
          child: Align(
            alignment: Alignment.topRight,
            child: FlutterLogo(size: 60,),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Container(
          color: Colors.blue[50],
          child: Align(
            alignment: Alignment.topRight,
            widthFactor: 2,
            heightFactor: 2,
            child: FlutterLogo(size: 60,),
          ),
        )
      ],),
    );
  }
}