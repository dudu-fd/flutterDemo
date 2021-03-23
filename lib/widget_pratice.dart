import 'package:flutter/material.dart';

class Echo extends StatelessWidget {
  final String text;

  final Color backgroundColor;

  //构造函数约定规则： const 修饰 ,key 放在首位，必要参数用@required修饰，child放在最后
  const Echo({Key key, @required this.text, this.backgroundColor: Colors.grey})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }

}