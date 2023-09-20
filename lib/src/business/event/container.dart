import 'package:flutter/cupertino.dart';

/*
* @description:     事件容器
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/31 15:14
*/
class FNUIEventContainer extends Container {
  final Function onTap;
  FNUIEventContainer({
    super.key,
    super.color,
    super.margin,
    super.padding,
    super.decoration,
    super.constraints,
    super.transform,
    super.alignment,
    super.width,
    super.height,
    super.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => onTap.call(),
      child: super.child,
    );
  }
}
