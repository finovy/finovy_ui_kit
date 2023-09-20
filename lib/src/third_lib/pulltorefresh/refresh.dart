import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../basic/export.dart';
import '../../constant/export.dart';
import 'src/indicator/custom_indicator.dart';
import 'src/smart_refresher.dart';

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
  final String refreshingText;

  /// 下拉刷新的文案
  final String idleText;

  /// 刷新完成文案
  final String completedText;

  /// 刷新失败文案
  final String failedText;

  /// 没有更多文案
  final String noMoreText;

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
    this.refreshingText = '正在加载...',
    this.idleText = '下拉刷新',
    this.completedText = '刷新成功',
    this.failedText = '刷新失败',
    this.noMoreText = '- 已经到底啦 -',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: enablePullDown ?? true,
      enablePullUp: enablePullUp ?? true,
      header: headerWidget ??
          // ClassicHeader(
          //   releaseText: '松开开始刷新数据',
          //   refreshingText: '刷新中…',
          //   completeText: '刷新成功',
          //   failedText: '刷新失败，请检查网络',
          //   idleText: '下拉刷新',
          //   canTwoLevelText: '松开开始刷新数据',
          // ),
          CustomHeader(
            builder: (context, mode) {
              final String text;
              Widget? prefixIcon;
              switch (mode) {
                case RefreshStatus.idle:
                  text = idleText;
                  prefixIcon = const Icon(
                    Icons.arrow_downward,
                    color: FNColors.color_FF666666,
                    size: 16,
                  );
                  break;
                // case RefreshStatus.canRefresh:
                //   text = '松开后刷新';
                //   prefixIcon = const Icon(
                //     Icons.arrow_downward,
                //     color: SMColors.color_FF666666,
                //     size: 16,
                //   );
                //   break;
                case RefreshStatus.refreshing:
                  text = refreshingText;
                  prefixIcon = const CupertinoActivityIndicator(
                    color: FNColors.color_FF666666,
                    radius: 8,
                  );
                  break;
                case RefreshStatus.completed:
                  text = completedText;
                  prefixIcon = const Icon(
                    Icons.check,
                    color: FNColors.color_FF666666,
                    size: 16,
                  );
                  break;
                case RefreshStatus.failed:
                  text = failedText;
                  prefixIcon = const Icon(
                    Icons.close,
                    color: FNColors.color_FF666666,
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
                        color: FNColors.color_FF666666,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      footer: footerWidget ??
          // CustomFooter(
          //   builder: (c, mode) {
          //     Widget body;
          //     if (mode == LoadStatus.idle) {
          //       body = const Text("上拉加载",
          //           style: TextStyle(
          //               fontSize: SMFontSize12,
          //               color: Color.fromRGBO(102, 102, 102, 1)));
          //     } else if (mode == LoadStatus.loading) {
          //       body = const CupertinoActivityIndicator();
          //     } else if (mode == LoadStatus.failed) {
          //       body = const Text("加载失败！点击重试！",
          //           style: TextStyle(
          //               fontSize: SMFontSize12,
          //               color: Color.fromRGBO(102, 102, 102, 1)));
          //     } else if (mode == LoadStatus.canLoading) {
          //       body = const Text("松手,加载更多!",
          //           style: TextStyle(
          //               fontSize: SMFontSize12,
          //               color: Color.fromRGBO(102, 102, 102, 1)));
          //     } else {
          //       body = const Text("没有更多数据了!",
          //           style: TextStyle(
          //               fontSize: SMFontSize12,
          //               color: Color.fromRGBO(102, 102, 102, 1)));
          //     }
          //     return SizedBox(
          //       height: 55.0,
          //       child: Center(child: body),
          //     );
          //   },
          // ),
          CustomFooter(
            builder: (context, mode) {
              final String text;

              switch (mode) {
                case LoadStatus.noMore:
                  text = noMoreText;
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
                    color: FNColors.color_f8c8c8c,
                  ),
                ),
              );
            },
          ),
      controller: refreshController ?? RefreshController(),
      scrollController: scrollController,
      reverse: reverse,
      primary: primary,
      physics: physics,
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
