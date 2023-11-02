import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNStep extends StatefulWidget {
  const FNStep({
    Key? key,
    this.child,
    this.activeIconSlot,
    this.inactiveIconSlot,
    this.finishIconSlot,
  }) : super(key: key);

  // ****************** Props ******************

  // ****************** Events ******************

  // ****************** Slots ******************
  /// 内容
  final Widget? child;

  // 自定义激活状态图标
  final Widget? activeIconSlot;

  /// 自定义未激活状态图标
  final Widget? inactiveIconSlot;

  /// 自定义已完成步骤对应的底部图标，优先级高于 `inactiveIcon`
  final Widget? finishIconSlot;

  @override
  _FNStepState createState() => _FNStepState();
}

class _FNStepState extends State<FNStep> {
  @override
  Widget build(BuildContext context) {
    final bool isRow = parentProps.direction == Axis.horizontal;
    FNStepThemeData contextThemeData = FNStepTheme.of(context);
    return DefaultTextStyle(
      style: TextStyle(
        color: contextThemeData.stepTextColor,
        fontSize: contextThemeData.stepFontSize,
      ),
      child: isRow ? buildRow() : buildColumn(),
    );
  }

  Widget buildColumn() {
    FNStepThemeData contextThemeData = FNStepTheme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: isLast ? BorderSide.none : const FNHairLine(),
            ),
          ),
          // alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          child: DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              color: titleStyle ??
                  (isFinished
                      ? contextThemeData.stepFinishTextColor
                      : isActive
                          ? contextThemeData.stepActiveColor
                          : contextThemeData.stepTextColor),
            ),
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 0.0,
          left: -15.0,
          bottom: 0.0,
          child: Transform.translate(
            offset: const Offset(0.0, 16.0),
            child: Container(
              width: isLast ? 0.0 : 0.5,
              color: lineStyle ??
                  (isFinished
                      ? contextThemeData.stepFinishLineColor
                      : contextThemeData.stepLineColor),
            ),
          ),
        ),
        Positioned(
          top: 19.0,
          left: -15.0,
          child: FractionalTranslation(
            translation: const Offset(-0.5, -0.5),
            child: buildCircle(),
          ),
        ),
      ],
    );
  }

  Widget buildRow() {
    FNStepThemeData contextThemeData = FNStepTheme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        FractionalTranslation(
          translation: Offset(isFirst || isLast ? 0.0 : -0.5, 0.0),
          child: DefaultTextStyle(
            style: TextStyle(
              color: titleStyle ??
                  (isFinished
                      ? contextThemeData.stepFinishTextColor
                      : isActive
                          ? contextThemeData.stepActiveColor
                          : contextThemeData.stepTextColor),
            ),
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ),
        Positioned(
          top: 30.0,
          left: 0.0,
          right: 0.0,
          child: Divider(
            height: isLast ? 0.0 : 1.0,
            color: lineStyle ??
                (isFinished
                    ? contextThemeData.stepFinishLineColor
                    : contextThemeData.stepLineColor),
          ),
        ),
        Positioned(
          top: 30.0,
          right: isLast ? -FNColors.paddingXs : null,
          left: isLast ? null : -FNColors.paddingXs,
          child: Transform.translate(
            offset: Offset(isFirst || isLast ? 0.0 : -4.0, 0.0),
            child: FractionalTranslation(
              translation: const Offset(0.0, -0.5),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: FNColors.paddingXs,
                ),
                child: buildCircle(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCircle() {
    FNStepThemeData contextThemeData = FNStepTheme.of(context);
    if (isActive) {
      if (widget.activeIconSlot != null) {
        return widget.activeIconSlot!;
      }

      final IconData? defaultIcon = parentProps.activeIconName == null &&
              parentProps.activeIconUrl == null
          ? const IconData(0xF02F)
          : null;

      return FNUIIcon(
        iconName: parentProps.activeIconName ?? defaultIcon,
        iconUrl: parentProps.activeIconUrl,
        color: parentProps.activeColor ?? contextThemeData.stepActiveColor,
        size: contextThemeData.stepIconSize,
      );
    }

    if (getStatus == _FNStepStatus.finish &&
        (parentProps.finishIconName != null ||
            parentProps.finishIconUrl != null ||
            widget.finishIconSlot != null)) {
      if (widget.finishIconSlot != null) {
        return widget.finishIconSlot!;
      }

      return FNUIIcon(
        iconName: parentProps.finishIconName,
        iconUrl: parentProps.finishIconUrl,
        size: contextThemeData.stepIconSize,
        color: parentProps.activeColor ?? contextThemeData.stepActiveColor,
      );
    }

    if (widget.inactiveIconSlot != null) {
      return IconTheme(
        data: IconThemeData(
          color: isFinished
              ? contextThemeData.stepFinishTextColor
              : contextThemeData.stepCircleColor,
        ),
        child: widget.inactiveIconSlot!,
      );
    }

    if (parentProps.inactiveIconName != null ||
        parentProps.inactiveIconUrl != null) {
      return FNUIIcon(
        iconName: parentProps.inactiveIconName,
        iconUrl: parentProps.inactiveIconUrl,
        color: isFinished
            ? contextThemeData.stepFinishTextColor
            : contextThemeData.stepCircleColor,
        size: contextThemeData.stepIconSize,
      );
    }

    return Container(
      width: contextThemeData.stepCircleSize,
      height: contextThemeData.stepCircleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lineStyle ??
            (isFinished
                ? contextThemeData.stepFinishLineColor
                : contextThemeData.stepCircleColor),
      ),
    );
  }

  FNUISteps get parent {
    final FNUISteps? p = FNStepsScope.of(context)?.parent;
    if (p == null) {
      throw 'Step must be a child component of Steps';
    }
    return p;
  }

  List<Widget> get children => parent.children;
  int get index => children.indexOf(widget);
  bool get isFirst => index == 0;
  bool get isLast => index == children.length - 1;
  FNUISteps get parentProps => parent;

  _FNStepStatus get getStatus {
    if (index < parentProps.active) {
      return _FNStepStatus.finish;
    }
    return index == parentProps.active
        ? _FNStepStatus.process
        : _FNStepStatus.waiting;
  }

  bool get isActive => getStatus == _FNStepStatus.process;

  bool get isFinished => getStatus == _FNStepStatus.finish;

  Color? get lineStyle =>
      isFinished ? parentProps.activeColor : parentProps.inactiveColor;

  Color? get titleStyle =>
      isActive ? parentProps.activeColor : parentProps.inactiveColor;

  void onClickStep() => parent.onClickSubStep(index);
}

enum _FNStepStatus {
  finish,
  process,
  waiting,
}

/// 1px 边框
class FNHairLine extends BorderSide {
  const FNHairLine({
    Color color = FNColors.borderColor,
  }) : super(color: color, width: 0.5);
}
