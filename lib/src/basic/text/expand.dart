import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 具备展开收起功能的文字面板
///
/// 布局规则：
///     在文本的右下角有更多或者收起按钮
///     当文本超过指定的[maxLines]时，剩余文本隐藏
///     点击更多，则显示全部文本
///
/// ```dart
///   SMExpandLabel(
///      text: '在文本的右下角有更多或者收起按钮',
///   )
///
///   SMExpandLabel(
///      text: '具备展开收起功能的文字面板，在文本的右下角有更多或者收起按钮',
///      maxLines: 2,
///      onExpanded: (value) {
///      },
///   )
///
/// ```
///
/// 相关文本组件如下:
///  * [SMUIText], 基础的文本组件
///
///

class FNExpandLabel extends StatefulWidget {
  /// 显示的文本
  final String text;

  /// 显示的最多行数
  final int maxLines;

  /// 文本的样式
  final TextStyle? textStyle;

  /// 展开或者收起的时候的回调
  final Function(bool)? onExpanded;

  /// 更多按钮渐变色的初始色 默认白色
  final Color? color;

  const FNExpandLabel({
    Key? key,
    required this.text,
    this.maxLines = 1000000,
    this.textStyle,
    this.onExpanded,
    this.color,
  }) : super(key: key);

  @override
  FNExpandLabelState createState() => FNExpandLabelState();
}

class FNExpandLabelState extends State<FNExpandLabel> {
  /// 是否展开
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    TextStyle style = _getDefaultTextStyle();
    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.text, style: style);
        final tp = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
          ellipsis: 'EllipseText',
        );
        tp.layout(maxWidth: size.maxWidth);
        if (tp.didExceedMaxLines) {
          if (_expanded) {
            return _getExpandedTextWidget(context, widget.text);
          } else {
            return _getFoldedTextWidget(context, widget.text);
          }
        } else {
          return _getRegularTextWidget(widget.text, style);
        }
      },
    );
  }

  /*
   * @description   获取折叠组件
   * @param
   * @return
   * @author        jay
   * @time          3/5/22 12:22 PM
   */
  Widget _getFoldedTextWidget(context, String text) {
    return Stack(
      children: [
        Text(
          widget.text,
          style: _getDefaultTextStyle(),
          maxLines: widget.maxLines,
          overflow: TextOverflow.clip,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(left: 32),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(10),
                  Colors.white.withAlpha(500),
                  Colors.white
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
              child: Text(
                '更多',
                style: TextStyle(
                    color: widget.color ?? Colors.white, fontSize: 14),
              ),
            ),
            onTap: () {
              setState(() {
                _expanded = true;
                if (null != widget.onExpanded) {
                  widget.onExpanded!(_expanded);
                }
              });
            },
          ),
        )
      ],
    );
  }

  /*
   * @description   获取展开文件控件
   * @param
   * @return
   * @author        jay
   * @time          3/5/22 12:18 PM
   */
  Widget _getExpandedTextWidget(context, String text) {
    return RichText(
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      text: TextSpan(
        text: text,
        style: _getDefaultTextStyle(),
        children: [
          TextSpan(
              text: ' 收起',
              style: TextStyle(
                color: widget.color ?? Colors.white,
                fontSize: 14,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _expanded = false;
                    if (null != widget.onExpanded) {
                      widget.onExpanded!(_expanded);
                    }
                  });
                }),
        ],
      ),
    );
  }

  /*
   * @description   常规的文本组件
   * @param
   * @return
   * @author        jay
   * @time          3/5/22 12:16 PM
   */
  Widget _getRegularTextWidget(text, style) {
    return Text(text, style: style);
  }

  /*
   * @description   获取默认的文本样式
   * @param
   * @return
   * @author        jay
   * @time          3/5/22 12:17 PM
   */
  TextStyle _getDefaultTextStyle() {
    TextStyle style = widget.textStyle ??
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: widget.color ?? Colors.white,
        );
    return style;
  }
}
