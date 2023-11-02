import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     通知栏类主题
* param:
* @return:
* @author:          novice.cai
* @time:            2023/10/17 17:35
*/
class FNNoticeBarTheme extends InheritedTheme {
  const FNNoticeBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FNNoticeBarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNNoticeBarTheme(
          key: key,
          data: FNNoticeBarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNNoticeBarThemeData data;

  static FNNoticeBarThemeData of(BuildContext context) {
    final FNNoticeBarTheme? noticeBarTheme =
        context.dependOnInheritedWidgetOfExactType<FNNoticeBarTheme>();
    return noticeBarTheme?.data ?? FNTheme.of(context).noticeBarTheme;
  }

  @override
  bool updateShouldNotify(FNNoticeBarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNNoticeBarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNNoticeBarThemeData with Diagnosticable {
  factory FNNoticeBarThemeData({
    double? height,
    EdgeInsets? padding,
    EdgeInsets? wrapPadding,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? backgroundColor,
    double? iconSize,
    double? iconMinWidth,
  }) {
    final double fontFinalSize = fontSize ?? FNColors.fontSizeMd;
    return FNNoticeBarThemeData.raw(
      height: height ?? 40.0,
      padding: padding ??
          const EdgeInsets.symmetric(
              vertical: 0, horizontal: FNColors.paddingMd),
      wrapPadding: wrapPadding ??
          const EdgeInsets.symmetric(
              vertical: FNColors.paddingXs, horizontal: FNColors.paddingMd),
      textColor: textColor ?? FNColors.orangeDark,
      fontSize: fontFinalSize,
      lineHeight: lineHeight ?? (24.0 / fontFinalSize),
      backgroundColor: backgroundColor ?? FNColors.orangeLight,
      iconSize: iconSize ?? 16.0,
      iconMinWidth: iconMinWidth ?? 24.0,
    );
  }

  const FNNoticeBarThemeData.raw({
    required this.height,
    required this.padding,
    required this.wrapPadding,
    required this.textColor,
    required this.fontSize,
    required this.lineHeight,
    required this.backgroundColor,
    required this.iconSize,
    required this.iconMinWidth,
  });

  final double height;
  final EdgeInsets padding;
  final EdgeInsets wrapPadding;
  final Color textColor;
  final double fontSize;
  final double lineHeight;
  final Color backgroundColor;
  final double iconSize;
  final double iconMinWidth;

  FNNoticeBarThemeData copyWith({
    double? height,
    EdgeInsets? padding,
    EdgeInsets? wrapPadding,
    Color? textColor,
    double? fontSize,
    double? lineHeight,
    Color? backgroundColor,
    double? iconSize,
    double? iconMinWidth,
  }) {
    return FNNoticeBarThemeData(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      wrapPadding: wrapPadding ?? this.wrapPadding,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      iconMinWidth: iconMinWidth ?? this.iconMinWidth,
    );
  }

  FNNoticeBarThemeData merge(FNNoticeBarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      height: other.height,
      padding: other.padding,
      wrapPadding: other.wrapPadding,
      textColor: other.textColor,
      fontSize: other.fontSize,
      lineHeight: other.lineHeight,
      backgroundColor: other.backgroundColor,
      iconSize: other.iconSize,
      iconMinWidth: other.iconMinWidth,
    );
  }

  static FNNoticeBarThemeData lerp(
      FNNoticeBarThemeData? a, FNNoticeBarThemeData? b, double t) {
    return FNNoticeBarThemeData(
      height: lerpDouble(a?.height, b?.height, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      wrapPadding: EdgeInsets.lerp(a?.wrapPadding, b?.wrapPadding, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      fontSize: lerpDouble(a?.fontSize, b?.fontSize, t),
      lineHeight: lerpDouble(a?.lineHeight, b?.lineHeight, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      iconSize: lerpDouble(a?.iconSize, b?.iconSize, t),
      iconMinWidth: lerpDouble(a?.iconMinWidth, b?.iconMinWidth, t),
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      height,
      padding,
      wrapPadding,
      textColor,
      fontSize,
      lineHeight,
      backgroundColor,
      iconSize,
      iconMinWidth,
    ];

    return Object.hashAll(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FNNoticeBarThemeData &&
        other.height == height &&
        other.padding == padding &&
        other.wrapPadding == wrapPadding &&
        other.textColor == textColor &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.backgroundColor == backgroundColor &&
        other.iconSize == iconSize &&
        other.iconMinWidth == iconMinWidth;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<double>('height', height, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('wrapPadding', wrapPadding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('lineHeight', lineHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('iconMinWidth', iconMinWidth,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
