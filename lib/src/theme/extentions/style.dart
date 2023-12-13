import 'package:flutter/material.dart';

import '../export.dart';

/*
* @description:     复合样式配置
* param:
* @return:
* @author:          novice.cai
* @time:            2023/12/11 16:58
*/
class FNAccentCommonStyle<T> {
  final String primary;

  final Map<String, T> swatch;

  FNAccentCommonStyle(this.primary, this.swatch);

  FNAccentCommonStyle.swatch(this.swatch) : primary = 'normal';

  T get normal => swatch['normal']!;

  T get custom => swatch['custom'] ?? normal;
}

extension Automatically<T> on FNAccentCommonStyle {
  T get dy => FNThemeManager.instance.current == FNThemeType.fnThemeDefault
      ? normal
      : custom;
}
