import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     表单配置主题
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 15:28
*/
class FNFormTheme extends InheritedTheme {
  const FNFormTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNFormThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNFormTheme(
          key: key,
          data: FNFormTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNFormThemeData data;

  static FNFormThemeData of(BuildContext context) {
    final FNFormTheme? formTheme =
        context.dependOnInheritedWidgetOfExactType<FNFormTheme>();
    return formTheme?.data ?? FNTheme.of(context).formTheme;
  }

  @override
  bool updateShouldNotify(FNFormTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNFormTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNFormThemeData with Diagnosticable {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool required;
  final String inputText;
  final String errorText;
  final bool readOnly;
  final int maxLength;
  final double textFieldHeight;

  factory FNFormThemeData({
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? required,
    String? inputText,
    String? errorText,
    bool? readOnly,
    int? maxLength,
    double? textFieldHeight,
  }) {
    return FNFormThemeData.raw(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 18.0),
      required: required ?? false,
      inputText: inputText ?? '',
      errorText: errorText ?? '',
      readOnly: readOnly ?? false,
      maxLength: maxLength ?? 100,
      textFieldHeight: textFieldHeight ?? 110.0,
    );
  }

  const FNFormThemeData.raw({
    required this.margin,
    required this.padding,
    required this.required,
    required this.inputText,
    required this.errorText,
    required this.readOnly,
    required this.maxLength,
    required this.textFieldHeight,
  });

  FNFormThemeData copyWith({
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool? required,
    String? inputText,
    String? errorText,
    bool? readOnly,
    int? maxLength,
    double? textFieldHeight,
  }) {
    return FNFormThemeData(
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      required: required ?? this.required,
      inputText: inputText ?? this.inputText,
      errorText: errorText ?? this.errorText,
      readOnly: readOnly ?? this.readOnly,
      maxLength: maxLength ?? this.maxLength,
      textFieldHeight: textFieldHeight ?? this.textFieldHeight,
    );
  }

  FNFormThemeData merge(FNFormThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      margin: other.margin,
      padding: other.padding,
      required: other.required,
      inputText: other.inputText,
      errorText: other.errorText,
      readOnly: other.readOnly,
      maxLength: other.maxLength,
      textFieldHeight: other.textFieldHeight,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      margin,
      padding,
      required,
      inputText,
      errorText,
      readOnly,
      maxLength,
      textFieldHeight,
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
    return other is FNFormThemeData &&
        other.margin == margin &&
        other.padding == padding &&
        other.required == required &&
        other.inputText == inputText &&
        other.errorText == errorText &&
        other.readOnly == readOnly &&
        other.maxLength == maxLength &&
        other.textFieldHeight == textFieldHeight &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<EdgeInsets>('margin', margin, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('required', required, defaultValue: null));
    properties.add(DiagnosticsProperty<String>('inputText', inputText,
        defaultValue: null));
    properties.add(DiagnosticsProperty<String>('errorText', errorText,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<bool>('readOnly', readOnly, defaultValue: null));
    properties.add(
        DiagnosticsProperty<int>('maxLength', maxLength, defaultValue: null));
    properties.add(DiagnosticsProperty<double>(
        'textFieldHeight', textFieldHeight,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
