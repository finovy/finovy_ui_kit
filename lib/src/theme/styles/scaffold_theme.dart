import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     脚手架主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 16:22
*/
class FNScaffoldTheme extends InheritedTheme {
  const FNScaffoldTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNScaffoldThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNScaffoldTheme(
          key: key,
          data: FNScaffoldTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNScaffoldThemeData data;

  static FNScaffoldThemeData of(BuildContext context) {
    final FNScaffoldTheme? scaffoldTheme =
        context.dependOnInheritedWidgetOfExactType<FNScaffoldTheme>();
    return scaffoldTheme?.data ?? FNTheme.of(context).scaffoldTheme;
  }

  @override
  bool updateShouldNotify(FNScaffoldTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNScaffoldTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNScaffoldThemeData with Diagnosticable {
  final bool showShadow;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color navBarColor;
  final Color backgroundColor;
  final SystemUiOverlayStyle style;
  final double contentHeight;
  final bool resizeToAvoidBottomInset;

  factory FNScaffoldThemeData({
    bool? showShadow,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    Color? navBarColor,
    Color? backgroundColor,
    SystemUiOverlayStyle? style,
    double? contentHeight,
    bool? resizeToAvoidBottomInset,
  }) {
    return FNScaffoldThemeData.raw(
      showShadow: showShadow ?? false,
      color: color ?? FNColors.backgroundColor,
      fontSize: fontSize ?? FNFontSize16,
      fontWeight: fontWeight ?? FontWeight.bold,
      navBarColor: navBarColor ?? FNColors.card,
      backgroundColor: backgroundColor ?? FNColors.background,
      style: style ?? SystemUiOverlayStyle.dark,
      contentHeight: contentHeight ?? 44.0,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
    );
  }

  const FNScaffoldThemeData.raw({
    required this.showShadow,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.navBarColor,
    required this.backgroundColor,
    required this.style,
    required this.contentHeight,
    required this.resizeToAvoidBottomInset,
  });

  FNScaffoldThemeData copyWith({
    bool? showShadow,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    Color? navBarColor,
    Color? backgroundColor,
    SystemUiOverlayStyle? style,
    double? contentHeight,
    bool? resizeToAvoidBottomInset,
  }) {
    return FNScaffoldThemeData(
      showShadow: showShadow ?? this.showShadow,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      navBarColor: navBarColor ?? this.navBarColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      style: style ?? this.style,
      contentHeight: contentHeight ?? this.contentHeight,
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
    );
  }

  FNScaffoldThemeData merge(FNScaffoldThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      showShadow: other.showShadow,
      color: other.color,
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      navBarColor: other.navBarColor,
      backgroundColor: other.backgroundColor,
      style: other.style,
      contentHeight: other.contentHeight,
      resizeToAvoidBottomInset: other.resizeToAvoidBottomInset,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      showShadow,
      color,
      fontSize,
      fontWeight,
      navBarColor,
      backgroundColor,
      style,
      contentHeight,
      resizeToAvoidBottomInset,
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
    return other is FNScaffoldThemeData &&
        other.showShadow == showShadow &&
        other.color == color &&
        other.fontSize == fontSize &&
        other.fontWeight == fontWeight &&
        other.navBarColor == navBarColor &&
        other.backgroundColor == backgroundColor &&
        other.style == style &&
        other.contentHeight == contentHeight &&
        other.resizeToAvoidBottomInset == resizeToAvoidBottomInset &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('showShadow', showShadow,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<Color>('color', color, defaultValue: null));
    properties.add(
        DiagnosticsProperty<double>('fontSize', fontSize, defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>('fontWeight', fontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('navBarColor', navBarColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle>('style', style,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('contentHeight', contentHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>(
        'resizeToAvoidBottomInset', resizeToAvoidBottomInset,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
