import 'package:flutter/material.dart';

import '../theme/index.dart';

class FNColors {
  /*
   *  十六进制颜色
   *  hex, 十六进制值，例如：0xffffff,
   *  alpha, 透明度 [0.0,1.0]
   */
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  static Color get mainColor =>
      FNThemeManager.instance.themeData.mainConfig.mainColor ??
      FNColors.color_ffFFFFFF;
  static Color get mainRed =>
      FNThemeManager.instance.themeData.mainConfig.mainRed ??
      FNColors.color_ffFFFFFF;
  static Color get mainGreen =>
      FNThemeManager.instance.themeData.mainConfig.mainGreen ??
      FNColors.color_ffFFFFFF;
  // static  Color get  mainBlue => FNThemeManager.instance.themeData.mainConfig?.mainGreen??SMColors.color_ffFFFFFF;
  static Color get mainYellow => Colors.yellow;
  static Color get card =>
      FNThemeManager.instance.themeData.mainConfig.card ??
      FNColors.color_ffFFFFFF;
  static Color get line =>
      FNThemeManager.instance.themeData.otherConfig.splitter_bg ??
      FNColors.color_ffFFFFFF;
  static Color get background =>
      FNThemeManager.instance.themeData.backgroundConfig.commonColor ??
      FNColors.color_ffFFFFFF;
  static Color get fontMain =>
      FNThemeManager.instance.themeData.textConfig.text_primary ??
      FNColors.color_ffFFFFFF;
  static Color get fontNormal =>
      FNThemeManager.instance.themeData.textConfig.text_secondary ??
      FNColors.color_ffFFFFFF;
  static Color get fontTips =>
      FNThemeManager.instance.themeData.textConfig.text_tip ??
      FNColors.color_ffFFFFFF;
  static Color get warningColor =>
      FNThemeManager.instance.themeData.textConfig.warningColor ??
      FNColors.color_ffEE0A24;

  static Color clear = Colors.transparent;
  static Color shadow = const Color(0xffc0c0c0);
  static Color blank = const Color.fromRGBO(85, 86, 89, 0.5);

  /// UI主题色
  static const Color color_ff0058ff = Color(0xff0058ff); //light
  static const Color color_ff14122C = Color(0xff14122C); //dark

  /// *************************图标色*******************************///
  /// 白色背景上的图标
  static const Color color_ff252525 = Color(0xff252525);

  /// 白色背景上的图标
  static const Color color_ff666666 = Color(0xff666666);

  /// 白色背景上的图标
  static const Color color_f8c8c8c = Color(0xff8c8c8c);

  /// 白色背景上的图标
  static const Color color_ffc6c6c6 = Color(0xffc6c6c6);

  /// 白色背景上的图标
  static const Color color_ffDDDDDD = Color(0xffdddddd);

  /// 深色背景上的图标
  static const Color color_ffFFFFFF = Color(0xffffffff);

  /// 表示信息提示的图标
  static const Color color_ff2F86F6 = Color(0xff2F86F6);

  /// 表示成功、积极的图标
  static const Color color_ff11B17C = Color(0xff11B17C);

  /// 表示警示的图标
  static const Color color_ffFFB42C = Color(0xffFFB42C);

  /// 表示危险、失败的图标
  static const Color color_ffF56C6C = Color(0xffF56C6C);

  /// *************************背景色*******************************///
  /// 白色通用背景色
  static const Color color_FFFFFFFF = Color(0xffffffff);

  /// 白色通用背景色
  static const Color color_ffF6F6F6 = Color(0xffF6F6F6);

  /// 模态框背景色
  static const Color color_ff000000 = Color.fromRGBO(0, 0, 0, 0.5);

  /// 表示成功、积极的通告栏背景色
  static const Color color_ffE7F7F2 = Color(0xffE7F7F2);

  /// 表示信息类提示的通告栏背景色
  static const Color color_ffEAF3FE = Color(0xffEAF3FE);

  /// 表示警示的通告栏背景色
  static const Color color_ffFFF7EA = Color(0xffFFF7EA);

  /// 表示危险、失败的通告栏背景色
  static const Color color_ffFEF0F0 = Color(0xffFEF0F0);
  static const Color color_ff221E43 = Color(0xff221E43); //dark

  /// *************************文本色*******************************///
  /// 正文文字
  static const Color color_FF252525 = Color(0xff252525);

  /// 次重要文字
  static const Color color_FF666666 = Color(0xff666666);

  /// 提示文字
  static const Color color_ff8C8C8C = Color(0xff8C8C8C);

  /// 辅助文字
  static const Color color_ffC6C6C6 = Color(0xffC6C6C6);

  /// 深色背景上的文字
  static const Color color_FFF = Color(0xffffffff);

  /// 深色背景上的文字
  static const Color color_FFFALPH5 = Color.fromRGBO(255, 255, 255, 0.9);

  /// 警示文字
  static const Color color_ffEE0A24 = Color(0xffEE0A24);

  /// *************************按钮色*******************************///
  /// 主要按钮_默认态
  static const Color color_ff0058FF = Color(0xff0058FF);

  /// 主要按钮_按下态
  static const Color color_ff004FE5 = Color(0xff004FE5);

  /// 主要按钮_不可点击
  static const Color color_ffB5CBF6 = Color(0xffB5CBF6);

  /// 辅助按钮_默认态
  static const Color color_ffF5F8FA = Color(0xffF5F8FA);

  /// 辅助按钮_按下态
  static const Color color_ffE8EBED = Color(0xffE8EBED);

  /// 辅助按钮_不可点击
  static const Color color_fff5F8FA = Color(0xffF5F8FA);

  /// *************************其他色*******************************///
  /// 分割线
  static const Color color_FFEAEAEA = Color(0xffEAEAEA);

  /// 分割线
  static const Color color_FFF1F1F1 = Color(0xffF1F1F1);

  /// 进度条
  static const Color color_FFF5F8FA = Color(0xffF5F8FA);

  /// 图表
  static const Color color_FFFF6700 = Color(0xffFF6700);

  /// ecc88d
  static const Color color_FFECC88D = Color(0xffecc88d);

  /// 通行证手机或邮箱验证状态背景颜色
  static const Color color_FFCAE6DF = Color(0xffcae6df);
  static const Color color_FFFFD7D7 = Color(0xffffd7d7);
}

extension ShortCut on FNColors {}
