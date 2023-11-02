import 'dart:async';

import 'package:flutter/material.dart';

Widget _defaultLayoutBuilder(BuildContext context, Widget child) => child;

class CustomOverlayEntry extends OverlayEntry {
  factory CustomOverlayEntry({
    bool initVisible = true,
    bool lockScroll = true,
    Widget Function(BuildContext context, Widget child) layoutBuilder =
        _defaultLayoutBuilder,
    required Widget child,
    required ValueWidgetBuilder<bool> transitionBuilder,
  }) {
    final ValueNotifier<bool> visible = ValueNotifier<bool>(initVisible);
    late CustomOverlayEntry entry;
    entry = CustomOverlayEntry.raw(
      visible: visible,
      child: child,
      builder: (BuildContext context) {
        Widget content = ValueListenableBuilder<bool>(
          valueListenable: entry.visible,
          builder: transitionBuilder,
          child: entry.child,
        );
        content = layoutBuilder(context, content);
        if (lockScroll) {
          content = Material(
            color: Colors.transparent,
            child: content,
          );
        }
        return content;
      },
    );
    return entry;
  }

  CustomOverlayEntry.raw({
    required this.visible,
    required this.child,
    required WidgetBuilder builder,
  }) : super(builder: builder);

  ValueNotifier<bool> visible;

  Widget child;

  Timer? timer;

  void update(Widget child, Duration duration) {
    clearTimer();

    this.child = child;
    markNeedsBuild();
    if (duration != Duration.zero) {
      timer = Timer(duration, close);
    }
  }

  void clearTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  void close() {
    visible.value = false;
    clearTimer();
  }

  // @override
  // void remove() {
  //   visiable.dispose();
  //   super.remove();
  // }
}
