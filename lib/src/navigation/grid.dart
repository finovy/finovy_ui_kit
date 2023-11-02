import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../feedback/export.dart';
import 'grid_item.dart';

/*
* @description:     网格组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/10/25 12:12
*/
class FNUIGrid extends StatelessWidget {
  const FNUIGrid({
    Key? key,
    this.columnNum = 4,
    this.iconSize,
    this.gutter = 0.0,
    this.border = true,
    this.center = true,
    this.square = false,
    this.clickable = false,
    this.direction = Axis.vertical,
    this.children = const <FNGridItem>[],
  }) : super(key: key);

  // ****************** Props ******************
  /// 列数
  final int columnNum;

  /// 图标大小
  final double? iconSize;

  /// 格子之间的间距
  final double gutter;

  /// 是否显示边框
  final bool border;

  /// 是否将格子内容居中显示
  final bool center;

  /// 是否将格子固定为正方形
  final bool square;

  /// 是否开启格子点击反馈
  final bool clickable;

  /// 格子内容排列的方向，可选值为 `horizontal` `vertical`
  final Axis direction;

  // ****************** Events ******************

  // ****************** Slots ******************
  // 内容
  final List<FNGridItem> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: border && gutter == 0.0 ? const FNHairLine() : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.only(left: gutter),
      child: FNGridScope(
        parent: this,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
        .add(DiagnosticsProperty<int>('columnNum', columnNum, defaultValue: 4));
    properties.add(
        DiagnosticsProperty<double>('iconSize', iconSize, defaultValue: 28.0));
    properties
        .add(DiagnosticsProperty<double>('gutter', gutter, defaultValue: 0.0));
    properties
        .add(DiagnosticsProperty<bool>('border', border, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('center', center, defaultValue: true));
    properties
        .add(DiagnosticsProperty<bool>('square', square, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('clickable', clickable, defaultValue: false));
    properties.add(DiagnosticsProperty<Axis>('direction', direction,
        defaultValue: Axis.vertical));
    super.debugFillProperties(properties);
  }
}

class FNGridScope extends InheritedWidget {
  const FNGridScope({
    Key? key,
    required this.parent,
    required Widget child,
  }) : super(key: key, child: child);

  final FNUIGrid parent;

  static FNGridScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FNGridScope>();
  }

  @override
  bool updateShouldNotify(FNGridScope oldWidget) {
    return parent != oldWidget.parent;
  }
}
