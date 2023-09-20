import 'package:flutter/material.dart';

import '../constant/colors.dart';

class FNUIStyle {
  /*
   * 卡片风格
   */
  static final Decoration cardStyle = BoxDecoration(
    color: FNColors.card,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: FNColors.line, width: 0.5),
  );

  /*
   * 小卡片风格
   */
  static final Decoration smallCardStyle = BoxDecoration(
    color: FNColors.card,
    borderRadius: BorderRadius.circular(4),
    boxShadow: [
      BoxShadow(
          color: FNColors.shadow.withOpacity(0.5),
          offset: const Offset(0, 2),
          blurRadius: 6)
    ],
  );

  /*
   * 小卡片风格
   */
  static final Decoration contentCardStyle = BoxDecoration(
    color: FNColors.background.withAlpha(500),
    borderRadius: BorderRadius.circular(2),
  );

  static final Decoration panelStyle = BoxDecoration(
    color: FNColors.card,
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
  );

  /*
   * 基础阴影
   */
  static final BoxShadow baseShadow = BoxShadow(
    offset: const Offset(1, 3),
    color: Colors.black.withAlpha(30),
    blurRadius: 5,
    spreadRadius: 5,
  );

  /*
   *  订单头部渐变色
   */
  static final BoxDecoration orderNormalHeader = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [FNColors.hexColor(0x2c4893), FNColors.hexColor(0x142351)],
    ),
    borderRadius: BorderRadius.circular(8.0),
  );
}
