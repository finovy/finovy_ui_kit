import 'package:flutter/cupertino.dart';

/*
* @description:     按钮样式
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/28 14:34
*/
class UIButtonStyle {
  /// 按钮文本前景色
  final Color? foregroundColor;

  /// 按钮文本背景色
  final Color? backgroundColor;

  /// 按钮禁用时文本前景色
  final Color? disabledForegroundColor;

  /// 按钮禁用时文本背景色
  final Color? disabledBackgroundColor;

  /// 按钮阴影颜色
  final Color? shadowColor;

  /// 按钮表面颜色
  final Color? surfaceTintColor;

  /// 提高值
  final double? elevation;

  /// 文本样式
  final TextStyle? textStyle;

  /// 边距
  final EdgeInsetsGeometry? padding;

  /// 边框
  final BorderSide? side;

  /// 圆角
  final OutlinedBorder? shape;

  /// 是否启用反馈
  final bool? enableFeedback;

  /// 对其方式
  final AlignmentGeometry? alignment;

  const UIButtonStyle({
    this.foregroundColor,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.textStyle,
    this.padding,
    this.side,
    this.shape,
    this.enableFeedback,
    this.alignment,
  });

  /// 创建一个按钮样式拷贝方法
  UIButtonStyle copyWith(
      {Color? foregroundColor,
      Color? backgroundColor,
      Color? disabledForegroundColor,
      Color? disabledBackgroundColor,
      Color? shadowColor,
      Color? surfaceTintColor,
      double? elevation,
      TextStyle? textStyle,
      EdgeInsetsGeometry? padding,
      BorderSide? side,
      OutlinedBorder? shape,
      bool? enableFeedback,
      AlignmentGeometry? alignment}) {
    return UIButtonStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? this.disabledForegroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevation: elevation ?? this.elevation,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
    );
  }

  /// 创建一个按钮样式合并方法
  UIButtonStyle merge(UIButtonStyle? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      foregroundColor: other.foregroundColor,
      backgroundColor: other.backgroundColor,
      disabledForegroundColor: other.disabledForegroundColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
      shadowColor: other.shadowColor,
      surfaceTintColor: other.surfaceTintColor,
      elevation: other.elevation,
      textStyle: other.textStyle,
      padding: other.padding,
      side: other.side,
      shape: other.shape,
      enableFeedback: other.enableFeedback,
      alignment: other.alignment,
    );
  }
}
