import 'package:flutter/material.dart';

//import '../utils/reference_utils.dart';

class CustomInputDecorator {
  static InputDecoration getStandardInputDecoration(BuildContext context,
      [bool invert = false]) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1, color: Colors.grey[300]!));
    final style = TextStyle(color: Colors.grey[400], fontSize: 15);
    return InputDecoration(
      border: border,
      focusedBorder: border.copyWith(
          borderSide: BorderSide(color: Color(0xff6C63FF), width: 2)),
      enabledBorder: border,
      errorBorder:
          border.copyWith(borderSide: BorderSide(color: Colors.red, width: 2)),
      focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.black, width: 2)),
      fillColor: Colors.grey[50],
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      counterStyle: style,
      suffixStyle: style,
      errorStyle: style.copyWith(fontWeight: FontWeight.bold),
      helperStyle: style,
      hintStyle: style,
      labelStyle: style.copyWith(fontWeight: FontWeight.bold),
      prefixStyle: style,
    );
  }
}
