import 'package:flutter/material.dart';

/*
* @description:     主题配置抽象类
* param:
* @return:
* @author:          novice.cai
* @time:            2023/8/3 18:56
*/
abstract class IBaseTheme {
  ///主色配置
  ThemeMainConfig get mainConfig;

  ///图标颜色配置
  ThemeIconConfig get iconConfig;

  ///背景色配置
  ThemeBackgroundConfig get backgroundConfig;

  ///按钮色配置
  ThemeButtonConfig get buttonConfig;

  ///文本色配置
  ThemeTextConfig get textConfig;

  ///其他色配置
  ThemeOtherConfig get otherConfig;
}

/*
* @description:     主色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/25 10:16
*/
class ThemeMainConfig {
  /// 主题色
  final Color? mainColor;

  ///
  final Color? mainGreen;

  ///
  final Color? mainRed;

  ///
  final Color? card;

  ThemeMainConfig({
    this.mainColor,
    this.mainGreen,
    this.mainRed,
    this.card,
  });
}

/*
* @description:     图标颜色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/23 18:26
*/
class ThemeIconConfig {
  /// 按钮颜色
  final Color? iconColor;

  /// 信息提示颜色
  final Color? tipColor;

  /// 成功按钮颜色
  final Color? successColor;

  /// 提示警告颜色
  final Color? warningColor;

  /// 失败颜色
  final Color? errorColor;
  ThemeIconConfig(
      {this.iconColor,
      this.tipColor,
      this.successColor,
      this.warningColor,
      this.errorColor});
}

/*
* @description:     背景色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/23 18:35
*/
class ThemeBackgroundConfig {
  final Color? commonColor;
  final Color? dialogColor;
  final Color? successColor;
  final Color? tipsColor;
  final Color? warningColor;
  final Color? errorColor;
  ThemeBackgroundConfig(
      {this.commonColor,
      this.dialogColor,
      this.successColor,
      this.tipsColor,
      this.warningColor,
      this.errorColor});
}

/*
* @description:     按钮色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/23 18:43
*/
class ThemeButtonConfig {
  final Color? btn_primary_default;
  final Color? btn_primary_pressed;
  final Color? btn_primary_disable;
  final Color? btn_secondary_default;
  final Color? btn_secondary_pressed;
  final Color? btn_secondary_disable;
  ThemeButtonConfig({
    this.btn_primary_default,
    this.btn_primary_pressed,
    this.btn_primary_disable,
    this.btn_secondary_default,
    this.btn_secondary_pressed,
    this.btn_secondary_disable,
  });
}

/*
* @description:     文本色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/23 18:43
*/
class ThemeTextConfig {
  final Color? text_primary;
  final Color? text_secondary;
  final Color? text_explain;
  final Color? text_tip;
  final Color? text_in_deepBg;
  final Color? text_deep_alpha;
  final Color? successColor;
  final Color? warningColor;
  final Color? errorColor;

  ThemeTextConfig({
    this.text_primary,
    this.text_secondary,
    this.text_explain,
    this.text_tip,
    this.text_in_deepBg,
    this.text_deep_alpha,
    this.successColor,
    this.warningColor,
    this.errorColor,
  });
}

/*
* @description:     其他色配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/23 18:43
*/
class ThemeOtherConfig {
  /// 分割线颜色
  final Color? splitter_bg;

  /// 滚动条颜色
  final Color? scroller_thumb;

  ///进度条
  final Color? progress;

  ///图表色
  final Color? chart;

  ThemeOtherConfig({
    this.splitter_bg,
    this.scroller_thumb,
    this.progress,
    this.chart,
  });
}
