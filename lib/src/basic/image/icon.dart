import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FNUIIcon extends StatelessWidget {
  const FNUIIcon({
    Key? key,
    this.iconName,
    this.iconUrl,
    this.size,
    this.color,
    this.isPlain = false,
    this.onClick,
    this.package,
  }) : super(key: key);

  const FNUIIcon.name(
    this.iconName, {
    Key? key,
    this.size,
    this.color,
    this.isPlain = false,
    this.onClick,
    this.package,
  })  : iconUrl = null,
        super(key: key);

  const FNUIIcon.url(
    this.iconUrl, {
    Key? key,
    this.size,
    this.color,
    this.isPlain = false,
    this.onClick,
    this.package,
  })  : iconName = null,
        super(key: key);

  // ****************** Props ******************
  /// 图标名称
  final IconData? iconName;

  /// 图片链接
  final String? iconUrl;

  /// 图标颜色
  final Color? color;

  /// 图标大小
  final double? size;

  /// 资源所属包
  final String? package;

  /// 是否需要装饰
  final bool isPlain;
  // ****************** Events ******************
  /// 点击图标时触发
  final GestureTapCallback? onClick;

  // ****************** Slots ******************

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: _buildIcon(context),
    );
  }

  // 构建图片图标
  Widget? _buildIcon(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double? iconSize = size ?? iconTheme.size;

    if (iconName != null) {
      return Icon(
        iconName,
        color: isPlain ? null : (color ?? iconTheme.color),
        size: iconSize,
      );
    }

    if (iconUrl != null) {
      final bool isNetWork = RegExp('^https?:\/\/').hasMatch(iconUrl!);

      if (isNetWork) {
        return Image.network(
          iconUrl!,
          color: color, //?? textStyle.color,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.scaleDown,
        );
      }

      return Image.asset(
        iconUrl!,
        color: color, //?? textStyle.color,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.scaleDown,
        package: package,
      );
    }
    return null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<double>('size', size));
    properties.add(DiagnosticsProperty<Color>('color', color));
    super.debugFillProperties(properties);
  }
}
