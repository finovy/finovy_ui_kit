import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../basic/export.dart';
import '../../theme/var.dart';

/*
* @description:     通知栏组件（可滚动）
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 17:34
*/
class FNUINoticeBar extends StatefulWidget {
  const FNUINoticeBar({
    Key? key,
    this.text = '',
    this.mode,
    this.color,
    this.leftIconName,
    this.leftIconUrl,
    this.wrapAble = false,
    this.background,
    this.scrollable,
    this.delay = 1.0,
    this.speed = 60.0,
    this.onClick,
    this.onClose,
    this.onReplay,
    this.child,
    this.leftIconSlot,
    this.rightIconSlot,
  })  : assert(delay >= 0.0),
        assert(speed > 0.0),
        super(key: key);

  // ****************** Props ******************

  /// 通知文本内容
  final String text;

  /// 通知栏模式，可选值为 `closeable` `link`
  final FNNoticeBarMode? mode;

  /// 通知文本颜色
  final Color? color;

  /// 左侧图标名称
  final IconData? leftIconName;

  /// 左侧图片链接
  final String? leftIconUrl;

  /// 是否开启文本换行，只在禁用滚动时生效
  final bool wrapAble;

  /// 滚动条背景
  final Color? background;

  /// 是否开启滚动播放，内容长度溢出时默认开启
  final bool? scrollable;

  /// 动画延迟时间 (s)
  final double delay;

  /// 滚动速率 (px/s)
  final double speed;

  // ****************** Events ******************

  /// 点击通知栏时触发
  final VoidCallback? onClick;

  /// 关闭通知栏时触发
  final VoidCallback? onClose;

  /// 每当滚动栏重新开始滚动时触发
  final VoidCallback? onReplay;

  // ****************** Slots ******************

  /// 通知文本内容
  final Widget? child;

  /// 自定义左侧图标
  final Widget? leftIconSlot;

  /// 自定义右侧图标
  final Widget? rightIconSlot;

  @override
  _FNUINoticeBarState createState() => _FNUINoticeBarState();
}

class _FNUINoticeBarState extends State<FNUINoticeBar>
    with TickerProviderStateMixin {
  bool show = true;

  late AnimationController controller;
  late Animation<Offset> animation;

  Timer? startTimer;

  GlobalKey textRef = GlobalKey();
  GlobalKey contentRef = GlobalKey();

  void _handleAnimationStatusChange() {
    if (1.0 - controller.value < 0.001) {
      widget.onReplay?.call();
    }
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this)
      ..addListener(_handleAnimationStatusChange);
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(controller);
    WidgetsBinding.instance.addPostFrameCallback((Duration timestamp) {
      start();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeListener(_handleAnimationStatusChange)
      ..dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FNUINoticeBar oldWidget) {
    if (oldWidget.text != widget.text ||
        oldWidget.scrollable != widget.scrollable) {
      start();
    }
    super.didUpdateWidget(oldWidget);
  }

  void start() {
    final Duration ms = Duration(milliseconds: (widget.delay * 1000).toInt());

    startTimer?.cancel();

    startTimer = Timer(ms, () {
      if (textRef.currentContext == null ||
          contentRef.currentContext == null ||
          widget.scrollable == false) {
        return;
      }

      final double textRefWidth = textRef.currentContext?.size?.width ?? 0.0;
      final double contentRefWidth =
          contentRef.currentContext?.size?.width ?? 0.0;

      if (widget.scrollable == true || contentRefWidth < textRefWidth) {
        final double fullWidth = contentRefWidth + textRefWidth;

        controller
          ..value = contentRefWidth / fullWidth
          ..duration = Duration(seconds: fullWidth ~/ widget.speed);
        animation = controller.drive(
          Tween<Offset>(
            begin: Offset(contentRefWidth, 0.0),
            end: Offset(-textRefWidth, 0.0),
          ),
        );
        controller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget noticeBar = DefaultTextStyle(
      style: TextStyle(
        color: widget.color ?? FNColors.textColor,
        // height: themeData.lineHeight,
      ),
      child: Container(
        color: widget.background ?? FNColors.backgroundWarning,
        padding: widget.wrapAble
            ? const EdgeInsets.symmetric(
                vertical: 0, horizontal: FNColors.paddingMd)
            : const EdgeInsets.symmetric(
                vertical: 0, horizontal: FNColors.paddingBase),
        constraints: BoxConstraints(
          maxHeight: widget.wrapAble ? double.infinity : 40,
          minHeight: widget.wrapAble ? 0.0 : 40,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildLeftIcon(),
            Expanded(child: _buildMarquee(context)),
            _buildRightIcon(),
          ],
        ),
      ),
    );

    return Semantics(
      container: true,
      link: widget.mode == FNNoticeBarMode.link,
      label: 'alert',
      hidden: !show,
      child: Visibility(
        visible: show,
        child: noticeBar,
      ),
    );
  }

  Widget _buildMarquee(BuildContext context) {
    final bool ellipsis = widget.scrollable == false && !widget.wrapAble;
    Widget marquee = Builder(
      key: textRef,
      builder: (BuildContext context) {
        return widget.child ??
            Text(
              widget.text,
              softWrap: widget.wrapAble,
              maxLines: widget.wrapAble ? null : 1,
              overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
              textHeightBehavior: FNColors.textHeightBehavior,
            );
      },
    );

    if (widget.scrollable != false) {
      marquee = ClipRect(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: animation.value,
                child: child,
              );
            },
            child: marquee,
          ),
        ),
      );
    }

    return Semantics(
      key: contentRef,
      container: true,
      label: 'marquee',
      child: marquee,
    );
  }

  Widget _buildIcon({
    Alignment align = Alignment.centerLeft,
    Widget? child,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 16,
      ),
      alignment: align,
      child: child,
    );
  }

  Widget _buildLeftIcon() {
    if (widget.leftIconSlot != null) {
      return widget.leftIconSlot!;
    }

    if (widget.leftIconName != null || widget.leftIconUrl != null) {
      return _buildIcon(
        align: Alignment.centerLeft,
        child: FNUIIcon(
          size: 16.0,
          iconName: widget.leftIconName,
          iconUrl: widget.leftIconUrl,
          color: widget.color ?? FNColors.backgroundWarning,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildRightIcon() {
    if (widget.rightIconSlot != null) {
      return widget.rightIconSlot!;
    }

    if (rightIconName != null) {
      return _buildIcon(
        align: Alignment.centerRight,
        child: FNUIIcon(
          size: 16.0,
          iconName: rightIconName,
          onClick: onClickRightIcon,
          color: widget.color ?? FNColors.backgroundWarning,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void onClickRightIcon() {
    if (widget.mode == FNNoticeBarMode.closeable) {
      setState(() => show = false);
      widget.onClose?.call();
    }
  }

  IconData? get rightIconName {
    if (widget.mode == FNNoticeBarMode.closeable) {
      return Icons.clear;
    }

    if (widget.mode == FNNoticeBarMode.link) {
      return Icons.arrow_forward_ios_sharp;
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', widget.text));
    properties.add(DiagnosticsProperty<FNNoticeBarMode>('mode', widget.mode));
    properties.add(DiagnosticsProperty<Color>('color', widget.color));
    properties.add(
        DiagnosticsProperty<IconData>('leftIconName', widget.leftIconName));
    properties
        .add(DiagnosticsProperty<String>('leftIconUrl', widget.leftIconUrl));
    properties.add(DiagnosticsProperty<bool>('wrapable', widget.wrapAble,
        defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('background', widget.background));
    properties.add(DiagnosticsProperty<bool>('scrollable', widget.scrollable,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<double>('delay', widget.delay, defaultValue: 1.0));
    properties.add(
        DiagnosticsProperty<double>('speed', widget.speed, defaultValue: 50.0));
    super.debugFillProperties(properties);
  }
}

/// 通知栏模式
enum FNNoticeBarMode {
  closeable,
  link,
}
