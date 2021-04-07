import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    BoxConstraints 用于对子控件添加额外的约束
    SizedBox 用于给子控件指定固定的宽高
 */

class BoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ConstrainedAndSizeBoxWidget();
    return UnConstrainedBoxWidget();
  }
}

class ConstrainedAndSizeBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints:
              // BoxConstraints(minWidth: double.infinity, minHeight: 50 // 最小高度为50元素
              //     ),
              // BoxConstraints.tight(Size(50,60)),// 最小最大约束都为给定值
              // BoxConstraints.loose(Size(50,60)), // 最小约束为0，最大约束为给定值
              // 给定了宽高，则最小最大约束皆为给定值，否则最小约束为0，最大约束为无限大
              // BoxConstraints.tightFor(height: 60),
              // 给定了宽高，则最小最大约束皆为给定值，否则最小最大约束皆为无限大
              // BoxConstraints.expand(height: 60),
              // 给定了宽高，则最大约束皆为给定值，最小约束不为无限大则为固定值，否则为0
              BoxConstraints.tightForFinite(height: 60),
          child: Container(
            height: 15, // 高度小于50，会以最小约束为准，超过最小约束，则以自身为准
            width: 15,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: 80,
          child: Container(
            height: 15, // 高度小于50，会以最小约束为准，超过最小约束，则以自身为准
            width: 15,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
        ),
        ConstrainedBox(
          // 多重约束限制，minWidth 和 minHeight 是取父子约束中数值相应 较大 的
          constraints: BoxConstraints(minWidth: 90, minHeight: 70),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60, minHeight: 20),
            child: Container(
              height: 15,
              width: 15,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ConstrainedBox(
          // 多重约束限制，maxWidth 和 maxHeight 是取父子约束中数值相应 较小 的
          constraints: BoxConstraints(maxWidth: 90, maxHeight: 70),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 70, maxHeight: 20),
            child: Container(
              height: 100,
              width: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ),
          ),
        )
      ],
    );
  }
}

/* UnConstrainedBoxWidget 不会对子组件产生任何约束限制，它允许子组件按照其自身大小绘制，如果有父组件约束，会去掉其约束*/
class UnConstrainedBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          // 这里根据比重约束规则 ，最后显示的宽高为 90*100
          constraints: BoxConstraints(minWidth: 60, minHeight: 100),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90, minHeight: 20),
            child: Container(
              height: 15,
              width: 15,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60, minHeight: 100),
          // 这里嵌套了一层 UnconstrainedBox ，会去除父组件的约束，最后显示的宽高其实也为 90*100，但是绘制的内容是 90*20
          // 所以并不是真正的去除，只是约束给了 UnconstrainedBox ，子控件则按自身大小绘制，实际占用大小不变
          // 当使用 SizeBox 和 ConstraintsBox 给子控件指定宽高不生效时，可以嵌套一层 UnconstrainedBox 去除约束
          child: UnconstrainedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90, minHeight: 20),
              child: Container(
                height: 15,
                width: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
