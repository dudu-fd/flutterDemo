import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/*
  data:                 String	              要显示的文字
  style:	              TextStyle	            文本样式
  strutStyle:	          StrutStyle	          设置每行的最小行高
  textAlign:	          TextAlign	            文本的对齐方式	，只有 Widget 的大小大于文本内容时才有意义
  textDirection:	      TextDirection	        文字方向
  locale:	              Locale	              用于选择用户语言和格式设置首选项的标识符
  softWrap:	            bool	                是否支持软换行符，如果是 false 的话，这个文本只有一行，水平方向是无限的
  overflow:	            TextOverflow	        文本的截断方式
  textScaleFactor:    	double	              代表文本相对于当前字体大小的缩放因子，默认值为1.0，字体大小会跟随系统字体大小而变化
  maxLines:	            int	                  显示的最大行数
*/

/*
  inherit:	            bool	                是否继承父 Text 的样式，默认为 true
  color:	              Color	                文字的颜色
  fontSize:	            double	              文字的大小，不会跟随系统字体大小而变化
  fontWeight:	          FontWeight	          字体粗细
  fontStyle:	          FontStyle	            是否倾斜字形
  letterSpacing:	      double	              字母之间的间隔
  wordSpacing:	        double	              单词之间的间隔
  textBaseline:	        TextBaseline	        用于对齐文本的水平线
  height:	              double	              文本的高度，是一个因子，具体的行高等于 fontSize*height
  foreground:	          Paint	                文本的前景色，跟 color 属性有冲突，只能存在一个
  background:	          Paint	                文本的背景色
  shadows:	            List< ui.Shadow>	    在文本下方绘制阴影
  decoration:	          TextDecoration	      文本的线条，上中下3种划线
  decorationColor:	    Color	                TextDecoration 线条的颜色
  decorationStyle:	    TextDecorationStyle	  TextDecoration 线条的样式
  decorationThickness:	double	              TextDecoration 线条的大小
  fontFamily:	          String	              用于设置使用哪种自定义字体
  fontFamilyFallback:	  String	              字体列表，当前面的字体找不到时，会在这个列表里依次查找
  package:	            String	              用于设置使用哪种自定义字体
*/

// ------------------- Text Widget 练习 -------------------

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return TextOutTextStyle();
    return TextInTextStyle();
    // return TextSpanWidget();
    // return TextInDefaultStyleWidget();
  }
}

/*带 TextStyle 的 Text */
class TextInTextStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello world! I am dudu ggg" * 4,
      style: TextStyle(
        inherit: false,
        // color: Colors.blue,
        // background: Paint()..color = Colors.yellow,
        fontSize: 22,
        // 感觉默认字体为14
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic,
        letterSpacing: 0,
        wordSpacing: 5,
        textBaseline: TextBaseline.ideographic,
        height: 1.6,
        foreground: Paint()..color = Colors.red,
        decoration: TextDecoration.underline,
        decorationColor: Colors.blue,
        decorationStyle: TextDecorationStyle.wavy,
        decorationThickness: 1.6,
        fontFamily: "SourceSansPro",
        shadows: [
          BoxShadow(
              offset: Offset(5, 5), color: Colors.lightGreen, blurRadius: 3),
        ],
      ),
    );
  }
}

/*不带 TextStyle 的 Text */
class TextOutTextStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello world! I am dudu ",
      textAlign: TextAlign.start,
      // justify 类型会适当的拉伸，以至于充满宽度
      maxLines: 10,
      textDirection: TextDirection.rtl,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.5,
    );
  }
}

/*带有 TextSpan 的 Text */
class TextInSpanWidget extends StatelessWidget {
  final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Text.rich(
        TextSpan(children: [
          TextSpan(text: "Home:"),
          TextSpan(
              text: "https://flutterchina.club",
              style: TextStyle(color: Colors.blue),
              recognizer: gestureRecognizer
                ..onTap = () {
                  // 这里要用 Builder 的 context 才能找到 ScaffoldMessenger 实例
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("点击了")));
                })
        ]),
        textScaleFactor: 2,
      );
    });
  }
}

/*带有默认样式的 Text */
class TextInDefaultStyleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
          color: Colors.blue, fontSize: 30, fontFamily: "SourceSansPro"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("hello world"),
          Text("I am dudu"),
          Text(
            "you are nice",
            style: TextStyle(inherit: false, color: Colors.grey),
          ), // 不继续默认样式
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
