import 'package:flutter/material.dart';

/// 依赖于插件 ionicons
///
/// ```
///
/// 相关文本组件如下:
///  * [SMText], 基础的文本组件
///
///
class FNUIIcon extends StatelessWidget {
  /// 外边距
  final EdgeInsets? margin;

  /// 内边距
  final EdgeInsets? padding;

  /// icon的大小
  final double size;

  /// icon的样式
  final IconData data;

  /// icon的颜色
  final Color color;

  /// icon的文本
  final String? text;

  /// icon的文本颜色
  final Color textColor;

  /// icon的字体大小
  final double fontSize;

  /// icon的字重
  final FontWeight fontWeight;

  /// icon的点击事件
  final Function? onTap;

  const FNUIIcon({
    Key? key,
    this.margin,
    this.padding,
    this.size = 20,
    required this.data,
    this.color = Colors.black,
    this.text,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTap != null ? _getGestureWidget() : _getNoGestureWidget();
  }

  Widget _getGestureWidget() {
    return text != null
        ? GestureDetector(
            onTap: () => onTap!(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: padding,
                  margin: margin,
                  child: Icon(data, size: size, color: color),
                ),
                Text(
                  text!,
                  style: TextStyle(
                      color: color, fontSize: fontSize, fontWeight: fontWeight),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () => onTap!(),
            child: Container(
              padding: padding,
              margin: margin,
              child: Icon(data, size: size, color: color),
            ),
          );
  }

  Widget _getNoGestureWidget() {
    return text != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: padding,
                margin: margin,
                child: Icon(data, size: size, color: color),
              ),
              Text(
                text!,
                style: TextStyle(
                    color: color, fontSize: fontSize, fontWeight: fontWeight),
              ),
            ],
          )
        : Container(
            padding: padding,
            margin: margin,
            child: Icon(data, size: size, color: color),
          );
  }
}
