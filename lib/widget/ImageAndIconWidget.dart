import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/MyIcons.dart';

/*
    scale:            	double	        图形显示的比例
    width:      	      double	        图片的宽，如果不指定，则图像将选择最佳大小显示，而且会保留其固有宽高比的大小
    height:     	      double	        图片的高，同上 width ，宽高最好只设置其中一个，另一个通过比例缩放即可
    color:            	Color	          图片的混合色值
    colorBlendMode:   	BlendMode     	图片与颜色的混合模式
    fit:              	BoxFit	        用于在图片的显示空间和图片本身大小不同时指定图片的适应模式
    alignment:        	Alignment	      图片的对齐方式
    repeat:           	ImageRepeat    	当图片本身大小小于显示空间时，指定图片的重复规则
    centerSlice:      	Rect	          在这个矩形范围内的图片会被当成.9的图片
    matchTextDirection	bool	          图片的绘制方向，true:从左往右，false:从右往左
    gaplessPlayback	    bool	          当图像提供者更改时，true：继续显示旧图像，false：简单地显示任何内容
    filterQuality	      FilterQuality	  设置图片的过滤质量
*/

/*
    BoxFit.fill	      会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
    BoxFit.contain	  默认使用规则，图片会按比例缩放以适应当前显示空间，不会变形。
    BoxFit.cover	    会按比例缩放后居中填满空间，图片不会变形，超出显示空间部分会被剪裁
    BoxFit.fitWidth	  图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。(优先适应宽)
    BoxFit.fitHeight	图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。(优先适应高)
    BoxFit.none	      不用适应策略，会在显示空间内中间显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分
*/

class ImageOrIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ImageWidget();
    return IconsWidget();
  }
}

/*图片 Image 演示*/
class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              width: 350,
              height: 350,
              color: Colors.blue,
              child: Image(
                image: AssetImage("images/sea.png"),
                width: 200,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                filterQuality: FilterQuality.high,
              )),
          Container(
              width: 150,
              height: 150,
              color: Colors.blue,
              child: Image.asset( // 使用命名构造的方式
                "images/mouse.png",
                width: 200,
                fit: BoxFit.fitWidth,
                color: Colors.black,
                colorBlendMode: BlendMode.dst,
              )),
        ],
      ),
    );
  }
}

/*图片 Icon 演示*/
class IconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.accessible,
          color: Colors.green,
          size: 60,
        ),
        Icon(
          Icons.accessibility,
          color: Colors.indigo,
          size: 60,
        ),
        Icon(
          Icons.account_circle_outlined,
          color: Colors.yellow,
          size: 60,
        ),
        Icon(
          MyIcons.BodyCheck,
          color: Colors.indigo,
          size: 60,
        ),
        Icon(
          MyIcons.Car,
          color: Colors.yellow,
          size: 60,
        ),
        Icon(
          MyIcons.Location,
          color: Colors.red,
          size: 60,
        ),
      ],
    );
  }
}
