import 'dart:ui';
import 'package:flutter/material.dart';

class AdaptUtils {
  //设备基本信息对象
  static final MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  //屏幕宽度dp
  static final double width = mediaQuery.size.width;
  //屏幕高度dp
  static final double height = mediaQuery.size.height;
  //屏幕像素倍率
  static final double ratio = mediaQuery.devicePixelRatio;
  static final double dp2pxRatio = width / 750;
  //传入设计稿 750 像素宽度为参考的尺寸 dp2px
  static double dp2px(double dp2px) {
    return dp2px * dp2pxRatio;
  }
  //传入px转化成dp
  static double px(double px) {
    return px / ratio;
  }

}