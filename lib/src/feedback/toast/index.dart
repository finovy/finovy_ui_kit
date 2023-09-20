import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../context/index.dart';

/// 位置枚举
enum ToastAlign {
  /// 底部显示
  bottom,

  /// 居中显示
  center,

  /// 顶部显示
  top,
}

class OverlayEntryManage {
  final Duration? duration;
  final OverlayEntry overlayEntry;
  final VoidCallback? onDismiss;
  Timer? _timer;
  bool isRemove = false;

  OverlayEntryManage({
    required this.overlayEntry,
    this.duration,
    this.onDismiss,
  });

  void autoDismiss() {
    if (duration == null) return;
    _timer ??= Timer(duration!, () {
      dismiss();
    });
  }

  void dismiss() {
    if (isRemove) return;
    isRemove = true;
    overlayEntry.remove();
    _timer?.cancel();
    _timer = null;
    onDismiss?.call();
  }
}

/*
* @description:     toast轻提示
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/16 10:22
*/
class FNUIToast {
  /// Toast 距离顶部默认间距
  static const int _defaultTopOffset = 43;

  /// Toast 距离底部默认间距
  // static const int _defaultBottomOffset = 50;

  /// _ToastView
  // static ToastView? preToastView;

  static OverlayEntryManage? _currentOverlayEntryManage;

  /*
  * @description:     显示在中间。如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/5/16 14:10
  */
  static VoidCallback showInCenter(
      {required String text, BuildContext? context, Duration? duration}) {
    return show(
      text: text,
      context: context,
      duration: duration,
      align: ToastAlign.center,
    );
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

  static void _dismiss() {
    _currentOverlayEntryManage?.dismiss();
    if (_currentOverlayEntryManage?.isRemove == true) {
      _currentOverlayEntryManage = null;
    }
  }

  /*
  * @description:     显示Toast，如不设置duration则会自动根据内容长度来计算（更友好，最长5秒）
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/5/16 14:10
  */
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
    BuildContext currentContext = context ?? FNDesignContext.buildContext;
    final OverlayState overlayState = Overlay.of(currentContext);

    // preToastView?._dismiss();
    // preToastView = null;

    final double finalVerticalOffset = getVerticalOffset(
      context: currentContext,
      gravity: align,
      verticalOffset: verticalOffset,
    );
    Duration? finalDuration =
        duration ?? (forever ? null : const Duration(seconds: 3));

    /// 自动根据内容长度决定显示时长，更加人性化
    /*if (text != null) {
      final int autoDuration = min(text.length * 0.06 + 0.8, 5.0).ceil();
      finalDuration = Duration(seconds: autoDuration);
    }*/
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return _ToastWidget(
          needMask: needMask,
          widget: customView ??
              ToastChild(
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
    // final ToastView toastView =
    //     ToastView(overlayState: overlayState, overlayEntry: overlayEntry);
    // preToastView = toastView;
    // toastView._show(
    //   duration: finalDuration,
    //   onDismiss: onDismiss,
    // );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dismiss();
      _currentOverlayEntryManage = OverlayEntryManage(
        overlayEntry: overlayEntry,
        duration: finalDuration,
        onDismiss: onDismiss,
      );
      overlayState.insert(_currentOverlayEntryManage!.overlayEntry);
      _currentOverlayEntryManage?.autoDismiss();
    });

    return _dismiss;
  }

  /// 获取默认设置的垂直间距
  static double getVerticalOffset({
    required BuildContext context,
    ToastAlign? gravity,
    double? verticalOffset,
  }) {
    EdgeInsets edgeInsets = MediaQuery.paddingOf(context);
    // final double tempVerticalOffset = verticalOffset ?? 0;
    // final double defaultOffset;

    switch (gravity) {
      case ToastAlign.bottom:
        return edgeInsets.bottom + (verticalOffset ?? 0);
      // final offset = verticalOffset ?? _defaultBottomOffset;
      // defaultOffset = MediaQuery.of(context).viewInsets.bottom + offset;
      // break;
      case ToastAlign.top:
        return edgeInsets.top + (verticalOffset ?? _defaultTopOffset);
      // return edgeInsets.top + (verticalOffset ?? 0);
      // final offset = verticalOffset ?? _defaultTopOffset;
      // defaultOffset = MediaQuery.of(context).viewInsets.top + offset;
      // break;
      case ToastAlign.center:
      default:
        return edgeInsets.top + (verticalOffset ?? 0);
      // defaultOffset = verticalOffset ?? 0;
    }

    // return defaultOffset + tempVerticalOffset;
  }
}

/*
* @description:     overlay主视图
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/16 14:48
*/
// class ToastView {
//   OverlayState overlayState;
//   OverlayEntry overlayEntry;
//   bool _isVisible = false;

//   ToastView({
//     required this.overlayState,
//     required this.overlayEntry,
//   });

//   void _show({required Duration duration, VoidCallback? onDismiss}) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _isVisible = true;
//       overlayState.insert(overlayEntry);
//       Future.delayed(duration, () {
//         _dismiss();
//         onDismiss?.call();
//       });
//     });
//   }

//   void _dismiss() async {
//     if (!_isVisible) {
//       return;
//     }
//     _isVisible = false;
//     overlayEntry.remove();
//   }

//   void close() {
//     _dismiss();
//   }
// }

/*
* @description:     子项视图
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/16 16:32
*/
class ToastChild extends StatelessWidget {
  const ToastChild({
    Key? key,
    required this.msg,
    required this.verticalOffset,
    this.background,
    this.radius,
    this.leading,
    this.gravity,
    this.textStyle,
  }) : super(key: key);

  Alignment get alignment {
    switch (gravity) {
      case ToastAlign.bottom:
        return Alignment.bottomCenter;
      case ToastAlign.top:
        return Alignment.topCenter;
      case ToastAlign.center:
      default:
        return Alignment.center;
    }
  }

  EdgeInsets get padding {
    switch (gravity) {
      case ToastAlign.bottom:
        return EdgeInsets.only(bottom: verticalOffset);
      case ToastAlign.top:
        return EdgeInsets.only(top: verticalOffset);
      case ToastAlign.center:
      default:
        return EdgeInsets.only(top: verticalOffset);
    }
  }

  final String msg;
  final double verticalOffset;
  final Color? background;
  final double? radius;
  final Widget? leading;
  final ToastAlign? gravity;
  final TextStyle? textStyle;

  InlineSpan get leadingSpan {
    if (leading == null) {
      return const TextSpan(text: "");
    }
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(padding: const EdgeInsets.only(right: 6), child: leading!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: padding,
        alignment: alignment,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
              color: background ?? const Color(0xffffffff),
              borderRadius: BorderRadius.circular(radius ?? 20),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x16000000),
                    offset: Offset(0, 5),
                    blurRadius: 12,
                    spreadRadius: 4)
              ]),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: RichText(
            text: TextSpan(children: <InlineSpan>[
              leadingSpan,
              TextSpan(text: msg, style: textStyle),
            ]),
          ),
        ),
      ),
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final bool needMask;
  const _ToastWidget({
    Key? key,
    required this.widget,
    this.needMask = false,
  }) : super(key: key);

  final Widget widget;

  /// 使用IgnorePointer，方便手势透传过去
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !needMask,
      child: Material(color: Colors.transparent, child: widget),
    );
  }
}
