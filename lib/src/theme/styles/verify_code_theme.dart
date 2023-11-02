import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     验证码输入框主题
* param:
* @return:
* @author:          novice.cai
* @time:            2023/10/31 16:16
*/
class FNVerifyCodeTheme extends InheritedTheme {
  const FNVerifyCodeTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static Widget merge({
    Key? key,
    required FNVerifyCodeThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNVerifyCodeTheme(
          key: key,
          data: FNVerifyCodeTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNVerifyCodeThemeData data;

  static FNVerifyCodeThemeData of(BuildContext context) {
    final FNVerifyCodeTheme? codeTheme =
        context.dependOnInheritedWidgetOfExactType<FNVerifyCodeTheme>();
    return codeTheme?.data ?? FNTheme.of(context).verifyCodeTheme;
  }

  @override
  bool updateShouldNotify(FNVerifyCodeTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNVerifyCodeTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNVerifyCodeThemeData with Diagnosticable {
  factory FNVerifyCodeThemeData({
    TextStyle? textStyle,
    TextStyle? pastedTextStyle,
    int? length,
    List<TextInputFormatter>? inputFormatters,
    bool? autoFocus,
    bool? obscureText,
    String? obscuringCharacter,
    bool? blinkWhenObscuring,
    AnimationType? animationType,
    FormFieldValidator? validator,
    double? errorTextSpace,
    PinTheme? pinTheme,
    Color? cursorColor,
    Duration? animationDuration,
    bool? enableActiveFill,
    TextInputType? keyboardType,
    List<BoxShadow>? boxShadows,
  }) {
    return FNVerifyCodeThemeData.raw(
      textStyle: textStyle ??
          const TextStyle(
              fontSize: FNFontSize14,
              fontWeight: FontWeight.w400,
              color: FNColors.textColor),
      pastedTextStyle: pastedTextStyle ??
          const TextStyle(
              fontSize: FNFontSize14,
              fontWeight: FontWeight.w400,
              color: FNColors.textColor),
      length: length ?? 6,
      inputFormatters: inputFormatters ?? const <TextInputFormatter>[],
      autoFocus: autoFocus ?? true,
      obscureText: obscureText ?? false,
      obscuringCharacter: obscuringCharacter ?? '●',
      blinkWhenObscuring: blinkWhenObscuring ?? true,
      animationType: animationType ?? AnimationType.fade,
      errorTextSpace: errorTextSpace ?? 0.0,
      pinTheme: pinTheme ?? const PinTheme.defaults(),
      cursorColor: cursorColor ?? FNColors.black,
      animationDuration: animationDuration ?? const Duration(milliseconds: 300),
      enableActiveFill: enableActiveFill ?? true,
      keyboardType: keyboardType ?? TextInputType.number,
      boxShadows: boxShadows ??
          const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
    );
  }

  const FNVerifyCodeThemeData.raw({
    required this.textStyle,
    required this.pastedTextStyle,
    required this.length,
    required this.inputFormatters,
    required this.autoFocus,
    required this.obscureText,
    required this.obscuringCharacter,
    required this.blinkWhenObscuring,
    required this.animationType,
    required this.errorTextSpace,
    required this.pinTheme,
    required this.cursorColor,
    required this.animationDuration,
    required this.enableActiveFill,
    required this.keyboardType,
    required this.boxShadows,
  });

  /// 输入的文本样式 默认为 [ fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? textStyle;

  /// 粘贴的文本样式 默认为 [fontWeight: FontWeight.bold] while
  /// [TextStyle.color] is [ThemeData.colorScheme.onSecondary]
  final TextStyle pastedTextStyle;

  /// 验证码的预设长度（默认6）
  final int length;

  /// 输入的格式验证列表
  final List<TextInputFormatter> inputFormatters;

  /// PIN 码字段是否应自动对焦。 默认为[false]
  final bool autoFocus;

  /// 是否显示掩码
  final bool obscureText;

  /// obscureText为true时，此属性不能为空，默认为 ●
  final String obscuringCharacter;

  /// 掩码展示时是否闪烁
  final bool blinkWhenObscuring;

  /// [AnimationType] 用于显示在 pin 代码字段中的文本。 默认为 [AnimationType.slide]
  final AnimationType animationType;

  /// 错误信息与输入框的距离
  final double errorTextSpace;

  /// 单元格样式主题
  final PinTheme pinTheme;

  /// 光标的颜色，默认为 Theme.of(context).accentColor
  final Color cursorColor;

  /// 动画的持续时间。 默认为 [持续时间（毫秒：150）]
  final Duration animationDuration;

  /// 为各个 pin 字段启用颜色填充，默认为 [false]
  final bool enableActiveFill;

  /// [TextInputType] 用于 pin 代码字段。 默认为 [TextInputType.visiblePassword]
  final TextInputType keyboardType;

  /// 填充容器的阴影
  final List<BoxShadow> boxShadows;

  FNVerifyCodeThemeData copyWith({
    TextStyle? textStyle,
    TextStyle? pastedTextStyle,
    int? length,
    List<TextInputFormatter>? inputFormatters,
    bool? autoFocus,
    bool? obscureText,
    String? obscuringCharacter,
    bool? blinkWhenObscuring,
    AnimationType? animationType,
    double? errorTextSpace,
    PinTheme? pinTheme,
    Color? cursorColor,
    Duration? animationDuration,
    bool? enableActiveFill,
    TextInputType? keyboardType,
    List<BoxShadow>? boxShadows,
  }) {
    return FNVerifyCodeThemeData(
      textStyle: textStyle ?? this.textStyle,
      pastedTextStyle: pastedTextStyle ?? this.pastedTextStyle,
      length: length ?? this.length,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      autoFocus: autoFocus ?? this.autoFocus,
      obscureText: obscureText ?? this.obscureText,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      blinkWhenObscuring: blinkWhenObscuring ?? this.blinkWhenObscuring,
      animationType: animationType ?? this.animationType,
      errorTextSpace: errorTextSpace ?? this.errorTextSpace,
      pinTheme: pinTheme ?? this.pinTheme,
      cursorColor: cursorColor ?? this.cursorColor,
      animationDuration: animationDuration ?? this.animationDuration,
      enableActiveFill: enableActiveFill ?? this.enableActiveFill,
      keyboardType: keyboardType ?? this.keyboardType,
      boxShadows: boxShadows ?? this.boxShadows,
    );
  }

  FNVerifyCodeThemeData merge(FNVerifyCodeThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      textStyle: other.textStyle,
      pastedTextStyle: other.pastedTextStyle,
      length: other.length,
      inputFormatters: other.inputFormatters,
      autoFocus: other.autoFocus,
      obscureText: other.obscureText,
      obscuringCharacter: other.obscuringCharacter,
      blinkWhenObscuring: other.blinkWhenObscuring,
      animationType: other.animationType,
      errorTextSpace: other.errorTextSpace,
      pinTheme: other.pinTheme,
      cursorColor: other.cursorColor,
      animationDuration: other.animationDuration,
      enableActiveFill: other.enableActiveFill,
      keyboardType: other.keyboardType,
      boxShadows: other.boxShadows,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      textStyle,
      pastedTextStyle,
      length,
      inputFormatters,
      autoFocus,
      obscureText,
      obscuringCharacter,
      blinkWhenObscuring,
      animationType,
      errorTextSpace,
      pinTheme,
      cursorColor,
      animationDuration,
      enableActiveFill,
      keyboardType,
      boxShadows,
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
    return other is FNVerifyCodeThemeData &&
        other.textStyle == textStyle &&
        other.pastedTextStyle == pastedTextStyle &&
        other.length == length &&
        other.inputFormatters == inputFormatters &&
        other.autoFocus == autoFocus &&
        other.obscureText == obscureText &&
        other.obscuringCharacter == obscuringCharacter &&
        other.blinkWhenObscuring == blinkWhenObscuring &&
        other.animationType == animationType &&
        other.errorTextSpace == errorTextSpace &&
        other.pinTheme == pinTheme &&
        other.cursorColor == cursorColor &&
        other.enableActiveFill == enableActiveFill &&
        other.keyboardType == keyboardType &&
        other.boxShadows == boxShadows;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle,
        defaultValue: null));

    super.debugFillProperties(properties);
  }
}
