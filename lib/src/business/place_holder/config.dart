import 'package:flutter/material.dart';

/*
* @description:     空页面配置类
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/17 14:13
*/
class FNUIEmptyConfig {
  FNUIEmptyConfig({
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? operateTextStyle,
    double? btnRadius,
    TextStyle? singleTextStyle,
    TextStyle? doubleTextStyle,
    double? singleMinWidth,
    double? doubleMinWidth,
  })  : _titleTextStyle = titleTextStyle,
        _contentTextStyle = contentTextStyle,
        _operateTextStyle = operateTextStyle,
        _btnRadius = btnRadius,
        _singleTextStyle = singleTextStyle,
        _doubleTextStyle = doubleTextStyle,
        _singleMinWidth = singleMinWidth,
        _doubleMinWidth = doubleMinWidth;

  /*
  * @description:     默认配置
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/5/17 14:13
  */
  static FNUIEmptyConfig defaultConfig() {
    return FNUIEmptyConfig(
      titleTextStyle: const TextStyle(
        fontFamily: 'PingFangSC',
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff333333),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      operateTextStyle: const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff0058ff),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      btnRadius: 8.0,
      singleTextStyle: const TextStyle(
        fontFamily: 'PingFangSC',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      doubleTextStyle: const TextStyle(
        fontFamily: 'PingFangSC',
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      singleMinWidth: 160.0,
      doubleMinWidth: 120.0,
    );
  }

  /// 文案区域标题
  final TextStyle? _titleTextStyle;

  /// 文案区域内容
  final TextStyle? _contentTextStyle;

  /// 操作区域文本样式
  final TextStyle? _operateTextStyle;

  /// 圆角
  final double? _btnRadius;

  /// 单按钮文本样式
  final TextStyle? _singleTextStyle;

  /// 双按钮文本样式
  final TextStyle? _doubleTextStyle;

  /// 单按钮的按钮最小宽度
  /// 默认值为 160
  final double? _singleMinWidth;

  /// 多按钮的按钮最小宽度
  /// 默认值为 120
  final double? _doubleMinWidth;

  TextStyle get titleTextStyle =>
      _titleTextStyle ?? defaultConfig().titleTextStyle;

  TextStyle get contentTextStyle =>
      _contentTextStyle ?? defaultConfig().contentTextStyle;

  TextStyle get operateTextStyle =>
      _operateTextStyle ?? defaultConfig().operateTextStyle;

  double get btnRadius => _btnRadius ?? defaultConfig().btnRadius;

  TextStyle get singleTextStyle =>
      _singleTextStyle ?? defaultConfig().singleTextStyle;

  TextStyle get doubleTextStyle =>
      _doubleTextStyle ?? defaultConfig().doubleTextStyle;

  double get singleMinWidth =>
      _singleMinWidth ?? defaultConfig().singleMinWidth;

  double get doubleMinWidth =>
      _doubleMinWidth ?? defaultConfig().doubleMinWidth;
}
