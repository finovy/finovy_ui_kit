import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../third_lib/auto_size_text/auto_size_text.dart';

import '../../constant/colors.dart';
import '../../constant/fonts.dart';

enum FontFamilyType {
  // 系统自带
  text,
  // din regular 适用于数字显示
  numRegular,
  // din medium 适用于数字显示
  numMedium,
  // din bold 适用于数字显示
  numBold,
}

class FNUIText extends StatelessWidget {
  /// 文字属性
  /*
   *  文字
   */
  final String text;
  /*
   * 颜色
   */
  final Color? color;
  final Color? backgroundColor;
  /*
   * 字体大小
   */
  final double? fontSize;

  /*
   * 最小字体大小
   */
  final double? minFontSize;
  /*
   * 字体粗细
   */
  final FontWeight? fontWeight;
  /*
   * 字体对齐方式
   */
  final TextAlign? textAlign;
  /*
   * 字体样式
   */
  final FontFamilyType? fontFamilyType;

  /// 容器属性
  /*
   * 宽度
   */
  final double? width;
  /*
   * 高度
   */
  final double? height;
  /*
   * 最大行数
   */
  final int? maxLines;
  /*
   * 外边距
   */
  final EdgeInsets? margin;
  /*
   * 内边距
   */
  final EdgeInsets? padding;
  /*
   * 对齐方式
   */
  final Alignment? alignment;
  /*
   * 装饰器
   */
  final BoxDecoration? decoration;
  /*
   * 点击事件
   */
  // final Function? onTap;

  final List<Shadow>? shadows;

  final bool? softWrap;

  /// 是否是自动缩放文字
  final bool autoSize;

  final String? fontFamily;

  ///行距
  final double? lineHeight;

  ///最大字数
  final int? maxLength;

  ///字体样式
  final TextStyle? textStyle;

  ///字体间距
  final double? letterSpacing;
  /*
   * 外部接口
   */
  const FNUIText({
    required this.text,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.minFontSize,
    this.textAlign,
    this.fontFamilyType = FontFamilyType.text,
    this.width,
    this.height,
    this.maxLines = 10,
    this.margin,
    this.padding,
    this.softWrap,
    this.alignment,
    this.shadows,
    this.decoration,
    this.autoSize = false,
    this.fontFamily,
    this.lineHeight,
    this.maxLength,
    this.textStyle,
    this.letterSpacing,
    // this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatText = text;
    if (maxLength != null && text.length > maxLength!) {
      formatText = text.replaceRange(maxLength!, text.length, "...");
    }
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      color: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      child: autoSize
          ? AutoSizeText(
              formatText,
              style: textStyle ?? _getTextStyle(),
              textAlign: textAlign ?? TextAlign.left,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              softWrap: softWrap ?? true,
              maxFontSize: fontSize ?? double.infinity,
              minFontSize: minFontSize ?? 10,
            )
          : Text(
              formatText,
              style: textStyle ?? _getTextStyle(),
              textAlign: textAlign ?? TextAlign.left,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              softWrap: softWrap ?? true,
            ),
    );
  }

  TextStyle _getTextStyle() {
    switch (fontFamilyType) {
      case FontFamilyType.numRegular:
        return TextStyle(
          shadows: shadows ?? [],
          color: color ?? FNColors.fontMain,
          fontSize: fontSize ?? FNFontSize14,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: "DINRegular",
          height: lineHeight ?? 1.2,
          decoration: TextDecoration.none,
        );
      case FontFamilyType.numMedium:
        return TextStyle(
          shadows: shadows ?? [],
          color: color ?? FNColors.fontMain,
          fontSize: fontSize ?? FNFontSize14,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: "DINMedium",
          height: lineHeight ?? 1.2,
          decoration: TextDecoration.none,
        );
      case FontFamilyType.numBold:
        return TextStyle(
          shadows: shadows ?? [],
          color: color ?? FNColors.fontMain,
          fontSize: fontSize ?? FNFontSize14,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: "DINBold",
          height: lineHeight ?? 1.2,
          decoration: TextDecoration.none,
        );
      default:
        return TextStyle(
          shadows: shadows ?? [],
          color: color ?? FNColors.fontMain,
          fontSize: fontSize ?? FNFontSize14,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontFamily: fontFamily ??
              (kIsWeb
                  ? "PingFang SC"
                  : Platform.isIOS
                      ? "PingFang SC"
                      : "Source Han Sans / Noto"),
          height: lineHeight ?? 1.2,
          letterSpacing: letterSpacing ?? 0.5,
          decoration: TextDecoration.none,
        );
    }
  }
}
