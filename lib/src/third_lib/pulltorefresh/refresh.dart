import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUIRefresh extends StatelessWidget {
  ///列表内容，当child为空时，使用slivers来渲染
  final Widget? child;

  /// 列表内容
  final List<Widget>? slivers;

  /// 刷新回调
  final Future<void> Function()? onRefresh;

  /// 加载回调
  final Future<void> Function()? onLoad;

  /// 刷新controller
  final RefreshController? refreshController;

  /// scroll controller
  final ScrollController? scrollController;

  final Widget? headerWidget;

  final Widget? footerWidget;

  /// 空数据组件
  final Widget? emptyWidget;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final Axis? scrollDirection;

  final bool? enablePullDown;

  final bool? enablePullUp;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final bool? reverse;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final bool? primary;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final ScrollPhysics? physics;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final double? cacheExtent;

  /// copy from ScrollView,for setting in SingleChildView,not ScrollView
  final int? semanticChildCount;

  final bool? hideFooterWhenNotFull;

  /// 刷新中的文案
  final String? refreshingText;

  /// 下拉刷新的文案
  final String? idleText;

  /// 刷新完成文案
  final String? completedText;

  /// 刷新失败文案
  final String? failedText;

  /// 没有更多文案
  final String? noMoreText;

  const FNUIRefresh({
    Key? key,
    this.child,
    this.slivers,
    this.onRefresh,
    this.onLoad,
    this.refreshController,
    this.emptyWidget,
    this.hideFooterWhenNotFull,
    this.scrollController,
    this.scrollDirection,
    this.reverse,
    this.primary,
    this.physics,
    this.cacheExtent,
    this.semanticChildCount,
    this.headerWidget,
    this.footerWidget,
    this.enablePullDown,
    this.enablePullUp,
    this.refreshingText,
    this.idleText,
    this.completedText,
    this.failedText,
    this.noMoreText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FNRefreshThemeData contextThemeData = FNRefreshTheme.of(context);

    return SmartRefresher(
      enablePullDown: enablePullDown ?? contextThemeData.enablePullDown,
      enablePullUp: enablePullUp ?? contextThemeData.enablePullUp,
      header: headerWidget ?? contextThemeData.headerWidget,
      footer: footerWidget ?? contextThemeData.footerWidget,
      controller: refreshController ?? contextThemeData.refreshController,
      scrollController: scrollController,
      reverse: reverse ?? contextThemeData.reverse,
      primary: primary,
      physics: physics ?? contextThemeData.physics,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      onRefresh: onRefresh,
      onLoading: onLoad,
      child: child ??
          CustomScrollView(
            slivers: slivers ?? [],
          ),
    );
    // );
  }
}
