import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base.dart';
import 'theme_dark.dart';
import 'theme_light.dart';

enum FNThemeType {
  /// 浅色主题
  light,

  /// 深色主题
  dark
}

/*
 * 主题管理单例
 */
class FNThemeManager {
  static final FNThemeManager _singleton = FNThemeManager._();
  static FNThemeManager get instance => _singleton;
  FNThemeManager._();

  /// 当前主题
  FNThemeType theme = FNThemeType.light;

  IBaseTheme _baseTheme = ThemeLightData();
  IBaseTheme get themeData => _baseTheme;

  /*
   * @description   初始化主题状态栏颜色
   * @param
   * @return
   * @author        jay
   * @time          1/8/22 2:39 PM
   */
  void initSystemUiOverlayStyle() {
    //修改状态栏颜色
    SystemUiOverlayStyle style =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /*
  * @description:     切换主题
  * param: 
  * @return:          
  * @author:          novice.cai
  * @time:            2023/5/26 17:56
  */
  void changeTheme(FNThemeType type) {
    if (theme == type) return;
    theme = type;
    _baseTheme =
        theme == FNThemeType.light ? ThemeLightData() : ThemeDarkData();
  }
}
