import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     步骤条主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 11:50
*/
class FNStepTheme extends InheritedTheme {
  const FNStepTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNStepThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNStepTheme(
          key: key,
          data: FNStepTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNStepThemeData data;

  static FNStepThemeData of(BuildContext context) {
    final FNStepTheme? stepTheme =
        context.dependOnInheritedWidgetOfExactType<FNStepTheme>();
    return stepTheme?.data ?? FNTheme.of(context).stepTheme;
  }

  @override
  bool updateShouldNotify(FNStepTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNStepTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNStepThemeData with Diagnosticable {
  final Color stepTextColor;
  final Color stepActiveColor;
  final Color stepProcessTextColor;
  final double stepFontSize;
  final Color stepLineColor;
  final Color stepFinishLineColor;
  final Color stepFinishTextColor;
  final double stepIconSize;
  final double stepCircleSize;
  final Color stepCircleColor;
  final double stepHorizontalTitleFontSize;
  final Color stepsBackgroundColor;

  factory FNStepThemeData({
    Color? stepTextColor,
    Color? stepActiveColor,
    Color? stepProcessTextColor,
    double? stepFontSize,
    Color? stepLineColor,
    Color? stepFinishLineColor,
    Color? stepFinishTextColor,
    double? stepIconSize,
    double? stepCircleSize,
    Color? stepCircleColor,
    double? stepHorizontalTitleFontSize,
    Color? stepsBackgroundColor,
  }) {
    return FNStepThemeData.raw(
      stepTextColor: stepTextColor ?? FNColors.textColor,
      stepActiveColor: stepActiveColor ?? FNColors.primary,
      stepProcessTextColor: stepProcessTextColor ?? FNColors.textColor,
      stepFontSize: stepFontSize ?? FNColors.fontSizeMd,
      stepLineColor: stepLineColor ?? FNColors.primary,
      stepFinishLineColor: stepFinishLineColor ?? FNColors.primary,
      stepFinishTextColor: stepFinishTextColor ?? FNColors.textColor,
      stepIconSize: stepIconSize ?? 12.0,
      stepCircleSize: stepCircleSize ?? 10.0,
      stepCircleColor: stepCircleColor ?? FNColors.primary,
      stepHorizontalTitleFontSize:
          stepHorizontalTitleFontSize ?? FNColors.fontSizeSm,
      stepsBackgroundColor: stepsBackgroundColor ?? FNColors.white,
    );
  }

  const FNStepThemeData.raw({
    required this.stepTextColor,
    required this.stepActiveColor,
    required this.stepProcessTextColor,
    required this.stepFontSize,
    required this.stepLineColor,
    required this.stepFinishLineColor,
    required this.stepFinishTextColor,
    required this.stepIconSize,
    required this.stepCircleSize,
    required this.stepCircleColor,
    required this.stepHorizontalTitleFontSize,
    required this.stepsBackgroundColor,
  });

  FNStepThemeData copyWith({
    Color? stepTextColor,
    Color? stepActiveColor,
    Color? stepProcessTextColor,
    double? stepFontSize,
    Color? stepLineColor,
    Color? stepFinishLineColor,
    Color? stepFinishTextColor,
    double? stepIconSize,
    double? stepCircleSize,
    Color? stepCircleColor,
    double? stepHorizontalTitleFontSize,
    Color? stepsBackgroundColor,
  }) {
    return FNStepThemeData(
      stepTextColor: stepTextColor ?? this.stepTextColor,
      stepActiveColor: stepActiveColor ?? this.stepActiveColor,
      stepProcessTextColor: stepProcessTextColor ?? this.stepProcessTextColor,
      stepFontSize: stepFontSize ?? this.stepFontSize,
      stepLineColor: stepLineColor ?? this.stepLineColor,
      stepFinishLineColor: stepFinishLineColor ?? this.stepFinishLineColor,
      stepFinishTextColor: stepFinishTextColor ?? this.stepFinishTextColor,
      stepIconSize: stepIconSize ?? this.stepIconSize,
      stepCircleSize: stepCircleSize ?? this.stepCircleSize,
      stepCircleColor: stepCircleColor ?? this.stepCircleColor,
      stepHorizontalTitleFontSize:
          stepHorizontalTitleFontSize ?? this.stepHorizontalTitleFontSize,
      stepsBackgroundColor: stepsBackgroundColor ?? this.stepsBackgroundColor,
    );
  }

  FNStepThemeData merge(FNStepThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      stepTextColor: other.stepTextColor,
      stepActiveColor: other.stepActiveColor,
      stepProcessTextColor: other.stepProcessTextColor,
      stepFontSize: other.stepFontSize,
      stepLineColor: other.stepLineColor,
      stepFinishLineColor: other.stepFinishLineColor,
      stepFinishTextColor: other.stepFinishTextColor,
      stepIconSize: other.stepIconSize,
      stepCircleSize: other.stepCircleSize,
      stepCircleColor: other.stepCircleColor,
      stepHorizontalTitleFontSize: other.stepHorizontalTitleFontSize,
      stepsBackgroundColor: other.stepsBackgroundColor,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      stepTextColor,
      stepActiveColor,
      stepProcessTextColor,
      stepFontSize,
      stepLineColor,
      stepFinishLineColor,
      stepFinishTextColor,
      stepIconSize,
      stepCircleSize,
      stepCircleColor,
      stepHorizontalTitleFontSize,
      stepsBackgroundColor,
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
    return other is FNStepThemeData &&
        other.stepTextColor == stepTextColor &&
        other.stepActiveColor == stepActiveColor &&
        other.stepProcessTextColor == stepProcessTextColor &&
        other.stepFontSize == stepFontSize &&
        other.stepLineColor == stepLineColor &&
        other.stepFinishLineColor == stepFinishLineColor &&
        other.stepFinishTextColor == stepFinishTextColor &&
        other.stepIconSize == stepIconSize &&
        other.stepCircleSize == stepCircleSize &&
        other.stepCircleColor == stepCircleColor &&
        other.stepHorizontalTitleFontSize == stepHorizontalTitleFontSize &&
        other.stepsBackgroundColor == stepsBackgroundColor &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Color>('stepTextColor', stepTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepActiveColor', stepActiveColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepProcessTextColor', stepProcessTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('stepFontSize', stepFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('stepLineColor', stepLineColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepFinishLineColor', stepFinishLineColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepFinishTextColor', stepFinishTextColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('stepIconSize', stepIconSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('stepCircleSize', stepCircleSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepCircleColor', stepCircleColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'stepHorizontalTitleFontSize', stepHorizontalTitleFontSize,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'stepsBackgroundColor', stepsBackgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
