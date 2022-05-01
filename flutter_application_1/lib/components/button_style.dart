import 'package:flutter/material.dart';

enum ButtonType { Flat, Raised }

class StyleButton {
  static ButtonStyle getStandardButtonStyle(BuildContext cxt, ButtonType type) {
    final wh = MediaQuery.of(cxt).size.width;
    final ht = MediaQuery.of(cxt).size.height;
    final color = Color(0xff6C63FF);
    final border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    final border1 = RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10));
    return ElevatedButton.styleFrom(
        fixedSize: Size(wh * 0.9, 50),
        shape: type == ButtonType.Flat ? border1 : border,
        primary: type == ButtonType.Flat ? Colors.grey[50] : color,
        elevation: type == ButtonType.Flat ? 0 : 10);
  }

  static ButtonStyle getNormalButtonStyle(BuildContext cxt) {
    final wh = MediaQuery.of(cxt).size.width;
    final ht = MediaQuery.of(cxt).size.height;
    final border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

    return ElevatedButton.styleFrom(primary: Colors.blue[400], shape: border);
  }

  static ButtonStyle getOutlinedButtonStyle(BuildContext cxt) {
    final wh = MediaQuery.of(cxt).size.width;
    final ht = MediaQuery.of(cxt).size.height;
    return OutlinedButton.styleFrom(
        primary: Colors.black,
        side: BorderSide(color: Colors.black),
        minimumSize: Size(wh, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))));
  }
}
