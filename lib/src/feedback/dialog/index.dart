import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';
import '../../third_lib/animations/modal.dart';

class FNDialog {
  /*
   * @description:    显示确认框
   * @param:
   * @return:
   * @author:         jay xie
   * @time:           3/6/22 8:45 PM
   */
  static Future<dynamic> showConfirmDialog({
    required BuildContext context,
    bool? dismissible,
    double? dialogWidth,
    bool showClose = false,
    String? title,
    String? content,
    Widget? contentWidget, //支持传入内容widget
    String? cancel,
    String? confirm,
    Color? confirmColor,
    bool? forbid,
    required Function(int index) onCallBack,
  }) async {
    List<String> actions = [];
    if (cancel != null) {
      actions.add(cancel);
    }
    if (confirm != null) {
      actions.add(confirm);
    }

    Widget dialog = WillPopScope(
      onWillPop: () async {
        return forbid ?? true;
      },
      child: Material(
        color: FNColors.clear,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: FNColors.card,
            width: dialogWidth ?? 260,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showClose
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              onCallBack(0);
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: FNColors.hexColor(0x262b2e),
                              size: 21,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(height: 20),
                if (title != null && title.isNotEmpty)
                  FNUIText(
                    text: title,
                    color: FNColors.hexColor(0x212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                const SizedBox(height: 20),
                contentWidget ??
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: FNUIText(
                        text: content ?? '',
                        color: FNColors.hexColor(0x474747),
                        fontSize: 14,
                      ),
                    ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: FNColors.hexColor(0xcccccc),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: actions.map((action) {
                    int index = actions.indexOf(action);
                    return Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onCallBack(index);
                        },
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: FNColors.hexColor(0xcccccc),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Text(
                            action,
                            style: TextStyle(
                              color: index == 0
                                  ? FNColors.hexColor(0x999999)
                                  : confirmColor ?? FNColors.primary,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return FNDialog.show(
      context: context,
      dismissible: dismissible,
      child: dialog,
    );
  }

  /*
   * @description:    显示弹框(基础)
   * @param:
   * @return:
   * @author:         jay xie
   * @time:           3/6/22 8:31 PM
   */
  static Future<dynamic> show({
    required BuildContext context,
    Alignment? alignment,
    required Widget child,
    bool? dismissible,
  }) async {
    return showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(
            transitionDuration: const Duration(milliseconds: 250),
            reverseTransitionDuration: const Duration(milliseconds: 250),
            barrierDismissible: dismissible ?? true),
        useRootNavigator: false,
        builder: (BuildContext context) {
          return Align(
            alignment: alignment ?? Alignment.center,
            child: child,
          );
        });
  }
}
