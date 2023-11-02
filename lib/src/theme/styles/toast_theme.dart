import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     轻提示主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 14:49
*/
class FNToastTheme extends InheritedTheme {
  const FNToastTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNToastThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNToastTheme(
          key: key,
          data: FNToastTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNToastThemeData data;

  static FNToastThemeData of(BuildContext context) {
    final FNToastTheme? toastTheme =
        context.dependOnInheritedWidgetOfExactType<FNToastTheme>();
    return toastTheme?.data ?? FNTheme.of(context).toastTheme;
  }

  @override
  bool updateShouldNotify(FNToastTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNToastTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNToastThemeData with Diagnosticable {
  final double verticalOffset;
  final Color background;
  final double radius;
  final TextStyle textStyle;

  factory FNToastThemeData({
    double? verticalOffset,
    Color? background,
    double? radius,
    TextStyle? textStyle,
  }) {
    return FNToastThemeData.raw(
      verticalOffset: verticalOffset ?? 0.0,
      background: background ?? FNColors.yellow,
      radius: radius ?? 20.0,
      textStyle: textStyle ?? const TextStyle(),
    );
  }

  const FNToastThemeData.raw({
    required this.verticalOffset,
    required this.background,
    required this.radius,
    required this.textStyle,
  });

  FNToastThemeData copyWith({
    double? verticalOffset,
    Color? background,
    double? radius,
    TextStyle? textStyle,
  }) {
    return FNToastThemeData(
      verticalOffset: verticalOffset ?? this.verticalOffset,
      background: background ?? this.background,
      radius: radius ?? this.radius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  FNToastThemeData merge(FNToastThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      verticalOffset: other.verticalOffset,
      background: other.background,
      radius: other.radius,
      textStyle: other.textStyle,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      verticalOffset,
      background,
      radius,
      textStyle,
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
    return other is FNToastThemeData &&
        other.verticalOffset == verticalOffset &&
        other.background == background &&
        other.radius == radius &&
        other.textStyle == textStyle &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('verticalOffset', verticalOffset,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('background', background,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<double>('radius', radius, defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
