import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/// 按钮状态
enum ButtonStatus {
  /// available - 可用
  available,

  /// unavailable - 不可用
  unavailable,

  /// loading - 加载中
  loading,
}

class FNUIButton extends StatelessWidget {
  const FNUIButton({
    Key? key,
    this.type = FNButtonType.primary,
    this.status = ButtonStatus.available,
    this.size = FNButtonSize.normal,
    this.text = '',
    this.color,
    this.gradient,
    this.iconName,
    this.iconUrl,
    this.iconPosition = FlanButtonIconPosition.left,
    this.block = false,
    this.plain = false,
    this.round = false,
    this.square = false,
    this.hairline = false,
    this.border = false,
    this.textColor,
    this.loadingText = '',
    this.loadingType = FNLoadingType.circular,
    this.loadingSize,
    this.radius,
    this.onTap,
    this.child,
    this.loadingSlot,
    this.margin = EdgeInsets.zero,
    String? toName,
    PageRoute<Object?>? toRoute,
    bool replace = false,
  }) : super(
          key: key,
        );

  // ****************** Props ******************
  /// 类型，可选值为 `primary` `info` `warning` `danger`
  final FNButtonType type;

  /// 按钮状态（兼容旧版本）
  final ButtonStatus status;

  // 尺寸，可选值为 `large` `small` `mini`
  final FNButtonSize size;

  /// 按钮文字
  final String text;

  /// 按钮颜色，
  final Color? color;

  /// 按钮颜色(支持传入 linear-gradient 渐变色)
  final Gradient? gradient;

  /// 左侧图标名称
  final IconData? iconName;

  /// 左侧图片链接
  final String? iconUrl;

  /// 图标展示位置，可选值为 `right`
  final FlanButtonIconPosition iconPosition;

  /// 是否为块级元素
  final bool block;

  /// 是否为朴素按钮
  final bool plain;

  /// 是否为圆形按钮
  final bool round;

  /// 是否为方形按钮
  final bool square;

  /// 是否使用 0.5px 边框
  final bool hairline;

  /// 是否有边框
  final bool border;

  /// 加载状态提示文字
  final String loadingText;

  /// 加载图标类型，可选值为 `spinner`
  final FNLoadingType loadingType;

  /// 加载图标大小
  final double? loadingSize;

  /// 圆角大小
  final BorderRadius? radius;

  /// 文字颜色
  final Color? textColor;

  // ****************** Events ******************
  /// 点击按钮，且按钮状态不为加载或禁用时触发
  final GestureTapCallback? onTap;

  // ****************** Slots ******************
  /// 按钮内容
  final Widget? child;

  /// 自定义加载图标
  final Widget? loadingSlot;

  /// 间距（兼容旧版本）
  final EdgeInsetsGeometry margin;

  bool get loading => status == ButtonStatus.loading;
  bool get disabled => status == ButtonStatus.unavailable;

  @override
  Widget build(BuildContext context) {
    final FNButtonThemeData themeData = FNButtonTheme.of(context);

    final _FNButtonSize btnSize = _getBtnSize(themeData);
    final _FNButtonTheme themeType = _getThemeType(themeData);

    final BorderRadius radius = this.radius ??
        (square
            ? BorderRadius.zero
            : BorderRadius.circular(
                round ? btnSize.height / 2.0 : themeData.borderRadius,
              ));

    final TextStyle textStyle = TextStyle(
      fontSize: btnSize.fontSize,
      height: themeData.defaultLineHeight,
      color: textColor ??
          ((disabled) ? FNColors.buttonDefaultDisabledColor : themeType.color),
    );

    final Color bgColor = (plain ? null : color) ?? themeType.backgroundColor;

    final Widget? sideIcon = _buildIcon(themeData, themeType);

    final Widget btn = DefaultTextStyle(
      style: textStyle,
      child: Container(
        decoration: BoxDecoration(
          border: themeType.border,
          borderRadius: radius,
          gradient: color != null ? null : gradient,
          color: bgColor,
        ),
        height: btnSize.height,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: btnSize.padding,
              child: _buildContent(sideIcon),
            ),
            Positioned.fill(
              child: FNActiveResponse(
                disabled: disabled || loading,
                cursorBuilder: (SystemMouseCursor cursor) =>
                    loading ? SystemMouseCursors.basic : cursor,
                onClick: () {
                  onTap?.call();
                },
                builder: (BuildContext context, bool active, Widget? child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: active
                          ? FNColors.black.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: radius,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: margin,
      child: Semantics(
        container: true,
        button: true,
        enabled: !disabled,
        child: Opacity(
          opacity: (disabled || loading) ? 0.5 : 1.0,
          child: btn,
        ),
      ),
    );
  }

  /// 构建图标
  Widget? _buildIcon(
    FNButtonThemeData themeData,
    _FNButtonTheme _themeType,
  ) {
    if (loading) {
      return loadingSlot ??
          CupertinoActivityIndicator(
            radius: 9.0,
            color: (type == FNButtonType.normal) ? textColor : FNColors.white,
          );
    }

    if (iconName != null || iconUrl != null) {
      return FNUIIcon(
        iconName: iconName,
        iconUrl: iconUrl,
        color: _themeType.color,
        size: themeData.iconSize,
      );
    }
    return null;
  }

  /// 构建内容
  Widget _buildContent(Widget? sideIcon) {
    final List<Widget> children = <Widget>[
      if (loading)
        Text(loadingText.isEmpty ? text : '')
      else
        child ?? Text(text),
    ];

    if (sideIcon != null) {
      switch (iconPosition) {
        case FlanButtonIconPosition.left:
          if (_isHasText) {
            children.insert(0, const SizedBox(width: 4.0));
          }
          children.insert(0, sideIcon);
          break;
        case FlanButtonIconPosition.right:
          if (_isHasText) {
            children.add(const SizedBox(width: 4.0));
          }
          children.add(sideIcon);
          break;
      }
    }

    if (size == FNButtonSize.large || block) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }

  /// 计算按钮样式
  _FNButtonTheme _computedThemeType(
    FNButtonThemeData themeData, {
    required Color backgroundColor,
    required Color color,
    required Color borderColor,
  }) {
    if (this.color != null) {
      borderColor = this.color!;
      color = Colors.white;
    }

    if (gradient != null) {
      borderColor = Colors.transparent;
      color = Colors.white;
    }

    BorderSide borderSide = BorderSide.none;
    if (border) {
      borderSide = BorderSide(
        width: hairline ? 0.5 : themeData.borderWidth,
        color: borderColor,
      );
    }

    return _FNButtonTheme(
      backgroundColor: plain ? themeData.plainBackgroundColor : backgroundColor,
      color: plain ? borderColor : color,
      border: Border.fromBorderSide(borderSide),
    );
  }

  /// 按钮是否有内容
  bool get _isHasText => text.isNotEmpty || child != null;

  /// 按钮大小集合
  _FNButtonSize _getBtnSize(FNButtonThemeData themeData) {
    switch (size) {
      case FNButtonSize.large:
        return _FNButtonSize(
          fontSize: themeData.defaultFontSize,
          height: themeData.largeHeight,
          padding: EdgeInsets.zero, //themeData.normalPadding,
        );

      case FNButtonSize.normal:
        return _FNButtonSize(
          fontSize: themeData.normalFontSize,
          height: themeData.defaultHeight,
          padding: themeData.normalPadding,
        );

      case FNButtonSize.small:
        return _FNButtonSize(
          fontSize: themeData.smallFontSize,
          height: themeData.smallHeight,
          padding: themeData.smallPadding,
        );

      case FNButtonSize.mini:
        return _FNButtonSize(
          fontSize: themeData.miniFontSize,
          height: themeData.miniHeight,
          padding: themeData.miniPadding,
        );
    }
  }

  /// 按钮样式集合
  _FNButtonTheme _getThemeType(FNButtonThemeData themeData) {
    switch (type) {
      case FNButtonType.primary:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.primaryBackgroundColor,
          color: themeData.primaryColor,
          borderColor: themeData.primaryBorderColor,
        );
      case FNButtonType.success:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.successBackgroundColor,
          color: themeData.successColor,
          borderColor: themeData.successBorderColor,
        );
      case FNButtonType.danger:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.dangerBackgroundColor,
          color: themeData.dangerColor,
          borderColor: themeData.dangerBorderColor,
        );
      case FNButtonType.warning:
        return _computedThemeType(
          themeData,
          backgroundColor: themeData.warningBackgroundColor,
          color: themeData.warningColor,
          borderColor: themeData.warningBorderColor,
        );
      case FNButtonType.normal:
        return _computedThemeType(
          themeData,
          backgroundColor: FNColors.buttonAssDefaultBackgroundColor,
          color: loading ? FNColors.textAssistantColor : themeData.defaultColor,
          borderColor: themeData.defaultBorderColor,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text, defaultValue: ''));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties
        .add(DiagnosticsProperty<bool>('block', block, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('plain', plain, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('round', round, defaultValue: false));
    properties
        .add(DiagnosticsProperty<bool>('square', square, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('hairline', hairline, defaultValue: false));
    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<FNButtonType>('type', type,
        defaultValue: FNButtonType.normal));
    properties.add(DiagnosticsProperty<FNButtonSize>('size', size,
        defaultValue: FNButtonSize.normal));
    properties.add(DiagnosticsProperty<double>('loadingSize', loadingSize));
    properties.add(DiagnosticsProperty<FlanButtonIconPosition>(
        'iconPosition', iconPosition,
        defaultValue: FlanButtonIconPosition.left));
    properties.add(DiagnosticsProperty<BorderRadius>('radius', radius));
    super.debugFillProperties(properties);
  }
}

/// 按钮主题样式类
class _FNButtonTheme {
  _FNButtonTheme({
    required this.color,
    required this.backgroundColor,
    this.border,
  }) : super();

  final Color backgroundColor;
  final Color color;
  final Border? border;
}

/// 按钮大小样式类
class _FNButtonSize {
  _FNButtonSize({
    required this.fontSize,
    required this.height,
    required this.padding,
  }) : super();

  final double fontSize;
  final double height;
  final EdgeInsets padding;
}

/// 按钮类型
enum FNButtonType {
  normal,
  primary,
  success,
  warning,
  danger,
}

/// 按钮大小
enum FNButtonSize {
  large,
  normal,
  small,
  mini,
}

/// 图标展示位置
enum FlanButtonIconPosition {
  left,
  right,
}

/// 类型
enum FNLoadingType {
  circular,
  spinner,
}
