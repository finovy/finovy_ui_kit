import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUITag extends StatelessWidget {
  const FNUITag({
    Key? key,
    this.type = FNTagType.success,
    this.size = FNTagSize.normal,
    this.color,
    this.plain = false,
    this.round = false,
    this.mark = false,
    this.textColor,
    this.closeable = false,
    this.show = true,
    this.onClose,
    this.child,
  }) : super(key: key);

  // ****************** Props ******************
  /// 类型，可选值为 `normal` `primary` `success` `danger` `warning`
  final FNTagType type;

  /// 大小, 可选值为 `large` `medium`
  final FNTagSize size;

  /// 标签颜色
  final Color? color;

  /// 是否为空心样式
  final bool plain;

  /// 是否为圆角样式
  final bool round;

  /// 是否为标记样式
  final bool mark;

  /// 文本颜色，优先级高于`color`属性
  final Color? textColor;

  /// 是否为可关闭标签
  final bool closeable;

  /// 是否显示
  final bool show;

  // ****************** Events ******************

  /// 标签关闭的回调事件
  final VoidCallback? onClose;

  // ****************** Slots ******************

  /// 标签显示内容
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final FNTagThemeData themeData = FNTagTheme.of(context);

    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: FNColors.animationDurationBase,
      curve: show
          ? FNColors.animationTimingFunctionLeave
          : FNColors.animationTimingFunctionEnter,
      child: _buildTag(themeData),
    );
  }

  /// 计算标签不同size的padding
  EdgeInsets _getTagPadding(FNTagThemeData themeData) {
    switch (size) {
      case FNTagSize.normal:
        return themeData.padding;
      case FNTagSize.medium:
        return themeData.mediumPadding;
      case FNTagSize.large:
        return themeData.largePadding;
    }
  }

  /// 计算标签不同type的主题色
  Color _getThemeColor(FNTagThemeData themeData) {
    switch (type) {
      case FNTagType.normal:
        return themeData.defaultColor;
      case FNTagType.primary:
        return themeData.primaryColor;
      case FNTagType.success:
        return themeData.successColor;
      case FNTagType.warning:
        return themeData.warningColor;
      case FNTagType.danger:
        return themeData.dangerColor;
    }
  }

  /// 计算标签文字颜色
  Color _getTextColor(FNTagThemeData themeData) {
    if (textColor != null) {
      return textColor!;
    }
    if (color != null && plain) {
      return color!;
    }
    if (plain) {
      return _getThemeColor(themeData);
    }
    switch (type) {
      case FNTagType.normal:
        return FNColors.tagTextColor;
      case FNTagType.primary:
        return FNColors.tagPrimaryTextColor;
      case FNTagType.success:
        return FNColors.tagSuccessTextColor;
      case FNTagType.warning:
        return FNColors.tagWarningTextColor;
      case FNTagType.danger:
        return FNColors.tagDangerTextColor;
    }
  }

  /// 计算标签背景颜色
  Color _getBackgroundColor(FNTagThemeData themeData) => plain
      ? themeData.plainBackgroundColor
      : (color ?? _getThemeColor(themeData));

  /// 计算标签字体大小
  double _getTextSize(FNTagThemeData themeData) =>
      size == FNTagSize.large ? themeData.largeFontSize : themeData.fontSize;

  /// 计算标签圆角大小
  BorderRadius _getBorderRadius(FNTagThemeData themeData) {
    if (mark) {
      return BorderRadius.only(
        topRight: Radius.circular(themeData.roundBorderRadius),
        bottomRight: Radius.circular(themeData.roundBorderRadius),
      );
    }

    if (round) {
      return BorderRadius.circular(themeData.roundBorderRadius);
    }

    if (size == FNTagSize.large) {
      return BorderRadius.circular(themeData.largeBorderRadius);
    }

    return BorderRadius.circular(themeData.borderRadius);
  }

  /// 构建标签
  Widget _buildTag(FNTagThemeData themeData) {
    final Color textColor = _getTextColor(themeData);
    final Color bgColor = _getBackgroundColor(themeData);
    final double fontSize = _getTextSize(themeData);

    return Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(plain
            ? BorderSide(width: 1.0, color: _getTextColor(themeData))
            : BorderSide.none),
        color: bgColor,
        borderRadius: _getBorderRadius(themeData),
      ),
      padding: _getTagPadding(themeData),
      child: DefaultTextStyle(
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          height: themeData.lineHeight,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            child ?? const SizedBox.shrink(),
            if (closeable)
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: FNUIIcon.name(
                  Icons.clear,
                  onClick: onClose,
                  size: fontSize,
                  color: textColor,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<FNTagType>('type', type,
        defaultValue: FNTagType.normal));
    properties.add(DiagnosticsProperty<FNTagSize>('size', size,
        defaultValue: FNTagSize.normal));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties
        .add(DiagnosticsProperty<bool>('plain', plain, defaultValue: false));

    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: false));

    properties
        .add(DiagnosticsProperty<bool>('mark', mark, defaultValue: false));
    properties.add(DiagnosticsProperty<Color>('textColor', textColor));
    properties.add(
        DiagnosticsProperty<bool>('closeable', closeable, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('show', show, defaultValue: true));

    super.debugFillProperties(properties);
  }
}

/// 标签类型集合
enum FNTagType {
  normal,
  primary,
  success,
  warning,
  danger,
}

/// 标签大小集合
enum FNTagSize {
  normal,
  medium,
  large,
}
