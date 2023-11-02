import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUISegment extends StatelessWidget {
  final EdgeInsets? margin;
  final double? width;
  final List<String> titles;
  final int currentIndex;
  final Function(int index) onChangeCallBack;
  const FNUISegment({
    Key? key,
    this.margin,
    this.width,
    required this.titles,
    required this.currentIndex,
    required this.onChangeCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: (width ?? 80) * titles.length + 4,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: FNColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: titles
            .asMap()
            .keys
            .map(
              (index) => GestureDetector(
                onTap: () => onChangeCallBack(index),
                child: Container(
                  alignment: Alignment.center,
                  width: width ?? 80,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? FNColors.card
                        : FNColors.background,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FNUIText(
                    text: titles[index],
                    color: currentIndex == index
                        ? FNColors.textColor
                        : FNColors.textSecondaryColor,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
