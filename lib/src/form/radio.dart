import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

/*
 * @description: 单选项
 * @author: Yman Chen
 * @time: 2023/5/19 16:03
 */
class FNUIRadio extends StatefulWidget {
  final List<String> actions;

  ///初始化下标
  final int initialIndex;

  ///滑动方向
  final Axis scrollDirection;

  ///间隔大小
  final double space;

  ///按钮内边距
  final EdgeInsets? padding;

  ///圆角大小
  final double radius;

  ///选中与非选中的背景颜色
  final Color? selectedColor;
  final Color? unSelectedColor;

  ///选中与非选中文字的颜色
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;

  ///字体大小
  final double textSize;

  final Function(int) onChanged;

  const FNUIRadio({
    Key? key,
    required this.actions,
    this.initialIndex = 0,
    this.scrollDirection = Axis.horizontal,
    this.space = 8.0,
    this.padding,
    this.radius = 4.0,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.textSize = 14.0,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FNUIRadio> createState() => _FNUIRadioState();
}

class _FNUIRadioState extends State<FNUIRadio> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: widget.scrollDirection,
        itemCount: widget.actions.length,
        itemBuilder: (context, index) {
          return UnconstrainedBox(
            child: Padding(
              padding: widget.scrollDirection == Axis.horizontal
                  ? EdgeInsets.only(right: widget.space)
                  : EdgeInsets.only(bottom: widget.space),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_selectIndex != index) {
                    widget.onChanged.call(index);
                  }
                  setState(() {
                    _selectIndex = index;
                  });
                },
                child: Container(
                  padding: widget.padding ??
                      const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      color: _selectIndex == index
                          ? widget.selectedColor ?? FNColors.primary
                          : widget.unSelectedTextColor ??
                              FNColors.buttonAssPressedBackgroundColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(widget.radius))),
                  alignment: Alignment.center,
                  child: Text(
                    widget.actions[index],
                    style: TextStyle(
                        color: _selectIndex == index
                            ? widget.selectedTextColor ?? FNColors.card
                            : widget.unSelectedTextColor ?? FNColors.textColor,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
