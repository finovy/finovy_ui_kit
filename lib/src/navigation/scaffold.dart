import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../basic/export.dart';
import '../constant/export.dart';
import 'appbar.dart';
import 'back.dart';

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
    this.showShadow = false,
    this.color = Colors.white,
    this.fontSize = 17.0,
    this.fontWeight = FontWeight.bold,
    this.backgroundColor,
    this.navBarColor,
    this.leftWidget,
    this.leftCallback,
    this.rightWidget,
    this.style,
    this.contentHeight = 44,
    this.context,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    this.leftDrawer,
    this.rightDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBarWidget(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? FNColors.background,
      //设置键盘弹起不顶起下方组件
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: leftDrawer,
      endDrawer: rightDrawer,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
    );
  }

  FNUIAppbar? _getAppBarWidget() {
    if (appBar != null) {
      return appBar;
    } else {
      if (titleWidget != null || titleWidget != null) {}
      return (titleWidget == null && title == null)
          ? null
          : FNUIAppbar(
              titleWidget: titleWidget ??
                  FNUIText(
                    text: title ?? '',
                    fontSize: FNFontSize16,
                    color: FNColors.fontMain,
                    fontWeight: FontWeight.w600,
                  ),
              showShadow: showShadow ?? false,
              style: style ?? SystemUiOverlayStyle.dark,
              leftWidget: leftWidget ??
                  FNUINavBack(
                    callBack: () => leftCallback?.call(),
                  ),
              rightWidget: rightWidget,
              contentHeight: contentHeight ?? 44,
              backgroundColor: navBarColor ?? FNColors.card,
            );
    }
  }
}
