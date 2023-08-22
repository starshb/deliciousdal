import 'package:deliciousdal/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  dynamic keyboardType;
  final String? Function(String?)? validator;

  CustomTextFormField({
    this.validator,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ));

    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText, //비밀번호 입력시 가림
      autofocus: autofocus,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
