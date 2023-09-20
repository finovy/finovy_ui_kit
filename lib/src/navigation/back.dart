import 'package:flutter/material.dart';
import '../../res/lib_res.dart';
import '../basic/export.dart';
import '../business/export.dart';
import '../constant/export.dart';

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
        color: iconColor ?? FNColors.fontMain,
        package: LibRes.PLUGIN_NAME,
      ),
    );
  }
}
