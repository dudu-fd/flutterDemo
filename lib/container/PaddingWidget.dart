import 'package:flutter/cupertino.dart';

/*
              EdgeInsets 的便捷方法：

    fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的填充
    all(double value) : 所有方向均使用相同数值的填充
    only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)
    symmetric({ vertical, horizontal })：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right
*/

class PaddingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      //上下左右各添加16像素补白
      padding: EdgeInsets.all(16),
      child: Column(
        //显式指定对齐方式为左对齐，排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            //左边添加8像素补白
            padding: const EdgeInsets.only(left: 8),
            child: Text("I am dudu"),
          ),
          Padding(
            //上下各添加8像素补白
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text("I am jack"),
          ),
          Padding(
            // 分别指定四个方向的补白
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text("I am juanjuan"),
          ),
        ],
      ),
    );
  }
}
