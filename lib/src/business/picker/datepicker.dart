import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
* @description:     日期选择器
* param:
* @return:
* @author:          novice.cai
* @time:            2023/6/2 14:04
*/
class FNUIDatePicker {
  static const String yyyyMMdd = "yyyy-MM-dd";
  static const String yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss";
  static const String yyyy = "yyyy";
  static const String HHmmss = "HH:mm:ss";
  static const String hhmmpp = "hh:mm am";
  static const String HHmm = "HH:mm";

  /*
  * @description:     自定义显示时间
  * param:
  * @return:
  * @author:          novice.cai
  * @time:            2023/6/2 11:51
  */
  static show(
      {required BuildContext context,
      DateTime? initialDateTime,
      DateTime? minimumDate, //最大日期时间，只有mode为dateAndTime时有效
      DateTime? maximumDate, //最小日期时间，只有mode为dateAndTime时有效
      int? maximumYear, //最大年份，只有mode为date时有效
      int minimumYear = 1, //最小年份，只有mode为date时有效
      int minuteInterval = 1,
      CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
      DatePickerDateOrder dateOrder = DatePickerDateOrder.ymd,
      String format = FNUIDatePicker.yyyyMMdd,
      bool use24hFormat = true,
      double sheetHeight = 265.0,
      Color sheetBackgroundColor = Colors.white,
      Color? backgroundColor,
      ShapeBorder? shape,
      bool isScrollControlled = true,
      bool isDismissible = false,
      bool isShowToolBar = true,
      Color toolBarColor = Colors.white,
      double toolbarHeight = 35.0,
      String cancelLabel = "取消",
      String confirmLabel = "确定",
      Function(DateTime dateTime)? onDateTimeChanged,
      Function? onCancel,
      Function(DateTime dateTime)? onConfirm}) {
    DateTime currentTime = DateTime.now();
    showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        backgroundColor: sheetBackgroundColor,
        shape: shape,
        isDismissible: isDismissible,
        builder: (context) {
          return SizedBox(
            height: sheetHeight,
            child: Column(
              children: [
                Offstage(
                  offstage: !isShowToolBar,
                  child: Container(
                    height: toolbarHeight,
                    color: toolBarColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FNUIButton(
                          size: FNButtonSize.normal,
                          type: FNButtonType.normal,
                          border: false,
                          text: cancelLabel,
                          onTap: () {
                            Navigator.pop(context);
                            onCancel?.call();
                          },
                        ),
                        FNUIButton(
                          size: FNButtonSize.normal,
                          type: FNButtonType.normal,
                          border: false,
                          text: confirmLabel,
                          onTap: () {
                            Navigator.pop(context);
                            onConfirm?.call(currentTime);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: initialDateTime ?? DateTime.now(),
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    maximumYear: maximumYear,
                    minimumYear: minimumYear,
                    minuteInterval: minuteInterval,
                    mode: mode,
                    dateOrder: dateOrder,
                    use24hFormat: use24hFormat,
                    backgroundColor: backgroundColor,
                    onDateTimeChanged: (date) {
                      currentTime = date;
                      onDateTimeChanged?.call(date);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
