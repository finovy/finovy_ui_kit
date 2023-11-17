import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUIButton extends StatelessWidget {
  const FNUIButton({
    Key? key,
    this.type = FNButtonType.primary,
    this.status = ButtonStatus.available,
    this.text = '',
    this.color,
    this.gradient,
    this.iconName,
    this.iconUrl,
    this.iconPosition = FNButtonIconPosition.left,
    this.border = false,
    this.textStyle,
    this.loadingText = '',
    this.loadingSize,
    this.radius,
    this.height,
    this.onTap,
    this.child,
    this.loadingSlot,
    this.margin = EdgeInsets.zero,
  }) : super(
          key: key,
        );

  // ****************** Props ******************
  /// 类型，
  final FNButtonType type;

  /// 按钮状态（兼容旧版本）
  final ButtonStatus status;

  /// 按钮文字
  final String text;

  /// 按钮颜色，
  final Color? color;

  /// 文本样式
  final TextStyle? textStyle;

  /// 按钮颜色(支持传入 linear-gradient 渐变色)
  final Gradient? gradient;

  /// 左侧图标名称
  final IconData? iconName;

  /// 左侧图片链接
  final String? iconUrl;

  /// 图标展示位置，可选值为 `right`
  final FNButtonIconPosition iconPosition;

  /// 是否有边框
  final bool border;

  /// 加载状态提示文字
  final String loadingText;

  /// 加载图标大小
  final double? loadingSize;

  /// 圆角大小
  final BorderRadius? radius;

  /// 按钮高度
  final double? height;
  // ****************** Slots ******************
  /// 按钮内容
  final Widget? child;

  /// 自定义加载图标
  final Widget? loadingSlot;

  /// 间距（兼容旧版本）
  final EdgeInsetsGeometry margin;
  // ****************** Events ******************
  /// 点击按钮，且按钮状态不为加载或禁用时触发
  final GestureTapCallback? onTap;
  bool get loading => status == ButtonStatus.loading;
  bool get disabled => status == ButtonStatus.unavailable;

  /// 按钮是否有内容
  bool get _isHasText => text.isNotEmpty || child != null;

  FNButtonThemeData get _themeData {
    switch (type) {
      case FNButtonType.secondary:
        return FNButtonThemeData.secondary();
      case FNButtonType.hollowed:
        return FNButtonThemeData.hollowed();
      case FNButtonType.text:
        return FNButtonThemeData.link();
      default:
        return FNButtonThemeData();
    }
  }

  TextStyle _labelStyle(FNButtonThemeData data) {
    Color color = data.textColor;
    if (loading) {
      color = data.loadingTextColor;
    }
    if (disabled) {
      color = data.disabledTextColor;
    }
    return TextStyle(
      fontSize: data.defaultFontSize,
      fontWeight: data.defaultFontWeight,
      color: color,
    );
  }

  Color _bgColor(FNButtonThemeData data) {
    if (loading) {
      return data.disabledBackgroundColor;
    }
    if (disabled) {
      return data.disabledBackgroundColor;
    }
    return data.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    FNButtonThemeData themeData = FNButtonTheme.of(context);
    if (type != FNButtonType.primary) themeData = _themeData;

    final TextStyle textStyle = this.textStyle ?? _labelStyle(themeData);

    final Color bgColor = _bgColor(themeData);

    final Widget? sideIcon = _buildIcon(
      themeData,
    );
    final BorderRadius radius = this.radius ??
        BorderRadius.circular(
          themeData.borderRadius,
        );

    BorderSide borderSide = BorderSide.none;
    if (border || type == FNButtonType.hollowed) {
      borderSide = BorderSide(
        width: themeData.borderWidth,
        color: themeData.borderColor,
      );
    }
    final Widget btn = DefaultTextStyle(
      style: textStyle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(borderSide),
          borderRadius: radius,
          gradient: color != null ? null : gradient,
          color: bgColor,
        ),
        height: height ?? themeData.defaultHeight,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: FNColors.paddingBase),
              child: _buildContent(sideIcon),
            ),
            Positioned.fill(
              child: FNActiveResponse(
                disabled: disabled || loading,
                cursorBuilder: (SystemMouseCursor cursor) =>
                    loading ? SystemMouseCursors.basic : cursor,
                onClick: () => onTap?.call(),
                builder: (BuildContext context, bool active, Widget? child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      color: active
                          ? themeData.pressedBackgroundColor
                          : FNColors.clear,
                    ),
                    child: _buildContent(
                      sideIcon,
                      isActive: active,
                      pressedTextColor: themeData.pressedTextColor,
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
        child: btn,
      ),
    );
  }

  /// 构建图标
  Widget? _buildIcon(
    FNButtonThemeData themeData,
  ) {
    if (loading) {
      return loadingSlot ??
          CupertinoActivityIndicator(
              radius: FNColors.btnIconLoadingRadius,
              color: themeData.loadingTextColor);
    }

    if (iconName != null || iconUrl != null) {
      return FNUIIcon(
        iconName: iconName,
        iconUrl: iconUrl,
        color: themeData.textColor,
        size: loadingSize ?? FNColors.btnIconDefaultSize,
      );
    }
    return null;
  }

  /// 构建内容
  Widget _buildContent(Widget? sideIcon,
      {Color? pressedTextColor, bool isActive = false}) {
    final List<Widget> children = <Widget>[
      if (loading)
        Text(loadingText.isNotEmpty ? loadingText : '')
      else
        child ??
            Text(
              text,
              style: isActive ? TextStyle(color: pressedTextColor) : null,
            ),
    ];

    if (sideIcon != null) {
      switch (iconPosition) {
        case FNButtonIconPosition.left:
          if (_isHasText) {
            children.insert(0, const SizedBox(width: 4.0));
          }
          children.insert(0, sideIcon);
          break;
        case FNButtonIconPosition.right:
          if (_isHasText) {
            children.add(const SizedBox(width: 4.0));
          }
          children.add(sideIcon);
          break;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<String>('text', text, defaultValue: ''));
    properties.add(DiagnosticsProperty<IconData>('iconName', iconName));
    properties.add(DiagnosticsProperty<String>('iconUrl', iconUrl));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(
        DiagnosticsProperty<bool>('loading', loading, defaultValue: false));

    properties.add(
        DiagnosticsProperty<bool>('disabled', disabled, defaultValue: false));
    properties.add(DiagnosticsProperty<FNButtonType>('type', type,
        defaultValue: FNButtonType.primary));
    properties.add(DiagnosticsProperty<double>('loadingSize', loadingSize));
    properties.add(DiagnosticsProperty<FNButtonIconPosition>(
        'iconPosition', iconPosition,
        defaultValue: FNButtonIconPosition.left));
    properties.add(DiagnosticsProperty<BorderRadius>('radius', radius));
    super.debugFillProperties(properties);
  }
}

/// 按钮类型
enum FNButtonType {
  primary,
  secondary,
  hollowed,
  text,
}

/// 按钮状态
enum ButtonStatus {
  /// available - 可用
  available,

  /// unavailable - 不可用
  unavailable,

  /// loading - 加载中
  loading,
}

/// 图标展示位置
enum FNButtonIconPosition {
  left,
  right,
}
