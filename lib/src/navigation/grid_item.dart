import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:fn_ui_kit/src/basic/export.dart';

import '../feedback/export.dart';
import '../theme/var.dart';
import 'grid.dart';

class FNGridItem extends StatelessWidget {
  const FNGridItem({
    Key? key,
    this.text,
    this.iconName,
    this.iconUrl,
    this.dot = false,
    this.badge = '',
    this.onClick,
    this.child,
    this.iconSlot,
    this.textSlot,
    bool replace = false,
    String? toName,
    PageRoute<Object?>? toRoute,
  }) : super(
          key: key,
        );

  // ****************** Props ******************
  /// 列元素偏移距离
  final String? text;

  /// 列元素宽度
  final IconData? iconName;

  final String? iconUrl;

  final bool dot;

  final String badge;

  // ****************** Events ******************

  /// 	点击格子时触发
  final VoidCallback? onClick;

  // ****************** Slots ******************
  /// 自定义宫格的所有内容
  final Widget? child;

  /// 自定义图标
  final Widget? iconSlot;

  /// 自定义文字
  final Widget? textSlot;

  @override
  Widget build(BuildContext context) {
    final FNUIGrid? parent = FNGridScope.of(context)?.parent;
    if (parent == null) {
      throw 'GridItem must be a child widget of Grid';
    }

    final int index = parent.children.indexOf(this);

    final bool surround = parent.border && parent.gutter > 0.0;
    final Border? border = parent.border
        ? Border(
            right: const FNHairLine(),
            bottom: const FNHairLine(),
            left: surround ? const FNHairLine() : BorderSide.none,
            top: surround ? const FNHairLine() : BorderSide.none,
          )
        : null;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double size = 1 / parent.columnNum * constraints.maxWidth;
        return Container(
          width: size,
          height: parent.square ? size : null,
          padding: EdgeInsets.only(right: parent.gutter),
          margin: EdgeInsets.only(
            top: index >= parent.columnNum ? parent.gutter : 0,
          ),
          child: Semantics(
            button: parent.clickable,
            sortKey: parent.clickable ? const OrdinalSortKey(0.0) : null,
            child: Material(
              type:
                  parent.clickable ? MaterialType.button : MaterialType.canvas,
              color: FNColors.gridItemContentBackgroundColor,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: FNColors.gridItemContentActiveColor,
                onTap: parent.clickable
                    ? () {
                        onClick?.call();
                      }
                    : null,
                child: Container(
                  padding: FNColors.gridItemContentPadding,
                  decoration: BoxDecoration(border: border),
                  child: Flex(
                    mainAxisAlignment: parent.center
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    crossAxisAlignment: parent.center
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    direction: parent.direction,
                    children: _buildContext(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(BuildContext context) {
    final FNUIGrid? parent = FNGridScope.of(context)?.parent;

    // if (iconSlot != null) {
    //   return FNBadge(dot: dot, content: badge, child: iconSlot);
    // }

    if (iconName != null || iconUrl != null) {
      return FNUIIcon(
        iconName: iconName,
        iconUrl: iconUrl,
        size: parent!.iconSize ?? FNColors.gridItemIconSize,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildText(BuildContext context) {
    if (textSlot != null) {
      return textSlot!;
    }

    if (text != null) {
      return Text(text!);
    }

    return const SizedBox.shrink();
  }

  List<Widget> _buildContext(BuildContext context) {
    if (child != null) {
      return <Widget>[child!];
    }

    return <Widget>[
      _buildIcon(context),
      const SizedBox(width: FNColors.paddingXs, height: FNColors.paddingXs),
      DefaultTextStyle(
        style: const TextStyle(
          color: FNColors.gridItemTextColor,
          fontSize: FNColors.gridItemTextFontSize,
          height: 1.5,
        ),
        child: _buildText(context),
      ),
    ];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    super.debugFillProperties(properties);
  }
}
