import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

import '../../res/lib_res.dart';

const String defaultIconPath = 'icon_common_back.png';

/*
* @description:     Appbar左侧组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/8/3 12:03
*/
class FNUINavBack extends StatelessWidget {
  final VoidCallback callBack;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Size? size;
  const FNUINavBack(
      {super.key,
      required this.callBack,
      this.iconColor,
      this.backgroundColor,
      this.padding,
      this.size});

  @override
  Widget build(BuildContext context) {
    return FNUIEventContainer(
      onTap: () => callBack.call(),
      color: backgroundColor ?? FNColors.card,
      padding: padding ?? const EdgeInsets.only(right: 16),
      child: FNUIImage(
        defaultIconPath,
        width: size?.width ?? 24,
        height: size?.height ?? 24,
        color: iconColor ?? FNColors.textColor,
        package: LibRes.PLUGIN_NAME,
      ),
    );
  }
}
