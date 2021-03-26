import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldAndFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFieldWidget();
  }
}

class TextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          keyboardType: TextInputType.phone,
          cursorColor: Colors.green,
        ),
        TextField(
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 30, fontFamily: "SourceSansPro"),
          maxLines: 1,
          maxLength: 10,
          // readOnly: true,
        ),
        TextField(
          obscureText: true,
        ),
      ],
    );
  }
}
