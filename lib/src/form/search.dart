import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

class FNUISearch extends StatefulWidget {
  /// 提示文字
  final String? hintLabel;

  ///占位文字style
  final TextStyle? hintStyle;

  ///展示文字style
  final TextStyle? style;

  /// 是否自动焦点
  final bool autoFocus;

  /// 是否显示搜索图标
  final bool isShowSearchIcon;

  /// 回调
  final Function? onInputTextChangeCallback;

  /// 点击了提交的回调
  final Function? onSubmit;

  /// 监听输入焦点
  final Function? onFocusCallback;

  /// 清空回调
  final Function? onClearCallback;

  ///装饰
  final BoxDecoration? decoration;

  ///取消文本
  final String? cancelText;

  ///输入框高度
  final double? inputHeight;

  ///取消事件
  final Function? onCancelCallback;

  final Widget? searchWidget;

  final TextAlign? textAlign;

  final Widget? clearWidget;

  /// 获取文本控制器和焦点
  final Function(TextEditingController? textContrl, FocusNode? focusNode)?
      onInitTextCallBack;

  const FNUISearch(
      {Key? key,
      this.hintLabel = '搜索感兴趣的内容',
      this.hintStyle,
      this.style,
      this.autoFocus = true,
      this.isShowSearchIcon = false,
      this.onInputTextChangeCallback,
      this.onSubmit,
      this.onClearCallback,
      this.onInitTextCallBack,
      this.onFocusCallback,
      this.decoration,
      this.cancelText = '取消',
      this.onCancelCallback,
      this.searchWidget,
      this.textAlign,
      this.inputHeight,
      this.clearWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommonSearchNavBarState();
  }
}

class CommonSearchNavBarState extends State<FNUISearch> {
  late FocusNode _focusNode;

  ///监听TextField内容变化
  final TextEditingController _defaultTextEditController =
      TextEditingController();

  ///默认不展示控件
  bool _offstage = true;

  get defaultDecoration => BoxDecoration(
      color: FNColors.hexColor(0xF5F5F5),
      borderRadius: BorderRadius.circular(14));

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _defaultTextEditController.addListener(() {
      if (widget.onInputTextChangeCallback != null) {
        widget.onInputTextChangeCallback!(_defaultTextEditController.text);
      }
      var isVisible = _defaultTextEditController.text.isNotEmpty;
      _updateDelIconVisible(isVisible);
    });

    if (widget.onInitTextCallBack != null) {
      widget.onInitTextCallBack!(_defaultTextEditController, _focusNode);
    }
    if (widget.onFocusCallback != null) {
      _focusNode
          .addListener(() => widget.onFocusCallback!(_focusNode.hasFocus));
    }
  }

  _updateDelIconVisible(bool isVisible) {
    setState(() {
      _offstage = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            height: widget.inputHeight ?? 32,
            margin: const EdgeInsets.only(left: 16),
            decoration: widget.decoration ?? defaultDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: widget.textAlign ?? TextAlign.center,
                    controller: _defaultTextEditController,
                    autofocus: widget.autoFocus,
                    focusNode: _focusNode,
                    cursorColor: FNColors.hexColor(0x6385ff),
                    decoration: InputDecoration(
                      icon: widget.isShowSearchIcon
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 8),
                              child: widget.searchWidget ??
                                  const Icon(
                                    Icons.search,
                                    color: FNColors.textTipColor,
                                  ),
                            )
                          : null,
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: widget.isShowSearchIcon ? -10 : 10),
                      hintText: widget.hintLabel,
                      hintStyle: widget.hintStyle ??
                          const TextStyle(
                            fontSize: FNFontSize12,
                            color: Colors.black38,
                          ),
                    ),
                    style: widget.style ??
                        const TextStyle(
                          fontSize: FNFontSize14,
                        ),
                    maxLines: 1,
                    onSubmitted: (text) {
                      if (widget.onSubmit != null) widget.onSubmit!(text);
                    },
                  ),
                ),
                Offstage(
                  offstage: _offstage,
                  child: GestureDetector(
                    onTap: () {
                      _defaultTextEditController.clear();
                      if (widget.onClearCallback != null) {
                        widget.onClearCallback!();
                      }
                    },
                    child: widget.clearWidget ??
                        FNUIImage(
                          FNImagePath.png('icon_common_del'),
                        ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 16))
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _focusNode.unfocus();
            widget.onCancelCallback?.call();
            // Get.back();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Text(widget.cancelText ?? '',
                style: const TextStyle(
                    fontSize: FNFontSize16,
                    color: FNColors.textColor,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.unfocus();
  }
}
