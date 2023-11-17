part of toast;

/*
* @description: Toast的显示样式
* @param: 
* @return: 
* @author: Ethan Zhu
* @time: 2023-11-13 11:56:26 星期一
*/
class _ToastChild extends StatelessWidget {
  const _ToastChild({
    Key? key,
    required this.msg,
    required this.verticalOffset,
    this.background,
    this.radius,
    this.leading,
    this.gravity,
    this.textStyle,
  }) : super(key: key);

  Alignment get alignment {
    switch (gravity) {
      case ToastAlign.bottom:
        return Alignment.bottomCenter;
      case ToastAlign.top:
        return Alignment.topCenter;
      case ToastAlign.center:
      default:
        return Alignment.center;
    }
  }

  EdgeInsets get padding {
    switch (gravity) {
      case ToastAlign.bottom:
        return EdgeInsets.only(bottom: verticalOffset);
      case ToastAlign.top:
        return EdgeInsets.only(top: verticalOffset);
      case ToastAlign.center:
      default:
        return EdgeInsets.only(top: verticalOffset);
    }
  }

  final String msg;
  final double verticalOffset;
  final Color? background;
  final double? radius;
  final Widget? leading;
  final ToastAlign? gravity;
  final TextStyle? textStyle;

  InlineSpan get leadingSpan {
    if (leading == null) {
      return const TextSpan(text: "");
    }
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(padding: const EdgeInsets.only(right: 6), child: leading!),
    );
  }

  @override
  Widget build(BuildContext context) {
    FNToastThemeData contextThemeData = FNToastTheme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: padding,
        alignment: alignment,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: background ?? contextThemeData.background,
            borderRadius:
                BorderRadius.circular(radius ?? contextThemeData.radius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x16000000),
                offset: Offset(0, 5),
                blurRadius: 12,
                spreadRadius: 4,
              )
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: RichText(
            text: TextSpan(children: <InlineSpan>[
              leadingSpan,
              TextSpan(
                  text: msg, style: textStyle ?? contextThemeData.textStyle),
            ]),
          ),
        ),
      ),
    );
  }
}

/*
* @description: 给视图加上一层蒙层
* @param: 
* @return: 
* @author: Ethan Zhu
* @time: 2023-11-13 11:57:38 星期一
*/
class _ToastMaskWidget extends StatelessWidget {
  final bool needMask;
  const _ToastMaskWidget({
    Key? key,
    required this.widget,
    this.needMask = false,
  }) : super(key: key);

  final Widget widget;

  /// 使用IgnorePointer，方便手势透传过去
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !needMask,
      child: Material(color: Colors.transparent, child: widget),
    );
  }
}
