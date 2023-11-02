import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     验证码输入组件（支持三种样式、自动填充、自动焦点）
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/12 16:21
*/
class FNUIVerifyCodeInput extends StatelessWidget {
  /// 输入的文本样式 默认为 [ fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? textStyle;

  /// 错误的文本样式
  final TextStyle? errorTextStyle;

  /// 粘贴的文本样式 默认为 [fontWeight: FontWeight.bold] while
  /// [TextStyle.color] is [ThemeData.colorScheme.onSecondary]
  final TextStyle? pastedTextStyle;

  /// 验证码的预设长度（默认6）
  final int? length;

  /// 输入的格式验证列表
  final List<TextInputFormatter>? inputFormatters;

  /// PIN 码字段是否应自动对焦。 默认为[false]
  final bool? autoFocus;

  /// 是否显示掩码
  final bool? obscureText;

  /// obscureText为true时，此属性不能为空，默认为 ●
  final String? obscuringCharacter;

  /// 掩码视图，如果这个属性被设置，那么obscuringCharacter将被覆盖
  final Widget? obscuringWidget;

  /// 掩码展示时是否闪烁
  final bool? blinkWhenObscuring;

  /// [AnimationType] 用于显示在 pin 代码字段中的文本。 默认为 [AnimationType.slide]
  final AnimationType? animationType;

  /// [TextFormField] 的验证器
  final FormFieldValidator? validator;

  /// 错误信息与输入框的距离
  final double? errorTextSpace;

  /// 单元格样式主题
  final PinTheme? pinTheme;

  /// 光标的颜色，默认为 Theme.of(context).accentColor
  final Color? cursorColor;

  /// 动画的持续时间。 默认为 [持续时间（毫秒：150）]
  final Duration? animationDuration;

  /// 为各个 pin 字段启用颜色填充，默认为 [false]
  final bool? enableActiveFill;

  /// 错误动画控制器
  final StreamController<ErrorAnimationType>? errorAnimationController;

  /// [TextInputType] 用于 pin 代码字段。 默认为 [TextInputType.visiblePassword]
  final TextInputType? keyboardType;

  /// [TextEditingController] 手动控制文本。 如果没有给定，则设置默认的 [TextEditingController()] 对象
  final TextEditingController? controller;

  /// 填充容器的阴影
  final List<BoxShadow>? boxShadows;

  /// 全部输入完成时触发
  final ValueChanged<String>? onCompleted;

  /// 验证文本是否可以粘贴的回调方法。 当我们需要在粘贴之前验证文本时，这非常有用。
  /// 例如 验证文本是否为数字。 默认值将按收到时的样子粘贴。
  final bool Function(String? text)? beforeTextPaste;

  /// 检测pin_code表单点击的方法
  /// 适用于所有窗体窗口
  final Function? onTap;

  /// 是否启用
  final bool? enable;

  /// 当前输入文本变化时触发
  final ValueChanged<String>? onChanged;
  const FNUIVerifyCodeInput({
    super.key,
    this.length,
    this.textStyle,
    this.errorTextStyle,
    this.pastedTextStyle,
    this.inputFormatters,
    this.autoFocus,
    this.obscureText,
    this.obscuringCharacter,
    this.obscuringWidget,
    this.blinkWhenObscuring,
    this.animationType,
    this.validator,
    this.errorTextSpace,
    this.pinTheme,
    this.cursorColor,
    this.animationDuration,
    this.enableActiveFill,
    this.errorAnimationController,
    this.keyboardType,
    this.controller,
    this.boxShadows,
    this.onCompleted,
    this.beforeTextPaste,
    this.onTap,
    this.onChanged,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    FNVerifyCodeThemeData themeData = FNVerifyCodeTheme.of(context);
    return PinCodeTextField(
      enabled: enable ?? true,
      appContext: context,
      textStyle: textStyle ?? themeData.textStyle,
      errorTextStyle: errorTextStyle,
      pastedTextStyle: pastedTextStyle ?? themeData.pastedTextStyle,
      length: length ?? themeData.length,
      inputFormatters: inputFormatters ?? themeData.inputFormatters,
      errorTextSpace: errorTextSpace ?? themeData.errorTextSpace,
      autoFocus: autoFocus ?? themeData.autoFocus,
      obscureText: obscureText ?? themeData.obscureText,
      obscuringCharacter: obscuringCharacter ?? themeData.obscuringCharacter,
      obscuringWidget: obscuringWidget,
      blinkWhenObscuring: blinkWhenObscuring ?? themeData.blinkWhenObscuring,
      animationType: animationType ?? themeData.animationType,
      validator: (v) {
        String? value = validator?.call(v);
        return value;
      },
      pinTheme: pinTheme ?? themeData.pinTheme,
      cursorColor: cursorColor ?? themeData.cursorColor,
      animationDuration: animationDuration ?? themeData.animationDuration,
      enableActiveFill: enableActiveFill ?? themeData.enableActiveFill,
      errorAnimationController: errorAnimationController,
      controller: controller,
      keyboardType: keyboardType ?? themeData.keyboardType,
      boxShadows: boxShadows ?? themeData.boxShadows,
      onCompleted: (v) {
        debugPrint("Completed");
        onCompleted?.call(v);
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        debugPrint(value);
        onChanged?.call(value);
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        bool value = beforeTextPaste?.call(text) ?? true;
        return value;
      },
    );
  }
}
