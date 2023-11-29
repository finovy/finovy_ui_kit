import 'package:flutter/material.dart';

class FNColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray1 = Color(0xFFF7F8Fa);
  static const Color gray2 = Color(0xFFF2F3F5);
  static const Color gray3 = Color(0xFFEBEDF0);
  static const Color gray4 = Color(0xFFDCDEE0);
  static const Color gray5 = Color(0xFFC8C9CC);
  static const Color gray6 = Color(0xFF969799);
  static const Color gray7 = Color(0xFF646566);
  static const Color gray8 = Color(0xFF323233);
  static const Color red = Color(0xFFEE0A24);
  static const Color blue = Color(0xFF1989Fa);
  static const Color yellow = Color(0xffF56C6C);
  static const Color orange = Color(0xFFFF976A);
  static const Color orangeDark = Color(0xFFED6A0C);
  static const Color orangeLight = Color(0xFFFFFBE8);
  static const Color green = Color(0xFF07C160);
  static const Color clear = Colors.transparent;
  static const Color card = white;
  static Color shadow = const Color(0xFFc0c0c0);
  static const Color blank = Color.fromRGBO(85, 86, 89, 0.5);
  // Gradient Colors
  static const LinearGradient gradientRed = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xffff6034),
      Color(0xffee0a24),
    ],
  );
  static const LinearGradient gradientOrange = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xffffd01e),
      Color(0xffff8917),
    ],
  );

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

  //*************************基础组件颜色（来源配色面板）***************************************
  /// 主题色
  static const Color primary = Color(0xFF0058ff);

  /// 背景色集合
  /// //*********** 白色通用背景**************//
  /// 白色通用背景
  static const Color background = white;

  static const Color backgroundSecondary = Color(0xFFf6f6f6);

  /// 模态框背景
  static const Color backgroundModal = Color.fromRGBO(0, 0, 0, 0.5);

  /// 成功、积极通告栏背景
  static const Color backgroundSuccess = Color(0xFFE7F7F2);

  /// 信息类提示通告栏背景
  static const Color backgroundInfo = Color(0xFFeaf3fe);

  /// 警示的通告栏背景
  static const Color backgroundWarning = Color(0xFFFFF7EA);

  /// 危险、失败通告栏背景
  static const Color backgroundDanger = Color(0xFFfef0f0);

  //*********** 文本配色**************//
  ///文字色
  static const Color textColor = Color(0xFF252525);
  static const Color fontMain = textColor;

  ///正文文字主色
  static const Color textNormalColor = textColor;

  ///次重要文字
  static const Color textSecondaryColor = Color(0xFF666666);
  static const Color fontNormal = textSecondaryColor;

  ///提示文字
  static const Color textExplainColor = Color(0xFF8c8c8c);
  static const Color textTipColor = textExplainColor;
  static const Color fontTips = textExplainColor;

  ///辅助文字
  static const Color textAssistantColor = Color(0xFFc6c6c6);

  ///深色背景上的文字
  static const Color textInDeepBackgroundColor = white;

  ///深色背景上的文字(alpha 0.9)
  static const Color textInDeepBackgroundWithAlphaColor =
      Color.fromRGBO(255, 255, 255, 0.9);

  /// 警示文字
  static const Color textWarningColor = red;
  static const Color warningColor = textWarningColor;

  ///主题色文字
  static const Color textPrimaryColor = primary;

  /// 禁用文字色
  static const Color textDisabledColor = Color(0xFFc6c6c6);

  /// 样式
  static const TextStyle textPrimaryStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle textSecondaryStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const TextStyle textLinkStyle = textSecondaryStyle;

  /// 顶部导航栏文字样式
  static TextStyle textAppbarStyle =
      textPrimaryStyle.copyWith(color: textColor);
  //*********** 按钮配色**************//

  /// [普通]按钮按下时背景色
  static const Color buttonPressedBackgroundColor = Color(0xFF004fe5);

  /// [普通]按钮禁用时背景色
  static const Color buttonDisabledBackgroundColor = Color(0xFFb5cbf6);

  /// [辅助按钮]按钮常态时背景色
  static const Color buttonAssDefaultBackgroundColor = Color(0xFFf5f8fa);

  /// [辅助按钮]按钮按下时背景色
  static const Color buttonAssPressedBackgroundColor = Color(0xFFe8ebed);

  /// [辅助按钮]按钮禁用时背景色
  static const Color buttonAssDisabledBackgroundColor =
      buttonAssDefaultBackgroundColor;

  //*********** 图标配色**************//
  /// 白色背景上的图标
  static const Color iconInLight001 = Color(0xff252525);

  /// 白色背景上的图标
  static const Color iconInLight002 = Color(0xff666666);

  /// 白色背景上的图标
  static const Color iconInLight003 = Color(0xff8c8c8c);

  /// 白色背景上的图标
  static const Color iconInLight004 = Color(0xffc6c6c6);

  /// 白色背景上的图标
  static const Color iconInLight005 = Color(0xffdddddd);

  /// 深色背景上的图标
  static const Color iconInDark001 = Color(0xffffffff);

  /// 表示信息提示的图标
  static const Color iconInfo = Color(0xff2F86F6);

  /// 表示成功、积极的图标
  static const Color iconSuccess = Color(0xff11B17C);

  /// 表示警示的图标
  static const Color iconWaining = Color(0xffFFB42C);

  /// 表示危险、失败的图标
  static const Color iconDanger = Color(0xffF56C6C);

  //*********** 其他配色**************//
  /// 分割线
  static const Color splitLineColor = Color(0xffEAEAEA);
  static const Color lineColor = splitLineColor;
  static const Color line = splitLineColor;

  /// 滚动条
  static const Color scrollerThumbColor = Color(0xffF1F1F1);

  /// 进度条
  static const Color progressColor = Color(0xffF5F8FA);

  /// 图表
  static const Color chartColor = Color(0xffFF6700);

  static const Color activeColor = gray2;
  static const double activeOpacity = 0.7;
  static const double disabledOpacity = 0.5;
  static const Color backgroundColor = gray1;
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color textLinkColor = Color(0xFF576b95);

  // Padding
  static const double paddingBase = 4.0;
  static const double paddingXs = paddingBase * 2;
  static const double paddingSm = paddingBase * 3;
  static const double paddingMd = paddingBase * 4;
  static const double paddingLg = paddingBase * 6;
  static const double paddingXl = paddingBase * 8;

  // Font
  static const double fontSizeXs = 10.0;
  static const double fontSizeSm = 12.0;
  static const double fontSizeMd = 14.0;
  static const double fontSizeLg = 16.0;
  static const double fontSizeNm = 16.0;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const double lineHeightXs = 14.0;
  static const double lineHeightSm = 18.0;
  static const double lineHeightMd = 20.0;
  static const double lineHeightLg = 22.0;
  static const String baseFontFamily =
      "-apple-system, BlinkMacSystemFont, 'Helvetica Neue',Helvetica, Segoe UI, Arial, Roboto, 'PingFang SC', 'miui', 'Hiragino Sans GB','Microsoft Yahei', sans-serif";
  static const String priceIntegerFontFamily =
      'Avenir-Heavy, PingFang SC, Helvetica Neue, Arial,sans-serif';
  static const TextHeightBehavior textHeightBehavior =
      TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even);
  // Animation
  static const Duration animationDurationBase = Duration(milliseconds: 300);
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Curve animationTimingFunctionEnter = Curves.easeOut;
  static const Curve animationTimingFunctionLeave = Curves.easeIn;

  // Border
  static const Color borderColor = gray3;
  static const double borderWidthBase = 1.0;
  static const double borderRadiusSm = 2.0;
  static const double borderRadiusMd = 4.0;
  static const double borderRadiusLg = 8.0;
  static const double borderRadiusMax = 999.0;

  // 快捷访问（兼容旧的访问方式，后续废弃）
  static const Color mainColor = primary;
  static const Color mainRed = red;
  static const Color mainGreen = green;
  static const Color mainBlue = blue;
  static const Color mainYellow = yellow;

  // // Button
  static const double btnDefaultHeight = 44.0;
  static const double btnDefaultFontSize = 16.0;
  static const double btnIconDefaultSize = 16.0;
  static const double btnIconLoadingRadius = 9.0;

  /// button primary (主要按钮)
  static const Color btnPrimaryTextColor = white;
  static const Color btnPrimaryBackgroundColor = primary;
  static const Color btnPrimaryDisabledTextColor = white;
  static const Color btnPrimaryLoadingTextColor = white;
  static const Color btnPrimaryDisabledBackgroundColor =
      buttonDisabledBackgroundColor;
  static const Color btnPrimaryPressedBackgroundColor =
      buttonPressedBackgroundColor;
  static const double btnPrimaryBorderRadius = 4.0;
  static const Color btnPrimaryBorderColor = clear;
  static const double btnPrimaryBorderWidth = 0.0;

  /// button secondary（次要按钮）
  static const Color btnSecondaryTextColor = primary;
  static const Color btnSecondaryBackgroundColor =
      buttonAssDefaultBackgroundColor;
  static const Color btnSecondaryDisabledTextColor = textDisabledColor;
  static const Color btnSecondaryLoadingTextColor = textDisabledColor;
  static const Color btnSecondaryDisabledBackgroundColor =
      buttonAssDisabledBackgroundColor;
  static const Color btnSecondaryPressedTextColor = white;
  static const Color btnSecondaryPressedBackgroundColor = primary;

  static const double btnSecondaryBorderRadius = 4.0;
  static const Color btnSecondaryBorderColor = clear;
  static const double btnSecondaryBorderWidth = 0.0;

  /// button hollowed（线框按钮）
  static const Color btnHollowedTextColor = primary;
  static const Color btnHollowedBackgroundColor = white;
  static const Color btnHollowedDisabledTextColor =
      buttonDisabledBackgroundColor;
  static const Color btnHollowedLoadingTextColor = Color(0xFFb5cbf6);
  static const Color btnHollowedDisabledBackgroundColor =
      textInDeepBackgroundWithAlphaColor;
  static const double btnHollowedBorderRadius = 4.0;
  static const Color btnHollowedBorderColor = primary;
  static const double btnHollowedBorderWidth = 1.0;

  /// button text-link（文字按钮）
  static const Color btnLinkTextColor = primary;
  static const Color btnLinkBackgroundColor = clear;
  static const Color btnLinkDisabledTextColor = buttonDisabledBackgroundColor;
  static const Color btnLinkLoadingTextColor = buttonDisabledBackgroundColor;
  static const Color btnLinkDisabledBackgroundColor = clear;
  static const double btnLinkBorderRadius = 0.0;
  static const Color btnLinkBorderColor = clear;
  static const double btnLinkBorderWidth = 0.0;

  // GridItem
  static const EdgeInsets gridItemContentPadding =
      EdgeInsets.symmetric(vertical: paddingMd, horizontal: paddingXs);
  static const Color gridItemContentBackgroundColor = white;
  static const Color gridItemContentActiveColor = activeColor;
  static const double gridItemIconSize = 28.0;
  static const Color gridItemTextColor = gray7;
  static const double gridItemTextFontSize = fontSizeSm;

  // Tag
  static const EdgeInsets tagPadding =
      EdgeInsets.symmetric(vertical: 0, horizontal: paddingBase);
  static const Color tagTextColor = white;
  static const Color tagDangerTextColor = Color(0xFFf56c6c);
  static const Color tagWarningTextColor = tagDangerTextColor;
  static const Color tagPrimaryTextColor = white;
  static const Color tagSuccessTextColor = Color(0xFF11b17c);
  static const double tagFontSize = fontSizeSm;
  static const double tagBorderRadius = 2.0;
  static const double tagLineHeight = 16.0;
  static const EdgeInsets tagMediumPadding =
      EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0);
  static const EdgeInsets tagLargePadding =
      EdgeInsets.symmetric(vertical: paddingBase, horizontal: paddingXs);
  static const double tagLargeBorderRadius = borderRadiusMd;
  static const double tagLargeFontSize = fontSizeMd;
  static const double tagRoundBorderRadius = borderRadiusMax;
  static const Color tagDangerColor = Color(0xFFffd7d7);
  static const Color tagPrimaryColor = primary;
  static const Color tagSuccessColor = Color(0xFFcae6df);
  static const Color tagWarningColor = tagDangerColor;
  static const Color tagDefaultColor = gray1;
  static const Color tagPlainBackgroundColor = white;

  /// Order
  static const Color orderStatusWait = iconWaining;
  static const Color orderStatusFailed = iconDanger;
  static const Color orderStatusSuccess = iconSuccess;

  /// RPQ
  static const Color scoreRadicalTextColor = Color(0xffecc88d);

//*************************不在色板里的颜色***************************************
  static const Color passwordCheckFailed = Color(0xFFee0a24);

  static const Color failStateBackgroundColor = Color(0xFFFFD6D6);
}
