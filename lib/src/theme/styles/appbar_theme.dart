import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     顶部导航栏主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 15:06
*/
class FNAppbarTheme extends InheritedTheme {
  const FNAppbarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNAppbarThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNAppbarTheme(
          key: key,
          data: FNAppbarTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNAppbarThemeData data;

  static FNAppbarThemeData of(BuildContext context) {
    final FNAppbarTheme? appbarTheme =
        context.dependOnInheritedWidgetOfExactType<FNAppbarTheme>();
    return appbarTheme?.data ?? FNTheme.of(context).appbarTheme;
  }

  @override
  bool updateShouldNotify(FNAppbarTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNAppbarTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNAppbarThemeData with Diagnosticable {
  final double contentHeight;
  final EdgeInsets padding;
  final Color backgroundColor;
  final bool showShadow;

  factory FNAppbarThemeData({
    double? contentHeight,
    EdgeInsets? padding,
    Color? backgroundColor,
    bool? showShadow,
  }) {
    return FNAppbarThemeData.raw(
      contentHeight: contentHeight ?? 44.0,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: backgroundColor ?? FNColors.background,
      showShadow: showShadow ?? false,
    );
  }

  const FNAppbarThemeData.raw({
    required this.contentHeight,
    required this.padding,
    required this.backgroundColor,
    required this.showShadow,
  });

  FNAppbarThemeData copyWith({
    double? contentHeight,
    EdgeInsets? padding,
    Color? backgroundColor,
    bool? showShadow,
  }) {
    return FNAppbarThemeData(
      contentHeight: contentHeight ?? this.contentHeight,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showShadow: showShadow ?? this.showShadow,
    );
  }

  FNAppbarThemeData merge(FNAppbarThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      contentHeight: other.contentHeight,
      padding: other.padding,
      backgroundColor: other.backgroundColor,
      showShadow: other.showShadow,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      contentHeight,
      padding,
      backgroundColor,
      showShadow,
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
    return other is FNAppbarThemeData &&
        other.contentHeight == contentHeight &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.showShadow == showShadow &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('contentHeight', contentHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('showShadow', showShadow,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
