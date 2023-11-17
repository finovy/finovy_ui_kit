library toast;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import '../../context/index.dart';
import '../../theme/styles/toast_theme.dart';

part 'type.dart';
part 'view.dart';
part 'manager.dart';

/*
* @description: toast显示组件
* @param: 
* @return: 
* @author: Ethan Zhu
* @time: 2023-11-13 12:01:09 星期一
*/
class FNUIToast {
  /// Toast 距离顶部默认间距
  static const int _defaultTopOffset = 43;

  /// 展示toast
  static VoidCallback show({
    String? text,
    BuildContext? context,
    Duration? duration,
    Color? background,
    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    double? radius,
    Widget? preIcon,
    double? verticalOffset,
    VoidCallback? onDismiss,
    ToastAlign? align,
    Widget? customView,
    bool needMask = false,
    bool forever = false,
  }) {
    Duration? finalDuration =
        duration ?? (forever ? null : const Duration(seconds: 3));
    BuildContext? currentContext = context ?? FNDesignContext.buildContext;

    /// 第一次获取不到context，放入下一帧获取
    if (currentContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentContext = context ?? FNDesignContext.buildContext;
        _ToastManager.instance.create(
          overlayEntry: _createEntry(
            currentContext!,
            text: text,
            background: background,
            textStyle: textStyle,
            radius: radius,
            preIcon: preIcon,
            verticalOffset: verticalOffset,
            align: align,
            customView: customView,
            needMask: needMask,
          ),
          context: currentContext!,
          duration: finalDuration,
        );
      });
      return _ToastManager.instance.dismiss;
    }

    _ToastManager.instance.create(
      overlayEntry: _createEntry(
        currentContext,
        text: text,
        background: background,
        textStyle: textStyle,
        radius: radius,
        preIcon: preIcon,
        verticalOffset: verticalOffset,
        align: align,
        customView: customView,
        needMask: needMask,
      ),
      context: currentContext,
      duration: finalDuration,
    );

    return _ToastManager.instance.dismiss;
  }

  static OverlayEntry _createEntry(
    BuildContext context, {
    String? text,
    Color? background,
    TextStyle? textStyle,
    double? radius,
    Widget? preIcon,
    double? verticalOffset,
    ToastAlign? align,
    Widget? customView,
    bool? needMask,
  }) {
    final double finalVerticalOffset = _getVerticalOffset(
      context: context,
      gravity: align,
      verticalOffset: verticalOffset,
    );

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return _ToastMaskWidget(
          needMask: needMask ?? false,
          widget: customView ??
              _ToastChild(
                background: background,
                radius: radius,
                msg: text ?? "",
                leading: preIcon,
                textStyle: textStyle,
                gravity: align,
                verticalOffset: finalVerticalOffset,
              ),
        );
      },
    );

    return overlayEntry;
  }

  /*
   * @description 自定义Toast页面UI
   * @param
   * @return
   * @author king.li
   * @time 2023/5/29 23:43
   */
  static VoidCallback showCustomView({
    required Widget customView,
    BuildContext? context,
    Duration? duration,
  }) {
    return show(customView: customView, context: context, duration: duration);
  }

  /// 获取默认设置的垂直间距
  static double _getVerticalOffset({
    required BuildContext context,
    ToastAlign? gravity,
    double? verticalOffset,
  }) {
    EdgeInsets edgeInsets = MediaQuery.paddingOf(context);

    switch (gravity) {
      case ToastAlign.bottom:
        return edgeInsets.bottom + (verticalOffset ?? 0);

      case ToastAlign.top:
        return edgeInsets.top + (verticalOffset ?? _defaultTopOffset);

      case ToastAlign.center:
      default:
        return edgeInsets.top + (verticalOffset ?? 0);
    }
  }
}
