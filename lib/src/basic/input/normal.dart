import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fn_ui_kit/src/theme/export.dart';
import '../../constant/export.dart';

/// 自带删除的TextField
typedef FNTextFieldCallBack = void Function(String content);
typedef SubmitActionCallBack = void Function(String content);

enum BaseKeyBoardType {
  text,
  multiline,
  number,
  phone,
  datetime,
  emailAddress,
  url,
  password,
  specialNumber,
  verifyCode,
  englishName,
  idCard,
  positiveInteger,
  decimalNumber,
}

class FNUITextField extends StatefulWidget {
  /*
   *  键盘样式
   */
  final BaseKeyBoardType? keyboardType;
  /*
   * 高度是否自动适配
   */
  final bool? autoHeight;
  /*
   * 最大行数
   */
  final int? maxLines;
  /*
   * 最大长度
   */
  final int? maxLength;
  /*
   * 输入内容
   */
  final String? inputText;
  /*
   * 提示内容
   */
  final String hintText;
  /*
   * 提示内容样式
   */
  final TextStyle? hintStyle;
  /*
   *  内容样式
   */
  final TextStyle? textStyle;
  /*
   *  错误文字样式
   */
  final TextStyle? errorStyle;
  /*
   *  对齐方式
   */
  final TextAlign? textAlign;
  /*
   * 输入回调
   */
  final FNTextFieldCallBack? fieldCallBack;
  /*
   * 聚焦失焦回调
   */
  final ValueChanged<bool>? focusCallBack;
  /*
   * 点击确认按钮回调
   */
  final SubmitActionCallBack? submitCallBack;
  /*
   * 密码右侧图标
   */
  final Icon? passwordIcon;
  /*
   *  输入边框
   */
  final InputBorder? inputBorder;
  /*
   *  允许输入边框
   */
  final InputBorder? enabledBorder;
  /*
   *  输入错误没有焦点的边框
   */
  final InputBorder? errorBorder;
  /*
   *  输入时焦点的边框
   */
  final InputBorder? focusedBorder;
  /*
   *  输入时焦点的错误边框
   */
  final InputBorder? focusedErrorBorder;
  /*
   *  禁用状态的边框
   */
  final InputBorder? disabledBorder;
  /*
   *  错误文本
   */
  final String? errorText;
  /*
   * 输入框前缀图标
   */
  final Widget? prefixIcon;
  /*
   *  正则验证
   */
  final FormFieldValidator<String>? validator;
  /*
   *
   */
  final bool? obscureText;
  /*
   * 前缀文本
   */
  final String? suffixText;
  /*
   *
   */
  final FocusNode? focusNode;
  /*
   * 自动焦点
   */
  final bool? autoFocus;
  /*
   * 精度
   */
  final int? digit;
  /*
   *  是否清除内容
   */
  final bool clear;
  /*
   *  回车按钮类型
   */
  final TextInputAction? inputAction;
  /*
   *  控制器
   */
  final TextEditingController? controller;

  final int? lengthLimit;

  ///光标颜色
  final Color? cursorColor;

  ///光标宽度
  final double? cursorWidth;

  ///是否禁用，默认true
  final bool enabled;

  ///内容边距
  final EdgeInsetsGeometry? contentPadding;

  ///密码样式，默认'•'
  final String? obscuringCharacter;

  ///密码图标颜色
  final Color? passwordSuffixIconColor;

  /// 前置组件
  final Widget? prefix;

  /// 后置组件
  final Widget? suffixIcon;

  /// 前置组件宽高限制
  final BoxConstraints? prefixIconConstraints;

  /// 后置组件宽高限制
  final BoxConstraints? suffixIconConstraints;

  /// 自定义formatter
  final List<TextInputFormatter>? formatter;

  /// 文字方向
  final TextDirection? textDirection;

  /// hint文字方向
  final TextDirection? hintTextDirection;

  const FNUITextField({
    Key? key,
    BaseKeyBoardType keyboardType = BaseKeyBoardType.text,
    required this.hintText,
    this.autoHeight = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputText,
    this.hintStyle,
    this.fieldCallBack,
    this.passwordIcon,
    this.inputBorder,
    this.textStyle,
    this.prefixIcon,
    this.textAlign,
    this.validator,
    this.obscureText,
    this.suffixText,
    this.focusNode,
    this.autoFocus,
    this.digit = 8,
    this.clear = false,
    this.focusCallBack,
    this.submitCallBack,
    this.inputAction,
    this.lengthLimit,
    this.controller,
    this.cursorColor,
    this.enabled = true,
    this.contentPadding,
    this.obscuringCharacter,
    this.passwordSuffixIconColor,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.errorText,
    this.prefix,
    this.suffixIcon,
    this.cursorWidth,
    this.errorStyle,
    this.formatter,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.textDirection,
    this.hintTextDirection,
  })  : assert(maxLines == null || maxLines > 0),
        assert(maxLength == null || maxLength > 0),
        keyboardType =
            maxLines == 1 ? keyboardType : BaseKeyBoardType.multiline,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _FNTextField();
}

class _FNTextField extends State<FNUITextField> {
  bool _isVerifyCode = false;
  bool _isPassword = false;

  /// 控制器
  TextEditingController _controller = TextEditingController();

  final FocusNode _verifyNode = FocusNode();

  ///输入类型
  TextInputType _getTextInputType() {
    switch (widget.keyboardType) {
      case BaseKeyBoardType.text:
        return TextInputType.text;
      case BaseKeyBoardType.multiline:
        return TextInputType.multiline;
      case BaseKeyBoardType.number:
        return TextInputType.number;
      case BaseKeyBoardType.specialNumber:
        return TextInputType.number;
      case BaseKeyBoardType.phone:
        return TextInputType.phone;
      case BaseKeyBoardType.datetime:
        return TextInputType.datetime;
      case BaseKeyBoardType.emailAddress:
        return TextInputType.emailAddress;
      case BaseKeyBoardType.url:
        return TextInputType.url;
      case BaseKeyBoardType.password:
        return TextInputType.text;
      case BaseKeyBoardType.verifyCode:
        _isVerifyCode = true;
        return TextInputType.number;
      case BaseKeyBoardType.idCard:
        return TextInputType.text;
      case BaseKeyBoardType.englishName:
        return TextInputType.name;
      case BaseKeyBoardType.positiveInteger:
        return TextInputType.number;
      case BaseKeyBoardType.decimalNumber:
        return const TextInputType.numberWithOptions(decimal: true);
      default:
        return TextInputType.text;
    }
  }

  ///输入范围
  // ignore: missing_return
  List<TextInputFormatter> _getTextInputFormatter() {
    // 表情emoji的正则表达式
    const String REGEX_EMOJI =
        "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";

    switch (widget.keyboardType) {
      case BaseKeyBoardType.number:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 20),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.specialNumber:
      case BaseKeyBoardType.decimalNumber:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
          NumberTextInputFormatter(digit: widget.digit ?? 2),
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 20),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.verifyCode:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 6), //限制长度
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.password:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9!@#\$%^&*]')),
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 16),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.englishName:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]|[0-9]|[-:#,/.]')),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.idCard:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]|[0-9]')),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.positiveInteger:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          NumberTextInputFormatter(digit: widget.digit ?? 2),
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 20),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      case BaseKeyBoardType.emailAddress:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]|[@.]")),
          LengthLimitingTextInputFormatter(widget.lengthLimit ?? 200),
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
      default:
        return <TextInputFormatter>[
          FilteringTextInputFormatter.deny(RegExp(REGEX_EMOJI)),
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == BaseKeyBoardType.password) {
      _isPassword = true;
    }
    if (widget.controller != null) {
      _controller = widget.controller!;
    }
    //不是验证码并且focusnode不为空，监听聚焦失焦事件
    if (!_isVerifyCode && widget.focusNode != null) {
      widget.focusNode?.addListener(() {
        if (widget.focusCallBack != null) {
          widget.focusCallBack!(widget.focusNode?.hasFocus ?? false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear) {
      _controller.clear();
    }
    if (widget.inputText != null) {
      _controller.text = widget.inputText ?? "";
      _controller.selection = TextSelection(
          baseOffset: widget.inputText?.length ?? 0,
          extentOffset: widget.inputText?.length ?? 0);
    }
    return Theme(
      data: Theme.of(context).copyWith(
        disabledColor: FNColors.textColor,
      ),
      child: TextField(
        textDirection: widget.textDirection,
        enabled: widget.enabled,
        controller: _controller,
        focusNode: _isVerifyCode ? _verifyNode : widget.focusNode,
        autofocus: widget.autoFocus ?? false,
        cursorColor: widget.cursorColor,
        cursorWidth: widget.cursorWidth ?? 2,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentPadding,
          hintStyle: widget.hintStyle ??
              const TextStyle(
                color: FNColors.textExplainColor,
                fontSize: FNFontSize14,
              ),
          counterText: '',
          hintText: widget.hintText,
          hintTextDirection: widget.hintTextDirection,
          hintMaxLines: 5,
          border: widget.inputBorder ?? InputBorder.none,
          enabledBorder: widget.enabledBorder ?? InputBorder.none,
          errorBorder: widget.errorBorder ?? InputBorder.none,
          focusedBorder: widget.focusedBorder ?? InputBorder.none,
          focusedErrorBorder: widget.focusedErrorBorder ?? InputBorder.none,
          disabledBorder: widget.disabledBorder ?? InputBorder.none,
          errorText: widget.errorText,
          errorStyle: widget.errorStyle,
          fillColor: Colors.transparent,
          suffixText: widget.suffixText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          prefixIconConstraints: widget.prefixIconConstraints,
          suffixIconConstraints: widget.suffixIconConstraints,
          errorMaxLines: 1,
          prefix: widget.prefix,
        ),
        showCursor: true,
        onChanged: (str) {
          widget.fieldCallBack?.call(str);
        },
        onSubmitted: (value) {
          if (widget.submitCallBack != null) widget.submitCallBack!(value);
        },
        keyboardType: _getTextInputType(),
        maxLengthEnforcement: widget.maxLength != null
            ? MaxLengthEnforcement.enforced
            : MaxLengthEnforcement.none,
        maxLength: widget.maxLength,
        maxLines: (widget.autoHeight ?? true) ? null : widget.maxLines,
        inputFormatters: _getTextInputFormatter()
          ..addAll(widget.formatter ?? []),
        style: widget.textStyle ??
            const TextStyle(
              color: FNColors.textColor,
              fontSize: FNFontSize14,
            ),
        obscureText: widget.obscureText ?? _isPassword,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
        textAlign: widget.textAlign ?? TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: widget.inputAction ?? TextInputAction.done,
      ),
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  ///允许的小数位数，-1代表不限制位数
  int digit;
  NumberTextInputFormatter({this.digit = -1});
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value == "-") {
      value = "-";
      selectionIndex++;
    } else if (value != "" &&
            value != defaultDouble.toString() &&
            strToFloat(value, defaultDouble) == defaultDouble ||
        getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
