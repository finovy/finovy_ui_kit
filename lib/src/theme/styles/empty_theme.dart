import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     空页面主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 12:22
*/
class FNEmptyTheme extends InheritedTheme {
  const FNEmptyTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNEmptyThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNEmptyTheme(
          key: key,
          data: FNEmptyTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNEmptyThemeData data;

  static FNEmptyThemeData of(BuildContext context) {
    final FNEmptyTheme? emptyTheme =
        context.dependOnInheritedWidgetOfExactType<FNEmptyTheme>();
    return emptyTheme?.data ?? FNTheme.of(context).emptyTheme;
  }

  @override
  bool updateShouldNotify(FNEmptyTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNEmptyTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNEmptyThemeData with Diagnosticable {
  final EdgeInsetsGeometry buttonPadding;
  final Color buttonBackgroundColor;
  final double btnRadius;
  final Size buttonSize;
  final TextStyle buttonTextStyle;

  factory FNEmptyThemeData({
    EdgeInsetsGeometry? buttonPadding,
    Color? buttonBackgroundColor,
    double? btnRadius,
    Size? buttonSize,
    TextStyle? buttonTextStyle,
  }) {
    return FNEmptyThemeData.raw(
      buttonPadding: buttonPadding ??
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
      buttonBackgroundColor: buttonBackgroundColor ?? FNColors.primary,
      btnRadius: btnRadius ?? 4.0,
      buttonSize: buttonSize ?? const Size(80.0, 32.0),
      buttonTextStyle: buttonTextStyle ??
          const TextStyle(
            fontFamily: 'PingFangSC',
            fontSize: 14,
            color: FNColors.white,
          ),
    );
  }

  const FNEmptyThemeData.raw({
    required this.buttonPadding,
    required this.buttonBackgroundColor,
    required this.btnRadius,
    required this.buttonSize,
    required this.buttonTextStyle,
  });

  FNEmptyThemeData copyWith({
    EdgeInsetsGeometry? buttonPadding,
    Color? buttonBackgroundColor,
    double? btnRadius,
    Size? buttonSize,
    TextStyle? buttonTextStyle,
  }) {
    return FNEmptyThemeData(
      buttonPadding: buttonPadding ?? this.buttonPadding,
      buttonBackgroundColor:
          buttonBackgroundColor ?? this.buttonBackgroundColor,
      btnRadius: btnRadius ?? this.btnRadius,
      buttonSize: buttonSize ?? this.buttonSize,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
    );
  }

  FNEmptyThemeData merge(FNEmptyThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      buttonPadding: other.buttonPadding,
      buttonBackgroundColor: other.buttonBackgroundColor,
      btnRadius: other.btnRadius,
      buttonSize: other.buttonSize,
      buttonTextStyle: other.buttonTextStyle,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      buttonPadding,
      buttonBackgroundColor,
      btnRadius,
      buttonSize,
      buttonTextStyle,
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
    return other is FNEmptyThemeData &&
        other.buttonPadding == buttonPadding &&
        other.buttonBackgroundColor == buttonBackgroundColor &&
        other.btnRadius == btnRadius &&
        other.buttonSize == buttonSize &&
        other.buttonTextStyle == buttonTextStyle &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'buttonPadding', buttonPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'buttonBackgroundColor', buttonBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('btnRadius', btnRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Size>('buttonSize', buttonSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'buttonTextStyle', buttonTextStyle,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
