import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUIScaffold extends StatelessWidget {
  /// AppBar
  final FNUIAppbar? appBar;

  /// 标题
  final String? title;

  /// 标题组件
  final Widget? titleWidget;

  /// 阴影
  final bool? showShadow;

  /// 颜色
  final Color? color;

  /// 字体大小
  final double? fontSize;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 导航栏颜色
  final Color? navBarColor;

  /// 背景色
  final Color? backgroundColor;

  /// 左侧子组件
  final Widget? leftWidget;

  final Function? leftCallback;

  /// 右侧子组件
  final Widget? rightWidget;

  /// 子组件
  final Widget child;

  /// 状态栏样式
  final SystemUiOverlayStyle? style;

  /// 导航栏内容高度
  final double? contentHeight;

  /// 标题
  final BuildContext? context;

  final Widget? bottomNavigationBar;

  final bool? resizeToAvoidBottomInset;

  ///左侧菜单
  final Widget? leftDrawer;

  ///右侧菜单
  final Widget? rightDrawer;

  const FNUIScaffold({
    Key? key,
    this.appBar,
    this.title,
    this.titleWidget,
    required this.child,
    this.showShadow,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.navBarColor,
    this.leftWidget,
    this.leftCallback,
    this.rightWidget,
    this.style,
    this.contentHeight,
    this.context,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.leftDrawer,
    this.rightDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FNScaffoldThemeData contextThemeData = FNScaffoldTheme.of(context);
    return Scaffold(
      appBar: _getAppBarWidget(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? contextThemeData.backgroundColor,
      //设置键盘弹起不顶起下方组件
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset ?? contextThemeData.resizeToAvoidBottomInset,
      drawer: leftDrawer,
      endDrawer: rightDrawer,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
    );
  }

  FNUIAppbar? _getAppBarWidget(BuildContext context) {
    if (appBar != null) {
      return appBar;
    } else {
      if (titleWidget != null || titleWidget != null) {}
      FNScaffoldThemeData contextThemeData = FNScaffoldTheme.of(context);
      return (titleWidget == null && title == null)
          ? null
          : FNUIAppbar(
              titleWidget: titleWidget ??
                  FNUIText(
                    text: title ?? '',
                    fontSize: fontSize ?? contextThemeData.fontSize,
                    color: FNColors.textColor,
                    fontWeight: fontWeight ?? contextThemeData.fontWeight,
                  ),
              showShadow: showShadow ?? false,
              style: style ?? contextThemeData.style,
              leftWidget: leftWidget ??
                  FNUINavBack(
                    callBack: () => leftCallback?.call(),
                  ),
              rightWidget: rightWidget,
              contentHeight: contentHeight ?? contextThemeData.contentHeight,
              backgroundColor: navBarColor ?? contextThemeData.backgroundColor,
            );
    }
  }
}
