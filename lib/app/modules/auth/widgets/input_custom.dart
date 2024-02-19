import 'package:crowfunding_app_with_bloc/app/global_styles/animated/fade_scale.dart';
import 'package:flutter/material.dart';

class InputAuthCustom extends StatelessWidget {
  final TextEditingController textController;
  final String hinText;
  final Icon icon;
  final bool obscureText;
  final EdgeInsets margin;
  final Function(String value)? onChange;
  const InputAuthCustom({
    super.key,
    required this.textController,
    required this.hinText,
    required this.icon,
    this.obscureText = false,
    this.margin = const EdgeInsets.only(left: 16.0, right: 32.0),
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return FadeScale(
      child: Container(
        margin: margin,
        child: TextField(
          controller: textController,
          cursorColor: Colors.black,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: icon,
            hintText: hinText,
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
