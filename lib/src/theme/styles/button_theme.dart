import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

class FNButtonTheme extends InheritedTheme {
  const FNButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNButtonThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNButtonTheme(
          key: key,
          data: FNButtonTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNButtonThemeData data;

  static FNButtonThemeData of(BuildContext context) {
    final FNButtonTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<FNButtonTheme>();
    return buttonTheme?.data ?? FNTheme.of(context).buttonTheme;
  }

  @override
  bool updateShouldNotify(FNButtonTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNButtonTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNButtonThemeData with Diagnosticable {
  final double defaultHeight;
  final FontWeight defaultFontWeight;
  final double defaultFontSize;
  final Color textColor;
  final Color backgroundColor;
  final Color loadingTextColor;
  final Color disabledTextColor;
  final Color loadingDisabledTextColor;
  final Color disabledBackgroundColor;
  final Color pressedTextColor;
  final Color pressedBackgroundColor;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  factory FNButtonThemeData.secondary() {
    return FNButtonThemeData().copyWith(
      textColor: FNColors.btnSecondaryTextColor,
      backgroundColor: FNColors.btnSecondaryBackgroundColor,
      loadingTextColor: FNColors.btnSecondaryLoadingTextColor,
      disabledTextColor: FNColors.btnSecondaryDisabledTextColor,
      loadingDisabledTextColor: FNColors.btnSecondaryDisabledTextColor,
      disabledBackgroundColor: FNColors.btnSecondaryDisabledBackgroundColor,
      pressedTextColor: FNColors.btnSecondaryPressedTextColor,
      pressedBackgroundColor: FNColors.btnSecondaryPressedBackgroundColor,
      borderWidth: FNColors.btnSecondaryBorderWidth,
      borderRadius: FNColors.btnSecondaryBorderRadius,
      borderColor: FNColors.btnSecondaryBorderColor,
    );
  }

  factory FNButtonThemeData.hollowed() {
    return FNButtonThemeData().copyWith(
      textColor: FNColors.btnHollowedTextColor,
      backgroundColor: FNColors.btnHollowedBackgroundColor,
      loadingTextColor: FNColors.btnHollowedLoadingTextColor,
      disabledTextColor: FNColors.btnHollowedDisabledTextColor,
      loadingDisabledTextColor: FNColors.btnHollowedDisabledTextColor,
      disabledBackgroundColor: FNColors.btnHollowedDisabledBackgroundColor,
      pressedTextColor: FNColors.btnHollowedTextColor,
      pressedBackgroundColor: FNColors.btnHollowedBackgroundColor,
      borderWidth: FNColors.btnHollowedBorderWidth,
      borderRadius: FNColors.btnHollowedBorderRadius,
      borderColor: FNColors.btnHollowedBorderColor,
    );
  }

  factory FNButtonThemeData.link() {
    return FNButtonThemeData().copyWith(
      textColor: FNColors.btnLinkTextColor,
      backgroundColor: FNColors.btnLinkBackgroundColor,
      loadingTextColor: FNColors.btnLinkLoadingTextColor,
      disabledTextColor: FNColors.btnLinkDisabledTextColor,
      loadingDisabledTextColor: FNColors.btnLinkDisabledTextColor,
      disabledBackgroundColor: FNColors.btnLinkDisabledBackgroundColor,
      pressedTextColor: FNColors.btnLinkTextColor,
      pressedBackgroundColor: FNColors.btnLinkBackgroundColor,
      borderWidth: FNColors.btnLinkBorderWidth,
      borderRadius: FNColors.btnLinkBorderRadius,
      borderColor: FNColors.btnLinkBorderColor,
    );
  }

  factory FNButtonThemeData({
    double? defaultHeight,
    FontWeight? defaultFontWeight,
    double? defaultFontSize,
    Color? textColor,
    Color? backgroundColor,
    Color? loadingTextColor,
    Color? disabledTextColor,
    Color? loadingDisabledTextColor,
    Color? disabledBackgroundColor,
    Color? pressedTextColor,
    Color? pressedBackgroundColor,
    double? borderWidth,
    double? borderRadius,
    Color? borderColor,
  }) {
    return FNButtonThemeData.raw(
      defaultHeight: defaultHeight ?? FNColors.btnDefaultHeight,
      defaultFontWeight: defaultFontWeight ?? FNColors.fontWeightNormal,
      defaultFontSize: defaultFontSize ?? FNColors.btnDefaultFontSize,
      textColor: textColor ?? FNColors.btnPrimaryTextColor,
      backgroundColor: backgroundColor ?? FNColors.btnPrimaryBackgroundColor,
      loadingTextColor: loadingTextColor ?? FNColors.btnPrimaryLoadingTextColor,
      disabledTextColor:
          disabledTextColor ?? FNColors.btnPrimaryDisabledTextColor,
      loadingDisabledTextColor:
          loadingDisabledTextColor ?? FNColors.btnPrimaryDisabledTextColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? FNColors.btnPrimaryDisabledBackgroundColor,
      pressedTextColor: pressedTextColor ?? FNColors.btnPrimaryTextColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? FNColors.btnPrimaryPressedBackgroundColor,
      borderWidth: borderWidth ?? FNColors.btnPrimaryBorderWidth,
      borderRadius: borderRadius ?? FNColors.btnPrimaryBorderRadius,
      borderColor: borderColor ?? FNColors.btnPrimaryBorderColor,
    );
  }

  const FNButtonThemeData.raw({
    required this.defaultHeight,
    required this.defaultFontWeight,
    required this.defaultFontSize,
    required this.textColor,
    required this.backgroundColor,
    required this.loadingTextColor,
    required this.disabledTextColor,
    required this.loadingDisabledTextColor,
    required this.disabledBackgroundColor,
    required this.pressedTextColor,
    required this.pressedBackgroundColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
  });

  FNButtonThemeData copyWith({
    double? defaultHeight,
    FontWeight? defaultFontWeight,
    double? defaultFontSize,
    Color? textColor,
    Color? backgroundColor,
    Color? loadingTextColor,
    Color? disabledTextColor,
    Color? loadingDisabledTextColor,
    Color? disabledBackgroundColor,
    Color? pressedTextColor,
    Color? pressedBackgroundColor,
    double? borderWidth,
    double? borderRadius,
    Color? borderColor,
  }) {
    return FNButtonThemeData(
      defaultHeight: defaultHeight ?? this.defaultHeight,
      defaultFontWeight: defaultFontWeight ?? this.defaultFontWeight,
      defaultFontSize: defaultFontSize ?? this.defaultFontSize,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      loadingTextColor: loadingTextColor ?? this.loadingTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      loadingDisabledTextColor:
          loadingDisabledTextColor ?? this.loadingDisabledTextColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      pressedTextColor: pressedTextColor ?? this.pressedTextColor,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  FNButtonThemeData merge(FNButtonThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      defaultHeight: other.defaultHeight,
      defaultFontWeight: other.defaultFontWeight,
      defaultFontSize: other.defaultFontSize,
      textColor: other.textColor,
      backgroundColor: other.backgroundColor,
      loadingTextColor: other.loadingTextColor,
      disabledTextColor: other.disabledTextColor,
      loadingDisabledTextColor: other.loadingDisabledTextColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
      pressedTextColor: other.pressedTextColor,
      pressedBackgroundColor: other.pressedBackgroundColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      borderColor: other.borderColor,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      defaultHeight,
      defaultFontWeight,
      defaultFontSize,
      textColor,
      backgroundColor,
      loadingTextColor,
      disabledTextColor,
      loadingDisabledTextColor,
      disabledBackgroundColor,
      pressedTextColor,
      pressedBackgroundColor,
      borderWidth,
      borderRadius,
      borderColor,
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
    return other is FNButtonThemeData &&
        other.defaultHeight == defaultHeight &&
        other.defaultFontWeight == defaultFontWeight &&
        other.defaultFontSize == defaultFontSize &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor &&
        other.loadingTextColor == loadingTextColor &&
        other.disabledTextColor == disabledTextColor &&
        other.loadingDisabledTextColor == loadingDisabledTextColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.pressedTextColor == pressedTextColor &&
        other.pressedBackgroundColor == pressedBackgroundColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.borderColor == borderColor &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('defaultHeight', defaultHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<FontWeight>(
        'defaultFontWeight', defaultFontWeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'defaultFontSize', defaultFontSize,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<Color>('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'loadingTextColor', loadingTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'disabledTextColor', disabledTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'loadingDisabledTextColor', loadingDisabledTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'disabledBackgroundColor', disabledBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'pressedTextColor', pressedTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'pressedBackgroundColor', pressedBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderWidth', borderWidth,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderColor', borderColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
