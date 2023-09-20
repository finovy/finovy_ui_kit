import 'package:flutter/material.dart';

import '../../business/place_holder/index.dart';

/// 状态
enum BaseStatus { loading, success, noNetwork, serverError }

typedef WidgetLoadBuild = Widget Function(BuildContext, Function()?);

/*
* @description 基础widget
* @author      vance.yin
* @time        2023/9/7 11:57
*/
class FNUIPageBuilder extends StatefulWidget {
  /// 正常显示的内容widget （必须）
  final WidgetBuilder builder;

  /// 状态（必需）
  final BaseStatus status;

  /// 是否初始化后加载数据，默认true
  final bool firstRefreshData;

  /// 加载状态显示的widget（非必需，默认空白）
  final WidgetBuilder? loadingBuilder;

  /// 显示加载toast（非必需）
  final VoidCallback Function()? loadToastBuilder;

  /// 断网toast
  final Function()? noNetworkToastBuilder;

  /// -----自定义异常样式-------
  /// 服务器异常的错误自定义样式（非必需，优先级高）
  final WidgetLoadBuild? errorBuilder;

  /// 无网络自定义样式（非必需，优先级高）
  final WidgetLoadBuild? noNetworkBuilder;

  /// -----默认异常样式-------
  /// 服务器异常的文案（非必需与样式二选一）
  final String? errorText;

  /// 无网络的文案（非必需与样式二选一）
  final String? noNetworkText;

  /// 重试按钮文案（非必需与样式二选一）
  final String? retryText;

  /// 加载数据回调，用于组件首次加载和重试
  final VoidCallback? future;

  const FNUIPageBuilder({
    super.key,
    required this.status,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    this.errorText,
    this.noNetworkBuilder,
    this.noNetworkText,
    this.retryText,
    this.future,
    this.loadToastBuilder,
    this.noNetworkToastBuilder,
    this.firstRefreshData = true,
  });

  @override
  State<FNUIPageBuilder> createState() => _FNUIPageBuilderState();
}

class _FNUIPageBuilderState extends State<FNUIPageBuilder> {
  VoidCallback? dismissToast;
  Widget? successChild;

  @override
  void initState() {
    super.initState();
    if (widget.firstRefreshData &&
        widget.status == BaseStatus.loading &&
        widget.future != null) {
      if (widget.loadToastBuilder != null) {
        dismissToast = widget.loadToastBuilder?.call();
      }
      Future.microtask(() => widget.future?.call());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (successChild != null) {
      successChild = widget.builder(context);
      return successChild!;
    }
    switch (widget.status) {
      case BaseStatus.loading:
        return widget.loadingBuilder?.call(context) ?? Container();
      case BaseStatus.success:
        successChild = widget.builder(context);
        return successChild!;
      case BaseStatus.noNetwork:
        return widget.noNetworkBuilder?.call(context, onRetry) ??
            FNUIEmptyWidget(
              position: EmptyWidgetContentPosition(top: 80),
              state: EmptyWidgetState.networkConnectError,
              title: widget.noNetworkText ?? '',
              buttonTitle: widget.retryText,
              onTapButton: onRetry,
            );
      case BaseStatus.serverError:
        return widget.errorBuilder?.call(context, onRetry) ??
            FNUIEmptyWidget(
              position: EmptyWidgetContentPosition(top: 80),
              state: EmptyWidgetState.serverError,
              title: widget.errorText ?? '',
              buttonTitle: widget.retryText,
              onTapButton: onRetry,
            );
    }
  }

  @override
  void didUpdateWidget(covariant FNUIPageBuilder oldWidget) {
    if (dismissToast != null) {
      dismissToast!.call();
      dismissToast = null;
    }
    if (widget.status == BaseStatus.noNetwork && successChild != null) {
      widget.noNetworkToastBuilder?.call();
    }
    if (widget.status == BaseStatus.loading &&
        widget.status != oldWidget.status) {
      onRetry();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (dismissToast != null) {
      dismissToast!.call();
      dismissToast = null;
    }
    super.dispose();
  }

  /*
  * @description 重新加载
  * @param
  * @return
  * @author      vance.yin
  * @time        2023/9/7 15:59
  */
  void onRetry() {
    if (widget.loadToastBuilder != null) {
      dismissToast = widget.loadToastBuilder?.call();
    }
    widget.future?.call();
  }
}
