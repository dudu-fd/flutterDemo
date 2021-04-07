import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      "images/sea.png",
      width: 100,
    );
    return Center(
      child: Column(
        children: [
          // avatar, // 不裁剪
          ClipOval(
              // child: avatar,
              ), // 裁剪为椭圆或圆形
          ClipRRect(
            // 裁剪为圆角矩形
            // child: avatar,
            borderRadius: BorderRadius.circular(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.5, // 宽度设为原来一半，另一半会溢出，但还是会显示出来
                child: avatar,
              ),
              Text(
                "你好嘟嘟",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                // 将溢出部分裁剪掉
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5, // 宽度设为原来一半，另一半会溢出
                  child: avatar,
                ),
              ),
              Text(
                "你好嘟嘟",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: ClipRect(
              clipper: MyClipper(), // 使用自定义的 clipper
              child: avatar,
            ),
          )
        ],
      ),
    );
  }
}

/* 裁剪是在 layout 完成后的绘制阶段进行的，所以不会影响其大小，跟 Transform 原理相似*/
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10, 30, 40, 30); // 裁剪区域

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) =>
      false; // 是否重新裁剪

}
