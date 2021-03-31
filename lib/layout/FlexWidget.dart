import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* Flex 通常要配合 Expanded 使用，允许子组件按照一定比例来分配父容器空间*/
class FlexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Flex 的子控件按 1:2:1 来占据水平空间
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  height: 30,
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black,
                  height: 30,
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.redAccent,
                  height: 30,
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            // Flex 的子控件在垂直方向按 2:1:1 来占用 100 像素的空间
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
                    height: 30,
                    color: Colors.yellow,
                  ),
                  flex: 2,
                ),
                // Spacer 是 Expanded 的一个包装类
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    color: Colors.purple,
                    height: 30,
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
