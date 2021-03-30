import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    value:         	        double	                 表示当前的进度，范围为 [0,1]，如果为 null 则为模糊进度(循环动画)
    backgroundColor:        Color                    指定器的背景色
    valueColor:         	  Animation<Color?>	       进度条的颜色，可指定动画，纯色可用 AlwaysStoppedAnimation 来指定
    minHeight:          	  double	                 线性进度条的最小高度
    strokeWidth:       	    double	                 圆形进度条的线宽
*/

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              // 外边通过 SizedBox 来限制了大小，这里不再生效，优先取父容器的尺寸作为绘制的边界
              minHeight: 15,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.green),
            minHeight: 5,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          SizedBox(
            width: 100,
            height: 130,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
              strokeWidth: 5,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          CircularProgressIndicator(
            value: 0.8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
            strokeWidth: 5,
          )
        ],
      ),
    );
  }
}

/*从灰色变成蓝色的带动画的线性进度条*/
class ProgessIndicatorInAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProgessIndicatorInAnimationState();
}

class _ProgessIndicatorInAnimationState
    extends State<ProgessIndicatorInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // 动画执行时间3秒
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..forward()
          ..addListener(() {
            print(_animationController.value);
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              minHeight: 5,
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          )
        ],
      ),
    );
  }
}
