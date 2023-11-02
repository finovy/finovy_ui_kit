import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

////////////////////////////// 状态栏+导航栏 //////////////////////////////
class FNUIAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// 标题
  final Widget titleWidget;

  /// 从外部指定高度
  final double? contentHeight;

  ///内边距
  final EdgeInsets? padding;

  /// 设置导航栏背景的颜色
  final Color? backgroundColor;

  /// 左侧按钮
  final Widget? leftWidget;

  /// 右侧按钮
  final Widget? rightWidget;

  /// 是否显示阴影
  final bool? showShadow;

  /// 状态栏样式
  final SystemUiOverlayStyle style;

  const FNUIAppbar({
    Key? key,
    this.leftWidget,
    required this.titleWidget,
    this.contentHeight,
    this.padding,
    this.backgroundColor,
    this.rightWidget,
    this.showShadow,
    this.style = SystemUiOverlayStyle.dark,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(contentHeight ?? 44.0);

  @override
  Widget build(BuildContext context) {
    FNAppbarThemeData contextThemeData = FNAppbarTheme.of(context);
    return Container(
      color: backgroundColor ?? contextThemeData.backgroundColor,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: style,
        child: SafeArea(
          top: true,
          child: Container(
            height: contentHeight ?? contextThemeData.contentHeight,
            padding: padding ?? contextThemeData.padding,
            decoration: showShadow ?? contextThemeData.showShadow
                ? BoxDecoration(
                    color: FNColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: FNColors.shadow,
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      )
                    ],
                  )
                : const BoxDecoration(
                    // color: Colors.green,
                    ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: leftWidget,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 80) * 0.4 * 2,
                  alignment: Alignment.center,
                  child: titleWidget,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: (MediaQuery.of(context).size.width - 80) * 0.4,
                    child: rightWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
