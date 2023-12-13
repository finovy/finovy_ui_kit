import 'package:flutter/material.dart';

import 'config.dart';

/// 底部按钮的点击监听回调
typedef DialogIndexedActionClickCallback = bool Function(int index);

/// 点击事件
typedef DialogActionClickCallback = bool Function();

/// 底部按钮的高度
const double cBottomHeight = 44.0;

enum _ButtonType {
  /// 单按钮
  single,

  /// 多按钮
  multi,

  /// 左按钮
  left,

  /// 右按钮
  right,
}

/*
* @description:     弹窗组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/5/16 19:03
*/
class FNUIDialog extends AlertDialog {
  /// 标题控件
  final Widget? titleWidget;

  /// 内容控件
  final Widget? contentWidget;

  /// 警示文案部分的控件
  final Widget? warningWidget;

  /// 按钮部分控件
  final List<Widget>? actionsWidget;

  /// 标题文本
  final String? titleText;

  /// 内容文本
  final String? messageText;

  /// 警示文本
  final String? warningText;

  /// 底部按钮文案
  final List<String>? actionsText;

  /// 根据以上属性 生成对应的text控件

  /// 垂直分割线
  final VerticalDivider? verticalDivider;

  /// 水平分割线
  final Divider? divider;

  /// 底部按钮的点击监听回调
  final DialogIndexedActionClickCallback? indexedActionCallback;

  /// 是否展示头部icon
  final bool showIcon;

  /// 头部的icon
  final Image? iconImage;

  /// dialog配置
  final UIDialogConfig? themeData;

  /// 标题最大行数
  final int titleMaxLines;

  /// 圆角
  final double radius;

  ///是否禁用返回键
  final bool ignoreBackKey;

  const FNUIDialog({
    Key? key,
    this.showIcon = false,
    this.iconImage,
    this.titleText,
    this.messageText,
    this.titleWidget,
    this.contentWidget,
    this.warningText,
    this.warningWidget,
    this.actionsWidget,
    this.divider,
    this.verticalDivider,
    this.actionsText,
    this.indexedActionCallback,
    this.themeData,
    this.radius = 6.0,
    this.titleMaxLines = 3,
    this.ignoreBackKey = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIDialogConfig defaultConfig = themeData ?? const UIDialogConfig();
    final List<Widget> children = <Widget>[];

    if (_isShowIcon()) {
      Widget generateIconWidget = _generateIconWidget(context, defaultConfig);
      children.add(generateIconWidget);
    }

    if (_isShowTitle()) {
      Widget generateTitleWidget = _generateTitleWidget(context, defaultConfig);
      children.add(generateTitleWidget);
    }

    if (_isShowContent()) {
      Widget generateContentWidget =
          _generateContentWidget(context, defaultConfig);
      children.add(generateContentWidget);
    }

    if (_isShowWarning()) {
      Widget generateWarningWidget =
          _generateWarningWidget(context, defaultConfig);
      children.add(generateWarningWidget);
    }

    children.add(Padding(
      padding: defaultConfig.dividerPadding,
      child: const SizedBox.shrink(),
    ));

    if (!_isEmptyAction()) {
      children.add(divider ?? defaultConfig.cDividerLine);
      children.add(_generateActionsWidget(context, defaultConfig));
    }

    Widget dialogChild = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    return WillPopScope(
      onWillPop: () {
        return Future.value(!ignoreBackKey);
      },
      child: UnconstrainedBox(
          child: SizedBox(
              width: defaultConfig.dialogWidth,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius))),
                color: defaultConfig.backgroundColor,
                child: dialogChild,
              ))),
    );
  }

  Widget _generateIconWidget(
      BuildContext context, UIDialogConfig dialogConfig) {
    Widget createWidget(Widget widget) {
      return Center(
        child: Padding(
          padding: dialogConfig.iconPadding,
          child: SizedBox(
            width: 36,
            height: 36,
            child: widget,
          ),
        ),
      );
    }

    if (iconImage != null) {
      return createWidget(iconImage!);
    }
    return const SizedBox.shrink();
  }

  /// 标题widget：以titleWidget为准，辅以title生成的Text。
  Widget _generateTitleWidget(
      BuildContext context, UIDialogConfig dialogConfig) {
    if (titleWidget != null) {
      return DefaultTextStyle(
        textAlign: dialogConfig.titleTextAlign,
        style: dialogConfig.titleTextStyle,
        child: titleWidget!,
      );
    }

    return Padding(
      padding: _configTitlePadding(dialogConfig),
      child: Text(
        titleText!,
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
        style: dialogConfig.titleTextStyle,
        textAlign: dialogConfig.titleTextAlign,
      ),
    );
  }

  /// 内容widget：以contentWidget为准，辅以message生成的Text
  Widget _generateContentWidget(
      BuildContext context, UIDialogConfig dialogConfig) {
    if (contentWidget != null) {
      return Flexible(
        child: DefaultTextStyle(
          style: dialogConfig.contentTextStyle,
          child: contentWidget!,
        ),
      );
    }

    return Padding(
      padding: _configContentPadding(dialogConfig),
      child: Center(
        child: Text(
          messageText ?? "",
          style: dialogConfig.contentTextStyle,
          textAlign: dialogConfig.contentTextAlign,
        ),
      ),
    );
  }

  /// 警示widget：以warningWidget为准，辅以warning生成的Text
  Widget _generateWarningWidget(
      BuildContext context, UIDialogConfig dialogConfig) {
    if (warningWidget != null) {
      return Flexible(
        child: DefaultTextStyle(
          style: dialogConfig.warningTextStyle,
          child: warningWidget!,
        ),
      );
    }

    return Padding(
      padding: _configWarningPadding(dialogConfig),
      child: Text(
        warningText!,
        style: dialogConfig.warningTextStyle,
        textAlign: dialogConfig.warningTextAlign,
      ),
    );
  }

  /// 生成主按钮
  /// 单个button 左右有圆角
  /// 两个button 左button有左圆角&右直角 右button有右圆角&左直角
  /// 多个button 最后一个左右圆角  其他均直角
  Widget _generateMainWidget(Widget widget, Color background, _ButtonType type,
      int index, UIDialogConfig dialogConfig) {
    return Container(
      decoration: ShapeDecoration(
          color: background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(type == _ButtonType.single ||
                          type == _ButtonType.left ||
                          (type == _ButtonType.multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? radius
                      : 0),
                  bottomRight: Radius.circular(type == _ButtonType.single ||
                          type == _ButtonType.right ||
                          (type == _ButtonType.multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? radius
                      : 0)))),
      constraints: const BoxConstraints.tightFor(height: cBottomHeight),
      child: DefaultTextStyle(
        style: dialogConfig.mainActionTextStyle,
        child: Center(
          child: widget,
        ),
      ),
    );
  }

  /// 根据参数生成 灰色调的按钮
  /// 单个button 左右有圆角
  /// 两个button 左button有左圆角&右直角 右button有右圆角&左直角
  /// 多个button 最后一个左右圆角  其他均直角
  Widget _generateGreyWidget(Widget widget, Color background, _ButtonType type,
      int index, UIDialogConfig dialogConfig) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: cBottomHeight),
      decoration: ShapeDecoration(
          color: background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(type == _ButtonType.single ||
                          type == _ButtonType.left ||
                          (type == _ButtonType.multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? radius
                      : 0),
                  bottomRight: Radius.circular(type == _ButtonType.single ||
                          type == _ButtonType.right ||
                          (type == _ButtonType.multi &&
                              actionsText != null &&
                              index == actionsText!.length - 1)
                      ? radius
                      : 0)))),
      child: DefaultTextStyle(
        style: dialogConfig.assistActionsTextStyle,
        child: Center(
          child: widget,
        ),
      ),
    );
  }

  Widget _generateActionsWidget(
      BuildContext context, UIDialogConfig defaultConfig) {
    bool showTextActions = _isEmptyActionsWidget();
    int length = showTextActions ? actionsText!.length : actionsWidget!.length;
    if (length == 1) {
      return showTextActions
          ? _mapTextToGesWidget(
              context,
              actionsText![0],
              0,
              true,
              defaultConfig,
              type: _ButtonType.single,
            )
          : actionsWidget![0];
    } else if (length == 2) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: showTextActions
                ? _mapTextToGesWidget(
                    context, actionsText![0], 0, false, defaultConfig,
                    type: _ButtonType.left)
                : actionsWidget![0],
          ),
          SizedBox(
            height: defaultConfig.bottomHeight,
            child: verticalDivider ?? defaultConfig.cVerticalDivider,
          ),
          Expanded(
            child: showTextActions
                ? _mapTextToGesWidget(
                    context, actionsText![1], 1, true, defaultConfig,
                    type: _ButtonType.right)
                : actionsWidget![1],
          )
        ],
      );
    } else {
      return SizedBox(
        height: 3 * (defaultConfig.bottomHeight + 1),
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            physics: length > 3 ? null : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return showTextActions
                  ? _mapTextToGesWidget(
                      context, actionsText![i], i, true, defaultConfig,
                      type: _ButtonType.multi)
                  : actionsWidget![i];
            },
            separatorBuilder: (context, i) {
              return divider ?? defaultConfig.cDividerLine;
            },
            itemCount: length),
      );
    }
  }

  Widget _mapTextToGesWidget(BuildContext context, String label, int index,
      bool main, UIDialogConfig dialogConfig,
      {_ButtonType type = _ButtonType.single}) {
    Text text = Text(
      label,
      maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
    Widget ges = GestureDetector(
      child: main
          ? _generateMainWidget(text, dialogConfig.mainActionBackgroundColor,
              type, index, dialogConfig)
          : _generateGreyWidget(text, dialogConfig.assistActionsBackgroundColor,
              type, index, dialogConfig),
      onTap: () {
        //点击的监听
        bool result = indexedActionCallback?.call(index) ?? true;
        if (result) Navigator.pop(context);
      },
    );
    return ges;
  }

  bool _isEmptyAction() {
    return _isEmptyActionsText() && _isEmptyActionsWidget();
  }

  bool _isShowIcon() {
    return (showIcon || iconImage != null);
  }

  bool _isShowTitle() {
    return (titleText != null || titleWidget != null);
  }

  bool _isShowContent() {
    return contentWidget != null || messageText != null;
  }

  bool _isShowWarning() {
    return warningWidget != null || warningText != null;
  }

  bool _isEmptyActionsText() {
    return actionsText == null || actionsText!.isEmpty;
  }

  bool _isEmptyActionsWidget() {
    return actionsWidget == null || actionsWidget!.isEmpty;
  }

  /// 主题配置的标题间距
  EdgeInsets _configTitlePadding(UIDialogConfig dialogConfig) {
    return _isShowIcon()
        ? dialogConfig.titlePaddingSm
        : dialogConfig.titlePaddingLg;
  }

  /// 主题配置的内容间距
  EdgeInsets _configContentPadding(UIDialogConfig dialogConfig) {
    return (_isShowIcon() || _isShowTitle())
        ? dialogConfig.contentPaddingSm
        : dialogConfig.contentPaddingLg;
  }

  /// 主题配置的警告间距
  EdgeInsets _configWarningPadding(UIDialogConfig dialogConfig) {
    return (_isShowIcon() || _isShowTitle() || _isShowContent())
        ? dialogConfig.warningPaddingSm
        : dialogConfig.warningPaddingLg;
  }
}

/// 是对话框显示的管理类。
/// 根据底部按钮的数量分为：单个按钮对话框、两个按钮对话框 和 不定按钮对话框
///
/// 通用属性：
/// showIcon 是否展示 头部Icon，会展示默认的 对号图片
/// iconWidget 头部icon的图片，如果设置了这个属性 即使showIcon为false也会展示 设置的图片
///
/// title 是展示的标题文案
/// titleWidget 展示的标题widget，如果设置了widget 则会以widget为准
///
/// message 中间的辅助信息文案
/// messageWidget 展示中间辅助信息的widget
///
/// warning 警示文案
/// warningWidget 展示警示文案的widget
///
/// dismiss 点击按钮后是否 消失弹窗
///
/// barrierDismissible 点击四周的黑色遮罩 是否关闭弹窗
///
/// titleMaxLines 标题的最大行数
///
class FNUIDialogManager {
  ///展示底部只有一个按钮的对话框 对话框的点击回调是onTap
  ///label 底部按钮的文案
  ///labelWidget  自定义底部按钮的显示
  static void showSingleButtonDialog(
    BuildContext context, {
    required String label,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    Widget? labelWidget,
    DialogActionClickCallback? onTap,
    bool barrierDismissible = true,
    int titleMaxLines = 3,
    UIDialogConfig? themeData,
    bool ignoreBackKey = false,
  }) {
    List<Widget> actionsWidget = [];

    if (labelWidget != null) {
      actionsWidget.add(labelWidget);
    }
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return FNUIDialog(
          iconImage: iconWidget,
          showIcon: showIcon,
          titleText: title,
          titleWidget: titleWidget,
          messageText: message,
          contentWidget: messageWidget,
          warningText: warning,
          warningWidget: warningWidget,
          actionsText: [label],
          actionsWidget: actionsWidget,
          titleMaxLines: titleMaxLines,
          themeData: themeData,
          ignoreBackKey: ignoreBackKey,
          indexedActionCallback: (index) {
            if (index == 0) {
              if (onTap != null) {
                return onTap();
              }
            }
            return true;
          },
        );
      },
    );
  }

  /// 展示底部有两个按钮的弹窗 左侧是cancel 右侧是confirm
  /// cancel 左侧显示的文案
  /// confirm 右侧显示的文案
  /// cancelWidget 自定义显示的左侧
  /// conformWidget 自定义显示的右侧
  static void showConfirmDialog(
    BuildContext context, {
    required String cancel,
    required String confirm,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    Widget? cancelWidget,
    Widget? conformWidget,
    DialogActionClickCallback? onCancel,
    DialogActionClickCallback? onConfirm,
    bool barrierDismissible = true,
    int titleMaxLines = 3,
    UIDialogConfig? themeData,
    bool ignoreBackKey = false,
  }) {
    List<Widget> actionsWidget = [];

    if (cancelWidget != null) {
      actionsWidget.add(cancelWidget);
    }
    if (conformWidget != null) {
      actionsWidget.add(conformWidget);
    }
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return FNUIDialog(
          iconImage: iconWidget,
          showIcon: showIcon,
          titleText: title,
          titleWidget: titleWidget,
          messageText: message,
          contentWidget: messageWidget,
          warningWidget: warningWidget,
          warningText: warning,
          themeData: themeData,
          titleMaxLines: titleMaxLines,
          actionsText: [cancel, confirm],
          actionsWidget: actionsWidget,
          ignoreBackKey: ignoreBackKey,
          indexedActionCallback: (index) {
            if (index == 0) {
              if (onCancel != null) {
                return onCancel();
              }
            }
            if (index == 1) {
              if (onConfirm != null) {
                return onConfirm();
              }
            }
            return true;
          },
        );
      },
    );
  }

  ///展示底部按钮为多个的dialog 如果设置的是文字按钮那么，每个按钮的点击通过indexedActionClickCallback处理
  ///如果底部按钮的数量小于等于2 ，会以横排展示，否则会议竖排展示
  ///如果数量超过了三个 会滑动展示
  static void showMoreButtonDialog(
    BuildContext context, {
    required List<String> actions,
    bool showIcon = false,
    Image? iconWidget,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? warning,
    Widget? warningWidget,
    List<Widget>? actionsWidget,
    bool barrierDismissible = true,
    int titleMaxLines = 3,
    UIDialogConfig? themeData,
    DialogIndexedActionClickCallback? indexedActionClickCallback,
    bool ignoreBackKey = false,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return FNUIDialog(
            iconImage: iconWidget,
            showIcon: showIcon,
            titleText: title,
            titleWidget: titleWidget,
            messageText: message,
            contentWidget: messageWidget,
            warningWidget: warningWidget,
            warningText: warning,
            actionsText: actions,
            actionsWidget: actionsWidget,
            themeData: themeData,
            titleMaxLines: titleMaxLines,
            indexedActionCallback: indexedActionClickCallback,
            ignoreBackKey: ignoreBackKey);
      },
    );
  }

  ///展示自定义弹框
  static void showCustomerDialog(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    Widget? contentWidget,
    List<String>? actions,
    List<Widget>? actionsWidget,
    int titleMaxLines = 3,
    bool barrierDismissible = true,
    DialogIndexedActionClickCallback? indexedActionClickCallback,
    bool ignoreBackKey = false,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return FNUIDialog(
          showIcon: false,
          titleText: title,
          titleWidget: titleWidget,
          contentWidget: contentWidget,
          actionsText: actions,
          actionsWidget: actionsWidget,
          themeData: const UIDialogConfig(
              titlePaddingLg: EdgeInsets.only(top: 21, bottom: 12),
              dividerPadding: EdgeInsets.only(top: 0)),
          titleMaxLines: titleMaxLines,
          indexedActionCallback: indexedActionClickCallback,
          ignoreBackKey: ignoreBackKey,
        );
      },
    );
  }
}
