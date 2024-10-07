
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor{

  static final  primaryColor = Color(0xffddebf2);
  static final  secondaryColor = Color(0xffeef3f5);
  static final blueColor = Color(0xff3f64f4);
}

TextStyle mTextStyle12({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
      color: mColor,
      fontWeight: mFontWeight,
      fontSize: 12,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle14({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
      color: mColor,
      fontWeight: mFontWeight,
      fontSize: 14,
      fontFamily: 'mainFont'
  );
}

TextStyle mTextStyle16({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
      color: mColor,
      fontWeight: mFontWeight,
      fontSize: 16,
      fontFamily: 'mainFont'
  );
}
TextStyle mTextStyle25({
  Color mColor = Colors.black,
  mFontWeight = FontWeight.normal,
}) {
  return TextStyle(
      color: mColor,
      fontWeight: mFontWeight,
      fontSize: 25,
      fontFamily: 'mainFont'
  );
}