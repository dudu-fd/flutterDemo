import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/* DecoratedBox 用于给子控件绘制前或后绘制一些装饰 */
class DecoratedBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
            //线性渐变
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, offset: Offset(2, 2), blurRadius: 4)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
