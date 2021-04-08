import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/MyIcons.dart';

class ColorAndThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ColorWidget();
    // return NavBarTestWidget();
    // return MaterialColorWidget();
    return ThemeWidget();
  }
}

class ColorItem {
  final int index;

  final int color;

  ColorItem(this.index, this.color);
}

class MaterialColorWidget extends StatelessWidget {
  final List<ColorItem> _blueColors = [
    ColorItem(50, 0xFFE3F2FD),
    ColorItem(100, 0xFFBBDEFB),
    ColorItem(200, 0xFF90CAF9),
    ColorItem(300, 0xFF64B5F6),
    ColorItem(400, 0xFF42A5F5),
    ColorItem(500, 0xFF2196F3),
    ColorItem(600, 0xFF1E88E5),
    ColorItem(700, 0xFF1976D2),
    ColorItem(800, 0xFF1565C0),
    ColorItem(900, 0xFF0D47A1)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _blueColors
          .map((e) => Container(
                color: Color(e.color),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    // 通过 Positioned 的方式来定位
                    Positioned(
                      child: Text(
                        e.index.toString(),
                        style: TextStyle(
                            // 如果比 0.3 还要浅，就显示黑色值
                            color: Color(e.color).computeLuminance() > 0.3
                                ? Colors.black
                                : Colors.white),
                      ),
                      left: 16,
                    ),
                    // 通过 Align 的方式来定位
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "#${e.color.toRadixString(16).toUpperCase()}",
                          style: TextStyle(
                              // 如果比 0.3 还要浅，就显示黑色值
                              color: Color(e.color).computeLuminance() > 0.3
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class ColorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = "dc380d";
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          "颜色",
          style: TextStyle(
              // 将颜色字符串转成 Color 对象
              color: Color(int.parse(color, radix: 16)).withAlpha(255)),
        ));
  }
}

class NavBar extends StatelessWidget {
  final Color color;

  final String title;

  NavBar(this.color, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            // computeLuminance()方法，它返回一个[0-1]的一个值，数字越大颜色就越浅
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}

class NavBarTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(Colors.blue, "标题"),
        NavBar(Colors.white, "标题"),
      ],
    );
  }
}

class ThemeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeWidgetState();
}

// 换肤功能
class _ThemeWidgetState extends State<ThemeWidget> {
  Color _themeColor = Colors.teal; // 当前路由主题颜色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
            // 用于导航栏、FloatingActionButton的背景色等
            primarySwatch: _themeColor,
            // 用于 Icon 的颜色
            iconTheme: IconThemeData(color: _themeColor)),
        child: Scaffold(
          appBar: AppBar(
            title: Text("主题测试"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //第一行 Icon 使用主题中的 iconTheme
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(MyIcons.Location),
                  Icon(MyIcons.Car),
                  Text("颜色跟随主题")
                ],
              ),
              //为第二行Icon自定义颜色（固定为黑色)
              Theme(
                  // 局部主题覆盖全局主题
                  data: themeData.copyWith(
                      iconTheme:
                          themeData.iconTheme.copyWith(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MyIcons.Location),
                      Icon(MyIcons.Car),
                      Text("颜色跟随主题")
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.palette),
            onPressed: () {
              setState(() {
                // 切换主题
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
          ),
        ));
  }
}
