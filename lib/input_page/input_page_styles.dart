import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

double appBarHeight(BuildContext context) {
  return screenAwareSize(80.0, context) + MediaQuery
      .of(context)
      .padding
      .top;
}

double getBlockSizeVertical(BuildContext context) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);
  double screenHeight = _mediaQueryData.size.height;

  return screenHeight / 100 * 20;
}

double getSafeBlockHorizontal(BuildContext context, int size) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);
  _mediaQueryData = MediaQuery.of(context);
  double screenWidth = _mediaQueryData.size.width;
  double _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
  return screenWidth - _safeAreaHorizontal / 100 * size;
}

//static MediaQueryData _mediaQueryData;
//static double screenWidth;
//static double screenHeight;
//static double blockSizeHorizontal;
//static double blockSizeVertical;
//
//static double _safeAreaHorizontal;
//static double _safeAreaVertical;
//static double safeBlockHorizontal;
//static double safeBlockVertical;
//
//void init(BuildContext context) {
//  _mediaQueryData = MediaQuery.of(context);
//  screenWidth = _mediaQueryData.size.width;
//  screenHeight = _mediaQueryData.size.height;
//  blockSizeHorizontal = screenWidth / 100;
//  blockSizeVertical = screenHeight / 100;
//
//  _safeAreaHorizontal = _mediaQueryData.padding.left +
//      _mediaQueryData.padding.right;
//  _safeAreaVertical = _mediaQueryData.padding.top +
//      _mediaQueryData.padding.bottom;
//  safeBlockHorizontal = (screenWidth -
//      _safeAreaHorizontal) / 100;
//  safeBlockVertical = (screenHeight -
//      _safeAreaVertical) / 100;
