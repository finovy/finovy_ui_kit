import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:fn_ui_kit/src/theme/styles/export.dart';
import 'package:fn_ui_kit/src/theme/var.dart';

// 主题类型
enum FNThemeType {
  fnThemeDefault, // 默认
  fnThemeCustom, //自定义
}

/*
* @description:     组件主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/10/18 16:25
*/
class FNTheme extends StatelessWidget {
  final Widget child;
  final FNThemeData data;
  final FNThemeType? type;
  const FNTheme({
    Key? key,
    required this.child,
    required this.data,
    this.type,
  }) : super(key: key);

  static final FNThemeData _fallback = FNThemeData.fallback();
  static FNThemeData of(BuildContext context) {
    final _InheritedFnTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedFnTheme>();
    return inheritedTheme?.theme.data ?? _fallback;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedFnTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedFnTheme extends InheritedTheme {
  const _InheritedFnTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final FNTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedFnTheme old) =>
      theme.data != old.theme.data;
}

@immutable
class FNThemeData with Diagnosticable {
  /// 图层背景色
  final Color overlayBackgroundColor;

  /// 按钮
  final FNButtonThemeData buttonTheme;

  /// 通知栏
  final FNNoticeBarThemeData noticeBarTheme;

  /// 标签
  final FNTagThemeData tagTheme;

  /// 验证码
  final FNVerifyCodeThemeData verifyCodeTheme;

  ///弹出框
  final FNDialogThemeData dialogTheme;

  /// 步骤条
  final FNStepThemeData stepTheme;

  /// 空页面
  final FNEmptyThemeData emptyTheme;

  /// 轻提示
  final FNToastThemeData toastTheme;

  /// 顶部导航栏
  final FNAppbarThemeData appbarTheme;

  /// 表单
  final FNFormThemeData formTheme;

  /// 下拉刷新
  final FNRefreshThemeData refreshTheme;

  /// 脚手架
  final FNScaffoldThemeData scaffoldTheme;

  factory FNThemeData({
    FNThemeType? type,
    Color? overlayBackgroundColor,
    FNButtonThemeData? buttonTheme,
    FNNoticeBarThemeData? noticeBarTheme,
    FNTagThemeData? tagTheme,
    FNVerifyCodeThemeData? verifyCodeTheme,
    FNDialogThemeData? dialogTheme,
    FNStepThemeData? stepTheme,
    FNEmptyThemeData? emptyTheme,
    FNToastThemeData? toastTheme,
    FNAppbarThemeData? appbarTheme,
    FNFormThemeData? formTheme,
    FNRefreshThemeData? refreshTheme,
    FNScaffoldThemeData? scaffoldTheme,
  }) {
    //设置主题配置类别
    FNThemeManager.instance._ofThemeType(type ?? FNThemeType.fnThemeDefault);
    return FNThemeData.raw(
      overlayBackgroundColor: overlayBackgroundColor ?? FNColors.card,
      buttonTheme: buttonTheme ?? FNButtonThemeData(),
      noticeBarTheme: noticeBarTheme ?? FNNoticeBarThemeData(),
      tagTheme: tagTheme ?? FNTagThemeData(),
      verifyCodeTheme: verifyCodeTheme ?? FNVerifyCodeThemeData(),
      dialogTheme: dialogTheme ?? FNDialogThemeData(),
      stepTheme: stepTheme ?? FNStepThemeData(),
      emptyTheme: emptyTheme ?? FNEmptyThemeData(),
      toastTheme: toastTheme ?? FNToastThemeData(),
      appbarTheme: appbarTheme ?? FNAppbarThemeData(),
      formTheme: formTheme ?? FNFormThemeData(),
      refreshTheme: refreshTheme ?? FNRefreshThemeData(),
      scaffoldTheme: scaffoldTheme ?? FNScaffoldThemeData(),
    );
  }

  factory FNThemeData.fallback() => FNThemeData();

  const FNThemeData.raw({
    required this.overlayBackgroundColor,
    required this.buttonTheme,
    required this.noticeBarTheme,
    required this.tagTheme,
    required this.verifyCodeTheme,
    required this.dialogTheme,
    required this.stepTheme,
    required this.emptyTheme,
    required this.toastTheme,
    required this.appbarTheme,
    required this.formTheme,
    required this.refreshTheme,
    required this.scaffoldTheme,
  });
}

class FNThemeManager {
  static final FNThemeManager _singleton = FNThemeManager._();

  static FNThemeManager get instance => _singleton;

  FNThemeManager._();
  FNThemeType? _type;
  FNThemeType get current => _type ?? FNThemeType.fnThemeDefault;
  void _ofThemeType(FNThemeType? type) {
    _type = type;
  }
}
