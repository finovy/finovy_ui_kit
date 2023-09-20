import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors.dart';

////////////////////////////// 状态栏+导航栏 //////////////////////////////
class FNUIAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// 标题
  final Widget titleWidget;

  /// 从外部指定高度
  final double contentHeight;

  ///内边距
  final EdgeInsets? padding;

  /// 设置导航栏背景的颜色
  final Color backgroundColor;

  /// 左侧按钮
  final Widget? leftWidget;

  /// 右侧按钮
  final Widget? rightWidget;

  /// 是否显示阴影
  final bool showShadow;

  /// 状态栏样式
  final SystemUiOverlayStyle style;

  const FNUIAppbar({
    Key? key,
    this.leftWidget,
    required this.titleWidget,
    this.contentHeight = 44,
    this.padding,
    this.backgroundColor = Colors.white,
    this.rightWidget,
    this.showShadow = false,
    this.style = SystemUiOverlayStyle.dark,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: style,
        child: SafeArea(
          top: true,
          child: Container(
            height: contentHeight,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
            decoration: showShadow
                ? BoxDecoration(
                    color: FNColors.mainColor,
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
