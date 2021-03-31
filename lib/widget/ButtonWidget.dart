import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*                          ButtonStyle 的主要参数及作用

    textStyle:            	MaterialStateProperty<TextStyle?>	                  TextStyle 所有的属性都可以用，要是设置文本的
    backgroundColor:      	MaterialStateProperty<Color?>      	                设置按钮的背景色
    foregroundColor:     	  MaterialStateProperty<Color?>    	                  前景色，如果 textStyle 已经设置，优先用 textStyle 的
    shadowColor:            MaterialStateProperty<Color?>		                    阴影颜色
    elevation:   	          MaterialStateProperty<double?>     	                阴影大小
    padding:              	MaterialStateProperty<EdgeInsetsGeometry?>	        按钮的填充
    minimumSize:        	  MaterialStateProperty<Size?>Alignment	              按钮最小的大小
    side:           	      MaterialStateProperty<BorderSide?>    	            边框
    shape:      	          MaterialStateProperty<OutlinedBorder?>	            外形样式
    alignment	              AlignmentGeometry?	                                按钮文本的对齐方式
*/

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonInIconWidget();
    // return ElevatedButtonWidget();
    // return TextButtonWidget();
    // return OutlinedButtonWidget();
    // return IconButtonWidget();
  }
}

/*带图标的 Button 演示*/
class ButtonInIconWidget extends StatelessWidget {
  final ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 32,
          foreground: Paint()..color = Colors.black,
          background: Paint()..color = Colors.limeAccent)),
      foregroundColor: MaterialStateProperty.all(Colors.yellow),
      overlayColor: MaterialStateProperty.all(Colors.green),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      // elevation: MaterialStateProperty.all(15.0),
      shadowColor: MaterialStateProperty.all(Colors.yellow),
      padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0)),
      // minimumSize: MaterialStateProperty.all(Size(120, 100)),
      // side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent,width: 5)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(Radius.circular(30)))),
          borderRadius: BorderRadius.circular(20))),
      enableFeedback: true,
      animationDuration: Duration(seconds: 100),
      alignment: Alignment.center);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.alarm),
        label: Text(
          "dudu",
        ),
        style: style,
      ),
    );
  }
}

/* 悬浮带阴影的 ElevatedButton 演示*/
class ElevatedButtonWidget extends StatelessWidget {
  final ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 32, foreground: Paint()..color = Colors.black)),
      foregroundColor: MaterialStateProperty.all(Colors.red),
      overlayColor: MaterialStateProperty.all(Colors.green),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      elevation: MaterialStateProperty.all(15.0),
      shadowColor: MaterialStateProperty.all(Colors.yellow),
      // padding: MaterialStateProperty.all(
      // EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0)),
      minimumSize: MaterialStateProperty.all(Size(120, 100)),
      // side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent,width: 5)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15)))),
      enableFeedback: true,
      animationDuration: Duration(seconds: 100),
      alignment: Alignment.center);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "dudu",
        ),
        style: style,
      ),
    );
  }
}

/* 平铺的 TextButton 演示*/
class TextButtonWidget extends StatelessWidget {
  final ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 32, foreground: Paint()..color = Colors.black)),
      // foregroundColor: MaterialStateProperty.all(Colors.red),
      overlayColor: MaterialStateProperty.all(Colors.green),
      // backgroundColor: MaterialStateProperty.all(Colors.blue),
      // elevation: MaterialStateProperty.all(15.0),
      // shadowColor: MaterialStateProperty.all(Colors.yellow),
      padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0)),
      // minimumSize: MaterialStateProperty.all(Size(120, 100)),
      side: MaterialStateProperty.all(
          BorderSide(color: Colors.deepPurpleAccent, width: 5)),
      // shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.elliptical(15, 15)))),
      // enableFeedback: true,
      // animationDuration: Duration(seconds: 100),
      alignment: Alignment.center);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text(
          "dudu",
        ),
        style: style,
      ),
    );
  }
}

/*带边框的 OutlinedButton 演示*/
class OutlinedButtonWidget extends StatelessWidget {
  final ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 32, foreground: Paint()..color = Colors.black)),
      // foregroundColor: MaterialStateProperty.all(Colors.red),
      overlayColor: MaterialStateProperty.all(Colors.green),
      // backgroundColor: MaterialStateProperty.all(Colors.blue),
      // elevation: MaterialStateProperty.all(15.0),
      // shadowColor: MaterialStateProperty.all(Colors.yellow),
      // padding: MaterialStateProperty.all(
      //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0)),
      // minimumSize: MaterialStateProperty.all(Size(120, 100)),
      // side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent,width: 5)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15)))),
      // enableFeedback: true,
      // animationDuration: Duration(seconds: 100),
      alignment: Alignment.center);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          "dudu",
        ),
        style: style,
      ),
    );
  }
}

/*图片 IconButton 演示*/
class IconButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.account_tree_rounded),
      ),
    );
  }
}
