import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/export.dart';
import '../../theme/base.dart';
import '../../theme/index.dart';
import 'button_style.dart';

/// 按钮状态
enum ButtonStatus {
  /// available - 可用
  available,

  /// unavailable - 不可用
  unavailable,

  /// loading - 加载中
  loading,
}

///按钮类型
enum ButtonType {
  ///主要按钮
  main,

  ///次要按钮
  second,

  ///文字按钮
  text,
}

IBaseTheme themeData = FNThemeManager.instance.themeData;

/// 主要按钮样式
UIButtonStyle mainStyle = UIButtonStyle(
  foregroundColor: Colors.white,
  backgroundColor: themeData.buttonConfig.btn_primary_default,
  disabledForegroundColor: Colors.white,
  disabledBackgroundColor: themeData.buttonConfig.btn_primary_disable,
  padding: EdgeInsets.zero,
  side: const BorderSide(width: 1, style: BorderStyle.none),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4))),
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
);

/// 次要按钮样式
UIButtonStyle secondStyle = mainStyle.copyWith(
  foregroundColor: FNColors.mainColor,
  backgroundColor: themeData.buttonConfig.btn_secondary_default,
  disabledForegroundColor: FNColors.color_ffC6C6C6,
  disabledBackgroundColor: themeData.buttonConfig.btn_secondary_disable,
  padding: EdgeInsets.zero,
  side: const BorderSide(width: 1, style: BorderStyle.none),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4))),
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
);

/// 文字按钮样式
UIButtonStyle textStyle = mainStyle.copyWith(
  foregroundColor: FNColors.mainColor,
  backgroundColor: FNColors.clear,
  disabledForegroundColor: FNColors.color_ffC6C6C6,
  disabledBackgroundColor: FNColors.clear,
  padding: EdgeInsets.zero,
  side: const BorderSide(width: 1, style: BorderStyle.none),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4))),
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
);

/// 加载按钮样式
UIButtonStyle loadingStyle = mainStyle.copyWith(
  foregroundColor: Colors.white,
  backgroundColor: themeData.buttonConfig.btn_primary_disable,
  // disabledForegroundColor: SMColors.color_ffC6C6C6,
  // disabledBackgroundColor: btnThemeData.btn_secondary_disable,
  padding: EdgeInsets.zero,
  side: const BorderSide(width: 1, style: BorderStyle.none),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4))),
  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
);

/*
* @description:     公共按钮组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/28 10:56
*/
class FNUIButton extends StatelessWidget {
  /// 按钮文字
  final String text;

  /// 按钮类型
  final ButtonType? buttonType;

  /// 加载中文字
  final String? loadingText;

  /// 按钮状态
  final ButtonStatus status;

  /// 按钮样式
  final UIButtonStyle? style;

  /// 按钮大小
  final Size? size;

  /// 边距
  final EdgeInsetsGeometry? margin;

  /// 按钮左侧图标
  final Widget? icon;

  /// 点击事件
  final Function? onTap;

  /// 状态控制器
  final MaterialStatesController? statesController;

  const FNUIButton({
    super.key,
    required this.text,
    this.buttonType,
    this.style,
    this.status = ButtonStatus.available,
    this.size,
    this.margin,
    this.loadingText,
    this.icon,
    this.statesController,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width ?? double.infinity,
      height: size?.height ?? 44.0,
      margin: margin,
      // alignment: size == null ? null : Alignment.centerLeft,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    UIButtonStyle style = _buttonStyle();
    if (icon == null && status != ButtonStatus.loading) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: style.foregroundColor,
            backgroundColor: style.backgroundColor,
            disabledForegroundColor: style.disabledForegroundColor,
            disabledBackgroundColor: style.disabledBackgroundColor,
            padding: style.padding,
            side: style.side,
            shape: style.shape,
            textStyle: style.textStyle,
            splashFactory: NoSplash.splashFactory),
        statesController: statesController,
        onPressed:
            status == ButtonStatus.available ? () => onTap?.call() : null,
        child: Text(text),
      );
    } else {
      return OutlinedButton.icon(
        onPressed:
            status == ButtonStatus.available ? () => onTap?.call() : null,
        style: OutlinedButton.styleFrom(
            foregroundColor: style.foregroundColor,
            backgroundColor: style.backgroundColor,
            disabledForegroundColor: style.disabledForegroundColor,
            disabledBackgroundColor: style.disabledBackgroundColor,
            padding: style.padding,
            side: style.side,
            shape: style.shape,
            textStyle: style.textStyle,
            splashFactory: NoSplash.splashFactory),
        icon: icon ??
            (status == ButtonStatus.loading
                ? const CupertinoActivityIndicator(
                    radius: 9.0,
                    color: Colors.white,
                  )
                : const Icon(Icons.add)),
        label: Text(
          text,
        ),
        statesController: statesController,
      );
    }
  }

  /*
  * @description:     根据按钮类型获取按钮样式
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/7/28 15:18
  */
  UIButtonStyle _buttonStyle() {
    if (status == ButtonStatus.loading) {
      return loadingStyle.merge(style);
    }
    if (buttonType == null || buttonType == ButtonType.main) {
      return style == null ? mainStyle : mainStyle.merge(style);
    } else if (buttonType == ButtonType.second) {
      return style == null ? secondStyle : secondStyle.merge(style);
    } else {
      return style == null ? textStyle : textStyle.merge(style);
    }
  }
}
