import '../constant/colors.dart';
import 'base.dart';

/*
* @description:     浅色（默认）主题数据
* param: 
* @return:          
* @author:          novice.cai
* @time:            2023/5/29 11:00
*/
class ThemeLightData implements IBaseTheme {
  @override
  ThemeBackgroundConfig get backgroundConfig => ThemeBackgroundConfig(
      commonColor: FNColors.color_FFFFFFFF,
      dialogColor: FNColors.color_ff000000,
      successColor: FNColors.color_ffE7F7F2,
      tipsColor: FNColors.color_ffEAF3FE,
      warningColor: FNColors.color_ffFFF7EA,
      errorColor: FNColors.color_ffFEF0F0);

  @override
  ThemeButtonConfig get buttonConfig => ThemeButtonConfig(
        btn_primary_default: FNColors.color_ff0058FF,
        btn_primary_pressed: FNColors.color_ff004FE5,
        btn_primary_disable: FNColors.color_ffB5CBF6,
        btn_secondary_default: FNColors.color_ffF5F8FA,
        btn_secondary_pressed: FNColors.color_ffE8EBED,
        btn_secondary_disable: FNColors.color_fff5F8FA,
      );

  @override
  ThemeIconConfig get iconConfig => ThemeIconConfig(
      iconColor: FNColors.color_ff252525,
      tipColor: FNColors.color_ff2F86F6,
      successColor: FNColors.color_ff11B17C,
      warningColor: FNColors.color_ffFFB42C,
      errorColor: FNColors.color_ffF56C6C);

  @override
  ThemeMainConfig get mainConfig => ThemeMainConfig(
        mainColor: FNColors.color_ff0058ff,
        mainGreen: FNColors.color_ff11B17C,
        mainRed: FNColors.color_ffF56C6C,
        card: FNColors.color_ffFFFFFF,
      );

  @override
  ThemeOtherConfig get otherConfig => ThemeOtherConfig(
        splitter_bg: FNColors.color_FFEAEAEA,
        scroller_thumb: FNColors.color_FFF1F1F1,
        progress: FNColors.color_FFF5F8FA,
        chart: FNColors.color_FFFF6700,
      );

  @override
  ThemeTextConfig get textConfig => ThemeTextConfig(
        text_primary: FNColors.color_FF252525,
        text_secondary: FNColors.color_FF666666,
        text_explain: FNColors.color_ffC6C6C6,
        text_tip: FNColors.color_ff8C8C8C,
        text_in_deepBg: FNColors.color_FFF,
        warningColor: FNColors.color_ffEE0A24,
        errorColor: FNColors.color_FF252525,
        successColor: FNColors.color_FF252525,
      );
}
