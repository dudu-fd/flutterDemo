import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/MyIcons.dart';

/*
*   SliverGridDelegateWithFixedCrossAxisCount({
      @required double crossAxisCount,
      double mainAxisSpacing = 0.0,
      double crossAxisSpacing = 0.0,
      double childAspectRatio = 1.0,
    })
    *
    * crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
      mainAxisSpacing：主轴方向的间距。
      crossAxisSpacing：横轴方向子元素的间距。
      childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
* */

class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FixedCrossGridView();
    // return CountGridView();
    // return MaxCrossGridView();
    return BuilderGridView();
  }
}

class FixedCrossGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // 横向3个子控件，宽高比为1
          crossAxisCount: 3,
          childAspectRatio: 1),
      children: [
        Icon(
          MyIcons.earth,
          color: Colors.blue,
        ),
        Icon(
          MyIcons.venus,
          color: Colors.red,
        ),
        Icon(
          MyIcons.jupiter,
          color: Colors.green,
        ),
        Icon(
          MyIcons.nepture,
          color: Colors.deepOrange,
        ),
        Icon(
          MyIcons.meteorolite,
          color: Colors.yellow,
        ),
        Icon(
          MyIcons.astronaut,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class MaxCrossGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 子元素在横轴上的最大长度为120，宽高比为2
          maxCrossAxisExtent: 120,
          childAspectRatio: 2),
      children: [
        Icon(
          MyIcons.earth,
          color: Colors.blue,
        ),
        Icon(
          MyIcons.venus,
          color: Colors.red,
        ),
        Icon(
          MyIcons.jupiter,
          color: Colors.green,
        ),
        Icon(
          MyIcons.nepture,
          color: Colors.deepOrange,
        ),
        Icon(
          MyIcons.meteorolite,
          color: Colors.yellow,
        ),
        Icon(
          MyIcons.astronaut,
          color: Colors.purple,
        ),
      ],
    );
  }
}

/* 内部使用了 SliverGridDelegateWithFixedCrossAxisCount ，跟 FixedCrossGridView 代码等价*/
class CountGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // 横向3个子控件，宽高比为1
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: [
        Icon(
          MyIcons.earth,
          color: Colors.blue,
        ),
        Icon(
          MyIcons.venus,
          color: Colors.red,
        ),
        Icon(
          MyIcons.jupiter,
          color: Colors.green,
        ),
        Icon(
          MyIcons.nepture,
          color: Colors.deepOrange,
        ),
        Icon(
          MyIcons.meteorolite,
          color: Colors.yellow,
        ),
        Icon(
          MyIcons.astronaut,
          color: Colors.purple,
        ),
      ],
    );
  }
}

/* 内部使用了 SliverGridDelegateWithMaxCrossAxisExtent ，跟 MaxCrossGridView 代码等价*/
class ExtentCrossGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      // 子元素在横轴上的最大长度为120，宽高比为2
      maxCrossAxisExtent: 120,
      childAspectRatio: 2,
      children: [
        Icon(
          MyIcons.earth,
          color: Colors.blue,
        ),
        Icon(
          MyIcons.venus,
          color: Colors.red,
        ),
        Icon(
          MyIcons.jupiter,
          color: Colors.green,
        ),
        Icon(
          MyIcons.nepture,
          color: Colors.deepOrange,
        ),
        Icon(
          MyIcons.meteorolite,
          color: Colors.yellow,
        ),
        Icon(
          MyIcons.astronaut,
          color: Colors.purple,
        ),
      ],
    );
  }
}

class BuilderGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuilderGridViewState();
}

class _BuilderGridViewState extends State<BuilderGridView> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1),
      itemBuilder: (BuildContext context, int index) {
        //如果显示到最后一个并且Icon总数小于200时继续获取数据
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
      itemCount: _icons.length,
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([
          MyIcons.earth,
          MyIcons.venus,
          MyIcons.jupiter,
          MyIcons.nepture,
          MyIcons.planetunknown,
          MyIcons.astronaut,
        ]);
      });
    });
  }
}
