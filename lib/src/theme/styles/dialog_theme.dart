import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import 'package:flutter/services.dart';

/*
* @description:     弹窗主题配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/10/31 19:07
*/
class FNDialogTheme extends InheritedTheme {
  const FNDialogTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  static Widget merge({
    Key? key,
    required FNDialogThemeData data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return FNDialogTheme(
          key: key,
          data: FNDialogTheme.of(context).merge(data),
          child: child,
        );
      },
    );
  }

  final FNDialogThemeData data;

  static FNDialogThemeData of(BuildContext context) {
    final FNDialogTheme? dialogTheme =
        context.dependOnInheritedWidgetOfExactType<FNDialogTheme>();
    return dialogTheme?.data ?? FNTheme.of(context).dialogTheme;
  }

  @override
  bool updateShouldNotify(FNDialogTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FNDialogTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

class FNDialogThemeData with Diagnosticable {
  /// Dialog 宽度
  /// 默认为 300
  final double dialogWidth;

  /// Dialog 四周圆角
  final double radius;

  /// Dialog icon 距离顶部的边距
  final EdgeInsets iconPadding;

  /// title 在顶部有 icon 时的边距
  final EdgeInsets titlePaddingSm;

  /// title 当顶部无 icon 时的边距
  final EdgeInsets titlePaddingLg;

  /// title 标题样式
  final TextStyle titleTextStyle;

  /// 标题的文字对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? titleTextAlign;

  /// content 当顶部有 title 或者 icon 时的边距
  final EdgeInsets contentPaddingSm;

  /// content 当顶部无 title 或者 icon 时的边距

  final EdgeInsets contentPaddingLg;

  /// message 内容样式
  final TextStyle contentTextStyle;

  /// 内容文字的对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? contentTextAlign;

  /// warning 当顶部有 title/icon/content 时的边距
  final EdgeInsets warningPaddingSm;

  /// warning 当顶部无 title/icon/content 时的边距
  final EdgeInsets warningPaddingLg;

  /// 警告样式
  final TextStyle warningTextStyle;

  /// 警示文案文字的对齐
  /// 默认为 [TextAlign.center]
  final TextAlign? warningTextAlign;

  /// action 顶部 divider 的上方边距
  ///
  /// EdgeInsets.only(top: 28)
  final EdgeInsets dividerPadding;

  /// 主色调按钮样式
  final TextStyle mainActionTextStyle;

  /// 水平分割线 内容与按钮
  final VerticalDivider cVerticalDivider;

  /// 垂直分割线 按钮分割
  final Divider cDividerLine;

  /// 主色调按钮的背景
  final Color mainActionBackgroundColor;

  /// 其他按钮的样式(超2个时按钮样式)
  final TextStyle assistActionsTextStyle;

  /// 其他按钮的背景
  final Color assistActionsBackgroundColor;

  /// 底部按钮高度
  /// 默认为 44.0
  final double bottomHeight;

  /// Dialog背景
  final Color? backgroundColor;

  factory FNDialogThemeData({
    double? dialogWidth,
    double? radius,
    EdgeInsets? iconPadding,
    EdgeInsets? titlePaddingSm,
    EdgeInsets? titlePaddingLg,
    TextStyle? titleTextStyle,
    TextAlign? titleTextAlign,
    EdgeInsets? contentPaddingSm,
    EdgeInsets? contentPaddingLg,
    TextStyle? contentTextStyle,
    TextAlign? contentTextAlign,
    EdgeInsets? warningPaddingSm,
    EdgeInsets? warningPaddingLg,
    TextStyle? warningTextStyle,
    TextAlign? warningTextAlign,
    EdgeInsets? dividerPadding,
    TextStyle? mainActionTextStyle,
    VerticalDivider? cVerticalDivider,
    Divider? cDividerLine,
    Color? mainActionBackgroundColor,
    TextStyle? assistActionsTextStyle,
    Color? assistActionsBackgroundColor,
    double? bottomHeight,
    Color? backgroundColor,
  }) {
    return FNDialogThemeData.raw(
      dialogWidth: dialogWidth ?? 300.0,
      radius: radius ?? 6.0,
      iconPadding: iconPadding ?? const EdgeInsets.all(10),
      titlePaddingSm: titlePaddingSm ?? EdgeInsets.zero,
      titlePaddingLg: titlePaddingLg ?? const EdgeInsets.only(top: 20),
      titleTextStyle: titleTextStyle ??
          const TextStyle(
              fontFamily: 'PingFangSC',
              color: Color(0xff252525),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              height: 1.44),
      titleTextAlign: titleTextAlign ?? TextAlign.center,
      contentPaddingSm: contentPaddingLg ??
          const EdgeInsets.only(left: 24.0, top: 12, right: 24, bottom: 24),
      contentPaddingLg: contentPaddingLg ?? const EdgeInsets.all(24.0),
      contentTextStyle: contentTextStyle ??
          const TextStyle(
            fontFamily: 'PingFangSC',
            color: Color(0xff666666),
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          ),
      contentTextAlign: contentTextAlign ?? TextAlign.center,
      warningPaddingSm:
          warningPaddingSm ?? const EdgeInsets.only(left: 24.0, right: 24.0),
      warningPaddingLg: warningPaddingLg ?? EdgeInsets.zero,
      warningTextStyle: warningTextStyle ??
          const TextStyle(
              fontFamily: 'PingFangSC',
              color: FNColors.red,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              height: 1.5),
      warningTextAlign: warningTextAlign ?? TextAlign.center,
      dividerPadding: dividerPadding ?? EdgeInsets.zero,
      mainActionTextStyle: mainActionTextStyle ??
          const TextStyle(
            fontFamily: 'PingFangSC',
            color: Color(0xff0058ff),
            fontSize: 18,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          ),
      mainActionBackgroundColor: mainActionBackgroundColor ?? FNColors.white,
      assistActionsTextStyle: assistActionsTextStyle ??
          const TextStyle(
            fontFamily: 'PingFangSC',
            color: Color(0xff666666),
            fontSize: 18,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          ),
      assistActionsBackgroundColor:
          assistActionsBackgroundColor ?? FNColors.white,
      bottomHeight: bottomHeight ?? 50.0,
      backgroundColor: backgroundColor ?? FNColors.white,
      cVerticalDivider: cVerticalDivider ??
          const VerticalDivider(width: 0.5, color: Color(0xFFEAEAEA)),
      cDividerLine:
          cDividerLine ?? const Divider(height: 0.5, color: Color(0xFFEAEAEA)),
    );
  }

  const FNDialogThemeData.raw({
    required this.dialogWidth,
    required this.radius,
    required this.iconPadding,
    required this.titlePaddingSm,
    required this.titlePaddingLg,
    required this.titleTextStyle,
    required this.titleTextAlign,
    required this.contentPaddingSm,
    required this.contentPaddingLg,
    required this.contentTextStyle,
    required this.contentTextAlign,
    required this.warningPaddingSm,
    required this.warningPaddingLg,
    required this.warningTextStyle,
    required this.warningTextAlign,
    required this.dividerPadding,
    required this.mainActionTextStyle,
    required this.cVerticalDivider,
    required this.cDividerLine,
    required this.mainActionBackgroundColor,
    required this.assistActionsTextStyle,
    required this.assistActionsBackgroundColor,
    required this.bottomHeight,
    required this.backgroundColor,
  });

  FNDialogThemeData copyWith({
    double? dialogWidth,
    double? radius,
    EdgeInsets? iconPadding,
    EdgeInsets? titlePaddingSm,
    EdgeInsets? titlePaddingLg,
    TextStyle? titleTextStyle,
    TextAlign? titleTextAlign,
    EdgeInsets? contentPaddingSm,
    EdgeInsets? contentPaddingLg,
    TextStyle? contentTextStyle,
    TextAlign? contentTextAlign,
    EdgeInsets? warningPaddingSm,
    EdgeInsets? warningPaddingLg,
    TextStyle? warningTextStyle,
    TextAlign? warningTextAlign,
    EdgeInsets? dividerPadding,
    TextStyle? mainActionTextStyle,
    VerticalDivider? cVerticalDivider,
    Divider? cDividerLine,
    Color? mainActionBackgroundColor,
    TextStyle? assistActionsTextStyle,
    Color? assistActionsBackgroundColor,
    double? bottomHeight,
    Color? backgroundColor,
  }) {
    return FNDialogThemeData(
      dialogWidth: dialogWidth ?? this.dialogWidth,
      radius: radius ?? this.radius,
      iconPadding: iconPadding ?? this.iconPadding,
      titlePaddingSm: titlePaddingSm ?? this.titlePaddingSm,
      titlePaddingLg: titlePaddingLg ?? this.titlePaddingLg,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleTextAlign: titleTextAlign ?? this.titleTextAlign,
      contentPaddingSm: contentPaddingSm ?? this.contentPaddingSm,
      contentPaddingLg: contentPaddingLg ?? this.contentPaddingLg,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      contentTextAlign: contentTextAlign ?? this.contentTextAlign,
      warningPaddingSm: warningPaddingSm ?? this.warningPaddingSm,
      warningPaddingLg: warningPaddingLg ?? this.warningPaddingLg,
      warningTextStyle: warningTextStyle ?? this.warningTextStyle,
      warningTextAlign: warningTextAlign ?? this.warningTextAlign,
      dividerPadding: dividerPadding ?? this.dividerPadding,
      mainActionTextStyle: mainActionTextStyle ?? this.mainActionTextStyle,
      cVerticalDivider: cVerticalDivider ?? this.cVerticalDivider,
      cDividerLine: cDividerLine ?? this.cDividerLine,
      mainActionBackgroundColor:
          mainActionBackgroundColor ?? this.mainActionBackgroundColor,
      assistActionsTextStyle:
          assistActionsTextStyle ?? this.assistActionsTextStyle,
      assistActionsBackgroundColor:
          assistActionsBackgroundColor ?? this.assistActionsBackgroundColor,
      bottomHeight: bottomHeight ?? this.bottomHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  FNDialogThemeData merge(FNDialogThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      dialogWidth: other.dialogWidth,
      radius: other.radius,
      iconPadding: other.iconPadding,
      titlePaddingSm: other.titlePaddingSm,
      titlePaddingLg: other.titlePaddingLg,
      titleTextStyle: other.titleTextStyle,
      titleTextAlign: other.titleTextAlign,
      contentPaddingSm: other.contentPaddingSm,
      contentPaddingLg: other.contentPaddingLg,
      contentTextStyle: other.contentTextStyle,
      contentTextAlign: other.contentTextAlign,
      warningPaddingSm: other.warningPaddingSm,
      warningPaddingLg: other.warningPaddingLg,
      warningTextStyle: other.warningTextStyle,
      warningTextAlign: other.warningTextAlign,
      dividerPadding: other.dividerPadding,
      mainActionTextStyle: other.mainActionTextStyle,
      cVerticalDivider: other.cVerticalDivider,
      cDividerLine: other.cDividerLine,
      mainActionBackgroundColor: other.mainActionBackgroundColor,
      assistActionsTextStyle: other.assistActionsTextStyle,
      assistActionsBackgroundColor: other.assistActionsBackgroundColor,
      bottomHeight: other.bottomHeight,
      backgroundColor: other.backgroundColor,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      dialogWidth,
      radius,
      iconPadding,
      titlePaddingSm,
      titlePaddingLg,
      titleTextStyle,
      titleTextAlign,
      contentPaddingSm,
      contentPaddingLg,
      contentTextStyle,
      contentTextAlign,
      warningPaddingSm,
      warningPaddingLg,
      warningTextStyle,
      warningTextAlign,
      dividerPadding,
      mainActionTextStyle,
      cVerticalDivider,
      cDividerLine,
      mainActionBackgroundColor,
      assistActionsTextStyle,
      assistActionsBackgroundColor,
      bottomHeight,
      backgroundColor,
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
    return other is FNDialogThemeData &&
        other.dialogWidth == dialogWidth &&
        other.radius == radius &&
        other.iconPadding == iconPadding &&
        other.titlePaddingSm == titlePaddingSm &&
        other.titlePaddingLg == titlePaddingLg &&
        other.titleTextStyle == titleTextStyle &&
        other.titleTextAlign == titleTextAlign &&
        other.contentPaddingSm == contentPaddingSm &&
        other.contentPaddingLg == contentPaddingLg &&
        other.contentTextStyle == contentTextStyle &&
        other.contentTextAlign == contentTextAlign &&
        other.warningPaddingSm == warningPaddingSm &&
        other.warningPaddingLg == warningPaddingLg &&
        other.warningTextStyle == warningTextStyle &&
        other.warningTextAlign == warningTextAlign &&
        other.dividerPadding == dividerPadding &&
        other.mainActionTextStyle == mainActionTextStyle &&
        other.cVerticalDivider == cVerticalDivider &&
        other.cDividerLine == cDividerLine &&
        other.mainActionBackgroundColor == mainActionBackgroundColor &&
        other.assistActionsTextStyle == assistActionsTextStyle &&
        other.assistActionsBackgroundColor == assistActionsBackgroundColor &&
        other.bottomHeight == bottomHeight &&
        other.backgroundColor == backgroundColor &&
        1 == 1;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<double>('dialogWidth', dialogWidth,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<double>('radius', radius, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>('iconPadding', iconPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'titlePaddingSm', titlePaddingSm,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'titlePaddingLg', titlePaddingLg,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'titleTextStyle', titleTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextAlign>(
        'titleTextAlign', titleTextAlign,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'contentPaddingSm', contentPaddingSm,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'contentPaddingLg', contentPaddingLg,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'contentTextStyle', contentTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextAlign>(
        'contentTextAlign', contentTextAlign,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'warningPaddingSm', warningPaddingSm,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'warningPaddingLg', warningPaddingLg,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'warningTextStyle', warningTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextAlign>(
        'warningTextAlign', warningTextAlign,
        defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsets>(
        'dividerPadding', dividerPadding,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'mainActionTextStyle', mainActionTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<VerticalDivider>(
        'cVerticalDivider', cVerticalDivider,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Divider>('cDividerLine', cDividerLine,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'mainActionBackgroundColor', mainActionBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<TextStyle>(
        'assistActionsTextStyle', assistActionsTextStyle,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'assistActionsBackgroundColor', assistActionsBackgroundColor,
        defaultValue: null));
    properties.add(DiagnosticsProperty<double>('bottomHeight', bottomHeight,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Color>(
        'backgroundColor', backgroundColor,
        defaultValue: null));
    super.debugFillProperties(properties);
  }
}
