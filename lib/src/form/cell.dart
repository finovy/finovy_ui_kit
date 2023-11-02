import 'package:flutter/cupertino.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

import '../../res/lib_res.dart';

/*
 * @description: 单行列表项，（前缀图片）标题，内容，（后缀图片）箭头，
 * @author: Yman Chen
 * @time: 2023/6/2 9:57
 */
class FNUICell extends StatelessWidget {
  // final CellDataModel itemData;
  final String title; //标题
  final TextStyle? titleStyle; //标题文字样式
  final EdgeInsets? padding; //整体的内边距
  final VoidCallback? callBack; //点击回调
  final String? rightTitle; //右标题
  final TextStyle? rightTitleStyle; //标题文字样式
  final String? leadImg; //前图标
  final double? leadImgWidth; //图标宽度，默认32
  final double? leadImgHeight; //图标高度，默认32
  final double? space; //图标与标题的间距，默认12

  final Widget? suffix; //右标题后面widget
  final bool? showArrow; //是否展示箭头
  final double? arrowSize; //箭头大小，默认15
  final Color? arrowColor; //箭头颜色
  final Widget? rightArrow; // 自定义箭头
  final bool subtitleVis; //副标题是否显示
  final Widget? subtitle; //副标题Widget
  final bool showLine; //分割线
  final double? lineHeight; //分割线高度
  final Color? lineColor; //分割线颜色
  const FNUICell({
    Key? key,
    required this.title,
    this.callBack,
    this.titleStyle,
    this.padding,
    this.leadImg,
    this.leadImgWidth,
    this.leadImgHeight,
    this.space,
    this.rightTitle,
    this.rightTitleStyle,
    this.suffix,
    this.showArrow,
    this.arrowSize,
    this.arrowColor,
    this.rightArrow,
    this.subtitleVis = false,
    this.subtitle,
    this.showLine = false,
    this.lineHeight,
    this.lineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => callBack?.call(),
          child: Container(
            padding: padding ?? const EdgeInsets.all(18.0),
            color: FNColors.card,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (leadImg?.isNotEmpty == true)
                        Image.asset(
                          leadImg ?? '',
                          width: leadImgWidth ?? 24,
                          height: leadImgHeight ?? 24,
                        ),
                      FNUIText(
                        margin: EdgeInsets.only(left: space ?? 12),
                        text: title,
                        color: titleStyle?.color ?? FNColors.textColor,
                        fontSize: titleStyle?.fontSize ?? FNFontSize16,
                        fontWeight: titleStyle?.fontWeight ?? FontWeight.w500,
                        maxLines: 1,
                      ),
                      Visibility(
                          visible: subtitleVis, child: subtitle ?? Container())
                    ],
                  ),
                ),
                FNUIText(
                  text: rightTitle ?? '',
                  color: rightTitleStyle?.color ?? FNColors.textColor,
                  fontSize: rightTitleStyle?.fontSize ?? FNFontSize14,
                  fontWeight: rightTitleStyle?.fontWeight ?? FontWeight.normal,
                ),
                suffix ?? const SizedBox.shrink(),
                showArrow ?? false
                    ? (rightArrow ??
                        Image.asset(
                          'lib/assets/images/icon_arrow_forward.png',
                          width: arrowSize ?? 24,
                          height: arrowSize ?? 24,
                          color: arrowColor,
                          package: LibRes.PLUGIN_NAME,
                        ))
                    : Container(),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showLine,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: padding?.left ?? 18.0),
              color: lineColor ?? FNColors.splitLineColor,
              height: lineHeight ?? 0.5),
        )
      ],
    );
  }
}

/*
 * @description: 列表项--标题 + 开关
 * @author: Yman Chen
 * @time: 2023/6/2 9:52
 */
class FNUICellWithSwitch extends StatefulWidget {
  ///标题
  final String title;

  ///内边距，默认水平方向16
  final EdgeInsets? padding;

  ///标题大小
  final double? titleFontSize;

  ///标题磅值
  final FontWeight? titleFontWight;

  ///初始开关状态，true为打开，false为关闭
  final bool initValue;

  ///是否禁用
  final bool disable;

  ///切换回调
  final Function(bool)? onChange;

  const FNUICellWithSwitch({
    Key? key,
    required this.title,
    this.titleFontSize,
    this.titleFontWight,
    this.padding,
    this.disable = false,
    this.onChange,
    this.initValue = false,
  }) : super(key: key);

  @override
  State<FNUICellWithSwitch> createState() => _FNUICellWithSwitchState();
}

class _FNUICellWithSwitchState extends State<FNUICellWithSwitch> {
  bool _switchOn = false;

  @override
  void initState() {
    super.initState();
    _switchOn = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      color: FNColors.card,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FNUIText(
              text: widget.title,
              color: FNColors.textColor,
              fontSize: widget.titleFontSize ?? FNFontSize16,
              fontWeight: widget.titleFontWight ?? FontWeight.w600,
              maxLines: 1,
            ),
          ),
          IgnorePointer(
            ignoring: widget.disable,
            child: CupertinoSwitch(
                value: _switchOn,
                activeColor:
                    widget.disable ? const Color(0xFFB3CDFF) : FNColors.primary,
                trackColor: widget.disable
                    ? const Color(0xFFF5F5F6)
                    : const Color(0XffE9E9EB),
                onChanged: (value) {
                  setState(() {
                    _switchOn = value;
                  });

                  ///回调
                  widget.onChange?.call(value);
                }),
          ),
        ],
      ),
    );
  }
}

/*
 * @description: 双行列表
 * @author: Yman Chen
 * @time: 2023/6/2 10:01
 */
class FNUICellDoubleLine extends StatelessWidget {
  ///标题
  final String? title;
  final TextStyle? titleStyle;

  ///内容
  final String? content;
  final TextStyle? contentStyle;

  ///描述
  final String? desc;
  final TextStyle? descStyle;

  ///内边距
  final EdgeInsets? padding;

  final bool? showArrow; //是否展示箭头
  final double? arrowSize; //箭头大小，默认15
  final Color? arrowColor; //箭头颜色
  final Widget? rightArrow;

  const FNUICellDoubleLine(
      {Key? key,
      this.title,
      this.content,
      this.desc,
      this.titleStyle,
      this.contentStyle,
      this.descStyle,
      this.padding,
      this.showArrow,
      this.arrowSize,
      this.arrowColor,
      this.rightArrow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FNColors.card,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: titleStyle ??
                      const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: FNColors.textColor),
                  maxLines: content?.isNotEmpty == true ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
                content?.isNotEmpty == true
                    ? Text(
                        content ?? '',
                        style: contentStyle ??
                            const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                height: 1.67,
                                color: FNColors.textSecondaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Container(
            width: desc?.isNotEmpty == true
                ? (MediaQuery.of(context).size.width - 80) * 0.4
                : 0,
            padding: desc?.isNotEmpty == true
                ? const EdgeInsets.only(left: 16)
                : EdgeInsets.zero,
            child: Text(
              desc ?? '',
              style: descStyle ??
                  const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.57,
                      color: FNColors.textSecondaryColor),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          showArrow ?? false
              ? rightArrow ??
                  Image.asset(
                    'lib/assets/images/icon_arrow_forward.png',
                    width: arrowSize ?? 24,
                    height: arrowSize ?? 24,
                    color: arrowColor,
                    package: LibRes.PLUGIN_NAME,
                  )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
