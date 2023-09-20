import 'package:flutter/material.dart';

/*
* @description:     上下文管理（弹出框类先调用此处）
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/11 15:02
*/
class FNDesignContext {
  static late BuildContext _buildContext;
  static BuildContext get buildContext => _buildContext;

  /*
  * @description:     直接指定上下文（不推荐，除非有明确的overlay）
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/7/31 11:05
  */
  static void initFNUIKitContext({required BuildContext context}) {
    _buildContext = context;
  }

  /*
  * @description:     构建上下文（推荐）
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/7/31 11:05
  */
  static Widget fnUIKitContextBuilder(
      {required BuildContext context, required Widget child}) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          child, // 实际界面布局
          Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  _buildContext = context;
                  return const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
