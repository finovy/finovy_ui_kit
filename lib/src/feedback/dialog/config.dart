import 'package:flutter/material.dart';

/*
* @description:     弹窗组件默认配置类
* param: 
* @return:          
* @author:          novice.cai
* @time:            2023/5/17 10:07
*/
class UIDialogConfig {
  const UIDialogConfig(
      {this.dialogWidth = 300.0,
      this.radius = 6.0,
      this.iconPadding = const EdgeInsets.all(10),
      this.titlePaddingSm = EdgeInsets.zero,
      this.titlePaddingLg = const EdgeInsets.only(top: 20),
      this.titleTextStyle = const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff252525),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        height: 1.44
      ),
      this.titleTextAlign = TextAlign.center,
      this.contentPaddingSm = const EdgeInsets.only(left: 24.0,top: 12,right: 24,bottom: 24),
      this.contentPaddingLg = const EdgeInsets.all(24.0),
      this.contentTextStyle = const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff666666),
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      this.contentTextAlign,
      this.warningPaddingSm = const EdgeInsets.only(left: 24.0, right: 24.0),
      this.warningPaddingLg = EdgeInsets.zero,
      this.warningTextStyle = const TextStyle(
        fontFamily: 'PingFangSC',
        color: Colors.red,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: 1.5
      ),
      this.warningTextAlign,
      this.dividerPadding = EdgeInsets.zero,
      this.mainActionTextStyle = const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff0058ff),
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      this.mainActionBackgroundColor = Colors.white,
      this.assistActionsTextStyle = const TextStyle(
        fontFamily: 'PingFangSC',
        color: Color(0xff666666),
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      ),
      this.assistActionsBackgroundColor = Colors.white,
      this.bottomHeight = 50.0,
      this.backgroundColor = Colors.white,
      this.cVerticalDivider = const VerticalDivider(width: 0.5, color: Color(0xFFEAEAEA)),
      this.cDividerLine = const Divider(height: 0.5, color: Color(0xFFEAEAEA))});

  /// Dialog 宽度
  /// 默认为 300
  final double dialogWidth;

  /// Dialog 四周圆角
  final double radius;

  /// Dialog icon 距离顶部的边距
  final EdgeInsets iconPadding;

  /// title 在顶部有 icon 时的边距
  final EdgeInsets titlePaddingSm;

  /// title 当顶部无 icon 时的边距
  final EdgeInsets titlePaddingLg;

  /// title 标题样式
  final TextStyle titleTextStyle;

  /// 标题的文字对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? titleTextAlign;

  /// content 当顶部有 title 或者 icon 时的边距
  final EdgeInsets contentPaddingSm;

  /// content 当顶部无 title 或者 icon 时的边距

  final EdgeInsets contentPaddingLg;

  /// message 内容样式
  final TextStyle contentTextStyle;

  /// 内容文字的对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? contentTextAlign;

  /// warning 当顶部有 title/icon/content 时的边距
  final EdgeInsets warningPaddingSm;

  /// warning 当顶部无 title/icon/content 时的边距
  final EdgeInsets warningPaddingLg;

  /// 警告样式
  final TextStyle warningTextStyle;

  /// 警示文案文字的对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? warningTextAlign;

  /// action 顶部 divider 的上方边距
  ///
  /// EdgeInsets.only(top: 28)
  final EdgeInsets dividerPadding;

  /// 主色调按钮样式
  final TextStyle mainActionTextStyle;

  /// 水平分割线 内容与按钮
  final VerticalDivider cVerticalDivider;

  /// 垂直分割线 按钮分割
  final Divider cDividerLine;

  /// 主色调按钮的背景
  final Color mainActionBackgroundColor;

  /// 其他按钮的样式(超2个时按钮样式)
  final TextStyle assistActionsTextStyle;

  /// 其他按钮的背景
  final Color assistActionsBackgroundColor;

  /// 底部按钮高度
  /// 默认为 44.0
  final double bottomHeight;

  /// Dialog背景
  final Color? backgroundColor;
}
