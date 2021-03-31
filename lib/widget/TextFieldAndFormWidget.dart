import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/MyIcons.dart';

/*
    controller:         	  TextEditingController	        控制 TextField 的编辑，如果没有设置，会有默认值，大多数情况下都要显式提供一个
    focusNode:          	  FocusNode                     用于控制 TextField 是否占有当前键盘的输入焦点
    decoration:         	  InputDecoration	              用于控制TextField的外观显示，如提示文本、背景颜色、边框等
    textAlign:          	  TextAlign	                    文本的对齐方式
    keyboardType:       	  TextInputType	                用于设置该输入框默认的键盘输入类型
    textInputAction:    	  TextInputAction               键盘动作及按钮图标(即回车键位图标)
    style：              	  TextStyle	                    文本样式
    autofocus：          	  bool	                        是否自动获取焦点，默认为 false
    obscureText:        	  bool	                        是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换
    maxLines:           	  int	                          显示的最大行数
    maxLength:          	  int	                          输入框中允许的最大字符数
    maxLengthEnforcement	  MaxLengthEnforcement	        是否强制限制最大字符数
    onChange:           	  ValueChanged	                输入框内容改变时的回调函数
    onEditingComplete：  	  VoidCallback	                输入框输入完成时触发，但是onEditingComplete没有参数，不会返回内容
    onSubmitted：        	  ValueChanged	                输入框输入完成时触发，但是onSubmitted有参数，会返回内容
    inputFormatters：    	  List< TextInputFormatter>     用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验
    enabled:            	  bool	                        输入框是否禁用
    cursorWidth	:           double	                      自定义输入框光标宽度
    cursorRadius:       	  Radius	                      自定义输入框光标圆角
    cursorColor:        	  Color	                        自定义输入框光标颜色
*/

/*                InputDecoration 的主要参数及作用

    icon:         	        Icon	                   输入框前面的图标，会在下滑线外边
    prefixIcon:          	  Icon                     输入框前面的图标，会在下滑线里边
    suffixIcon:         	  Icon	                   输入框后面的图标，会在下滑线里边
    labelText:          	  String	                 输入框上边的提示文本
    helperText:       	    String	                 输入框下边的提示文本
    hintText:    	          String                   输入框中间的提示文本
    enabledBorder：         InputBorder	             输入框正常没被禁用时的边框
    focusedBorder：         InputBorder	             输入框获得焦点时的边框
    focusedErrorBorder:     InputBorder	             输入框获取焦点且错误状态(如字体超限)时的边框
    errorBorder:           	InputBorder	             输入框错误状态但没有获取焦点时的边框
    ... 属性过多，用到的时候再补充
*/

class TextFieldAndFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return TextFieldWidget();
    return FormWidget();
  }
}

class TextFieldWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  // 监听输入框的控制器
  final TextEditingController _controller =
      TextEditingController(text: "123456789");

  // 用于控制焦点的移动等
  FocusScopeNode _focusScopeNode;

  // 焦点对象
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  // 这里要给默认 false ，不然默认是 null ，会报错
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    // 从第三个字符开始选中后面的字符
    _controller.selection =
        TextSelection(baseOffset: 2, extentOffset: _controller.text.length);
    // 焦点监听事件
    _focusNode1.addListener(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_focusNode1.hasFocus.toString())));
    });
    _focusNode2.addListener(() {
      setState(() {
        _hasFocus = _focusNode2.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          keyboardType: TextInputType.phone,
          cursorColor: Colors.green,
          // showCursor: true,
          // cursorHeight: 100,
          // cursorWidth: 5,
          cursorRadius: Radius.circular(10),
          decoration: InputDecoration(
              icon: Icon(MyIcons.Car),
              // prefixIcon: Icon(MyIcons.Location),
              // suffixIcon: Icon(MyIcons.BodyCheck),
              labelText: "用户名",
              helperText: "手机号",
              hintText: "请输入手机号",
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
          controller: _controller,
          focusNode: _focusNode1,
        ),
        TextField(
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 25, fontFamily: "SourceSansPro"),
          maxLines: 1,
          maxLength: 10,
          decoration: InputDecoration(
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purpleAccent))),
          maxLengthEnforcement: MaxLengthEnforcement.none,
          enableInteractiveSelection: true,
          // readOnly: true,
        ),
        Container(
          child: TextField(
            obscureText: true,
            focusNode: _focusNode2,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
                labelText: "密码",
                prefixIcon: Icon(MyIcons.Location),
                border: InputBorder.none),
            // enabled: false,
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _hasFocus ? Colors.blue : Colors.yellow))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_focusScopeNode == null) {
                    _focusScopeNode = FocusScope.of(context);
                  }
                  _focusScopeNode.requestFocus(_focusNode2);
                },
                child: Text("移动焦点")),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
            ElevatedButton(
                onPressed: () {
                  // 当所有输入框失去焦点时，键盘就会收起
                  _focusNode1.unfocus();
                  _focusNode2.unfocus();
                },
                child: Text("隐藏键盘"))
          ],
        )
      ],
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Form(
        // 设置 GlobalKey，用于后面获取 FormState
        key: _formKey,
        // 开启自动校验
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _userNameController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.account_circle)),
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)),
              obscureText: true,
              validator: (v) {
                return v.trim().trim().length > 5 ? null : "密码不能少于6位";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text(
                      "登录",
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () {
                      // 数据验证全都通过，才返回 true
                      if ((_formKey.currentState as FormState).validate()) {
                        // 验证通过，提交数据
                        print("登录成功");
                      }
                    },
                  )),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                      child: ElevatedButton(
                    child: Text(
                      "重置数据",
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () {
                      // 重置数据
                      (_formKey.currentState as FormState).reset();
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
