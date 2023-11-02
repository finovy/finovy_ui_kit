import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     下拉刷新主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/11/1 15:52
*/
class FNRefreshTheme extends InheritedTheme {
  const FNRefreshTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNRefreshThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNRefreshTheme(
          key: key,
          data: FNRefreshTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNRefreshThemeData data;

  static FNRefreshThemeData of(BuildContext context) {
    final FNRefreshTheme? refreshTheme =
        context.dependOnInheritedWidgetOfExactType<FNRefreshTheme>();
    return refreshTheme?.data ?? FNTheme.of(context).refreshTheme;
  }

  @override
  bool updateShouldNotify(FNRefreshTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNRefreshTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNRefreshThemeData with Diagnosticable {
  final RefreshController refreshController;
  final Widget headerWidget;
  final Widget footerWidget;
  final Widget emptyWidget;
  final Axis scrollDirection;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool reverse;
  final bool primary;
  final ScrollPhysics physics;
  final double cacheExtent;
  final int semanticChildCount;
  final bool hideFooterWhenNotFull;
  final String refreshingText;
  final String idleText;
  final String completedText;
  final String failedText;
  final String noMoreText;

  factory FNRefreshThemeData({
    RefreshController? refreshController,
    Widget? headerWidget,
    Widget? footerWidget,
    Widget? emptyWidget,
    Axis? scrollDirection,
    bool? enablePullDown,
    bool? enablePullUp,
    bool? reverse,
    bool? primary,
    ScrollPhysics? physics,
    double? cacheExtent,
    int? semanticChildCount,
    bool? hideFooterWhenNotFull,
    String? refreshingText,
    String? idleText,
    String? completedText,
    String? failedText,
    String? noMoreText,
  }) {
    return FNRefreshThemeData.raw(
      refreshController: refreshController ?? RefreshController(),
      headerWidget: headerWidget ??
          CustomHeader(
            builder: (context, mode) {
              final String text;
              Widget? prefixIcon;
              switch (mode) {
                case RefreshStatus.idle:
                  text = idleText ?? '下拉刷新';
                  prefixIcon = const Icon(
                    Icons.arrow_downward,
                    color: FNColors.iconInLight002,
                    size: 16,
                  );
                  break;
                case RefreshStatus.refreshing:
                  text = refreshingText ?? '正在加载...';
                  prefixIcon = const CupertinoActivityIndicator(
                    color: FNColors.iconInLight002,
                    radius: 8,
                  );
                  break;
                case RefreshStatus.completed:
                  text = completedText ?? '刷新成功';
                  prefixIcon = const Icon(
                    Icons.check,
                    color: FNColors.iconInLight002,
                    size: 16,
                  );
                  break;
                case RefreshStatus.failed:
                  text = failedText ?? '刷新失败';
                  prefixIcon = const Icon(
                    Icons.close,
                    color: FNColors.iconInLight002,
                    size: 16,
                  );
                  break;
                default:
                  text = '';
                  break;
              }
              return SizedBox(
                height: 44,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefixIcon != null)
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: prefixIcon),
                      FNUIText(
                        text: text,
                        fontSize: FNFontSize14,
                        color: FNColors.iconInLight002,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      footerWidget: footerWidget ??
          CustomFooter(
            builder: (context, mode) {
              final String text;

              switch (mode) {
                case LoadStatus.noMore:
                  text = noMoreText ?? '- 已经到底啦 -';
                  break;
                default:
                  text = '';
                  break;
              }
              return SizedBox(
                height: 44,
                child: Center(
                  child: FNUIText(
                    text: text,
                    fontSize: FNFontSize14,
                    color: FNColors.textExplainColor,
                  ),
                ),
              );
            },
          ),
      emptyWidget: emptyWidget ?? const SizedBox.shrink(),
      scrollDirection: scrollDirection ?? Axis.vertical,
      enablePullDown: enablePullDown ?? true,
      enablePullUp: enablePullUp ?? true,
      reverse: reverse ?? false,
      primary: primary ?? false,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      cacheExtent: cacheExtent ?? 0.0,
      semanticChildCount: semanticChildCount ?? 0,
      hideFooterWhenNotFull: hideFooterWhenNotFull ?? false,
      refreshingText: refreshingText ?? '正在加载...',
      idleText: idleText ?? '下拉刷新',
      completedText: completedText ?? '刷新成功',
      failedText: failedText ?? '刷新失败',
      noMoreText: noMoreText ?? '- 已经到底啦 -',
    );
  }

  const FNRefreshThemeData.raw({
    required this.refreshController,
    required this.headerWidget,
    required this.footerWidget,
    required this.emptyWidget,
    required this.scrollDirection,
    required this.enablePullDown,
    required this.enablePullUp,
    required this.reverse,
    required this.primary,
    required this.physics,
    required this.cacheExtent,
    required this.semanticChildCount,
    required this.hideFooterWhenNotFull,
    required this.refreshingText,
    required this.idleText,
    required this.completedText,
    required this.failedText,
    required this.noMoreText,
  });

  FNRefreshThemeData copyWith({
    RefreshController? refreshController,
    Widget? headerWidget,
    Widget? footerWidget,
    Widget? emptyWidget,
    Axis? scrollDirection,
    bool? enablePullDown,
    bool? enablePullUp,
    bool? reverse,
    bool? primary,
    ScrollPhysics? physics,
    double? cacheExtent,
    int? semanticChildCount,
    bool? hideFooterWhenNotFull,
    String? refreshingText,
    String? idleText,
    String? completedText,
    String? failedText,
    String? noMoreText,
  }) {
    return FNRefreshThemeData(
      refreshController: refreshController ?? this.refreshController,
      headerWidget: headerWidget ?? this.headerWidget,
      footerWidget: footerWidget ?? this.footerWidget,
      emptyWidget: emptyWidget ?? this.emptyWidget,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      enablePullDown: enablePullDown ?? this.enablePullDown,
      enablePullUp: enablePullUp ?? this.enablePullUp,
      reverse: reverse ?? this.reverse,
      primary: primary ?? this.primary,
      physics: physics ?? this.physics,
      cacheExtent: cacheExtent ?? this.cacheExtent,
      semanticChildCount: semanticChildCount ?? this.semanticChildCount,
      hideFooterWhenNotFull:
          hideFooterWhenNotFull ?? this.hideFooterWhenNotFull,
      refreshingText: refreshingText ?? this.refreshingText,
      idleText: idleText ?? this.idleText,
      completedText: completedText ?? this.completedText,
      failedText: failedText ?? this.failedText,
      noMoreText: noMoreText ?? this.noMoreText,
    );
  }

  FNRefreshThemeData merge(FNRefreshThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      refreshController: other.refreshController,
      headerWidget: other.headerWidget,
      footerWidget: other.footerWidget,
      emptyWidget: other.emptyWidget,
      scrollDirection: other.scrollDirection,
      enablePullDown: other.enablePullDown,
      enablePullUp: other.enablePullUp,
      reverse: other.reverse,
      primary: other.primary,
      physics: other.physics,
      cacheExtent: other.cacheExtent,
      semanticChildCount: other.semanticChildCount,
      hideFooterWhenNotFull: other.hideFooterWhenNotFull,
      refreshingText: other.refreshingText,
      idleText: other.idleText,
      completedText: other.completedText,
      failedText: other.failedText,
      noMoreText: other.noMoreText,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      refreshController,
      headerWidget,
      footerWidget,
      emptyWidget,
      scrollDirection,
      enablePullDown,
      enablePullUp,
      reverse,
      primary,
      physics,
      cacheExtent,
      semanticChildCount,
      hideFooterWhenNotFull,
      refreshingText,
      idleText,
      completedText,
      failedText,
      noMoreText,
    ];
    return Object.hashAll(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FNRefreshThemeData &&
        other.refreshController == refreshController &&
        other.headerWidget == headerWidget &&
        other.footerWidget == footerWidget &&
        other.emptyWidget == emptyWidget &&
        other.scrollDirection == scrollDirection &&
        other.enablePullDown == enablePullDown &&
        other.enablePullUp == enablePullUp &&
        other.reverse == reverse &&
        other.primary == primary &&
        other.physics == physics &&
        other.cacheExtent == cacheExtent &&
        other.semanticChildCount == semanticChildCount &&
        other.hideFooterWhenNotFull == hideFooterWhenNotFull &&
        other.refreshingText == refreshingText &&
        other.idleText == idleText &&
        other.completedText == completedText &&
        other.failedText == failedText &&
        other.noMoreText == noMoreText &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<RefreshController>(
        'refreshController', refreshController,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('headerWidget', headerWidget,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('footerWidget', footerWidget,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('emptyWidget', emptyWidget,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Axis>('scrollDirection', scrollDirection,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enablePullDown', enablePullDown,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enablePullUp', enablePullUp,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('reverse', reverse, defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('primary', primary, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>('physics', physics,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('cacheExtent', cacheExtent,
        defaultValue: null));
    properties.add(DiagnosticsProperty<int>(
        'semanticChildCount', semanticChildCount,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>(
        'hideFooterWhenNotFull', hideFooterWhenNotFull,
        defaultValue: null));
    properties.add(DiagnosticsProperty<String>('refreshingText', refreshingText,
        defaultValue: null));
    properties.add(
        DiagnosticsProperty<String>('idleText', idleText, defaultValue: null));
    properties.add(DiagnosticsProperty<String>('completedText', completedText,
        defaultValue: null));
    properties.add(DiagnosticsProperty<String>('failedText', failedText,
        defaultValue: null));
    properties.add(DiagnosticsProperty<String>('noMoreText', noMoreText,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
