import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

import '../../res/lib_res.dart';

/// 带输入框模式
/// CommonInputWidget(
///    important: true,
///    title: '标题',
///    // errorText: '内容不能为空',
///    inputHintText: '请输入',
///    inputText: '1234',
///    fieldCallBack: (value){
///    print('输入内容:$value');
///    },
///    ),
///    有箭头模式
///    CommonInputWidget(
///    formType: FormType.normal,
///    readOnly: true,
///    important: true,
///    title: '标题',
///    inputText: '1234',
///    clickCallBack: (){
///    print('点击:回到');
///    },
///    ),

enum FormType {
  ///带输入框
  input,

  ///不带输入框，但显示箭头
  normal,

  ///多行文本框
  multiLines
}

/*
 * @description: 表单-文本输入
 * @author: Yman Chen
 * @time: 2023/5/17 11:00
 */
class FNUIForm extends StatefulWidget {
  ///表单类型
  final FormType formType;

  ///外边距
  final EdgeInsets? margin;

  ///内边距
  final EdgeInsets? padding;

  ///标题
  final String? title;

  ///是否必填项
  final bool? required;

  ///初始输入内容
  final String? inputText;

  ///初始输入提示内容
  final String? inputHintText;

  ///输入内容回调
  final Function(String value)? fieldCallBack;

  ///错误文本
  final String? errorText;

  ///只读状态，在normal状态下有用，input类型无效
  final bool? readOnly;

  ///多行文本输入,最大输入长度,默认100
  final int? maxLength;

  ///多行文本输入,输入框高度,默认110
  final double? textFieldHeight;

  ///点击箭头回调
  final Function? clickCallBack;

  const FNUIForm({
    Key? key,
    this.formType = FormType.input,
    this.margin,
    this.padding,
    this.title,
    this.required,
    this.inputText,
    this.inputHintText,
    this.fieldCallBack,
    this.errorText,
    this.readOnly,
    this.maxLength,
    this.textFieldHeight,
    this.clickCallBack,
  }) : super(key: key);

  @override
  State<FNUIForm> createState() => _FNUIFormState();
}

class _FNUIFormState extends State<FNUIForm> {
  String _inputText = '';
  int _textCount = 0;
  Function? _textCountSetState;

  @override
  void initState() {
    super.initState();
    _inputText = widget.inputText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    FNFormThemeData contextThemeData = FNFormTheme.of(context);
    return Container(
      margin: widget.margin,
      padding: widget.padding ?? contextThemeData.padding,
      color: FNColors.card,
      child: _getChildWidget(),
    );
  }

  /*
   * @description: 构建表达类型
   * @param
   * @return
   * @author: Yman Chen
   * @time: 2023/5/17 14:50
   */
  _getChildWidget() {
    switch (widget.formType) {
      case FormType.input:
        return _buildInputForm();
      case FormType.normal:
        return _buildNormalForm();
      case FormType.multiLines:
        return _buildMultiLinesInputForm();
    }
  }

  /*
   * @description: 构建输入框文本框
   * @param
   * @return
   * @author: Yman Chen
   * @time: 2023/5/23 15:55
   */
  Widget _buildInputForm() {
    FNFormThemeData contextThemeData = FNFormTheme.of(context);
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.required ?? contextThemeData.required,
              child: const FNUIText(
                padding: EdgeInsets.only(top: 3),
                text: '*',
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                alignment: Alignment.centerLeft,
              ),
            ),
            FNUIText(
              width: 120,
              padding: const EdgeInsets.only(right: 16),
              text: widget.title ?? '',
              color: widget.readOnly ?? contextThemeData.readOnly
                  ? FNColors.textSecondaryColor
                  : FNColors.textColor,
              fontWeight: (widget.readOnly ?? contextThemeData.readOnly)
                  ? FontWeight.normal
                  : FontWeight.bold,
              fontSize: 16,
              maxLines: 2,
            ),
            Expanded(
              child: FNUITextField(
                  contentPadding: EdgeInsets.zero,
                  textAlign: TextAlign.start,
                  inputText: _inputText,
                  textStyle:
                      const TextStyle(fontSize: 16, color: FNColors.textColor),
                  hintText: widget.inputHintText ?? '',
                  hintStyle: const TextStyle(
                      fontSize: 16, color: FNColors.textTipColor),
                  cursorColor: FNColors.primary,
                  enabled: !(widget.readOnly ?? contextThemeData.readOnly),
                  fieldCallBack: (value) => widget.fieldCallBack?.call(value)),
            ),
            GestureDetector(
              onTap: () {
                if (!(widget.readOnly ?? contextThemeData.readOnly)) {
                  setState(() {
                    _inputText = '';
                  });
                  widget.fieldCallBack?.call('');
                }
              },
              child: Image.asset(
                'lib/assets/images/icon_common_textfiled_clear.png',
                /*KImagePath.commonTextFiledClear*/
                width: 17,
                height: 17,
                package: LibRes.PLUGIN_NAME,
              ),
            ),
          ],
        ),
        Visibility(
          visible: widget.errorText != null,
          child: Container(
            margin: const EdgeInsets.only(top: 18),
            child: const Divider(
              height: 0.5,
              color: FNColors.backgroundWarning,
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: FNUIText(
            margin: const EdgeInsets.only(top: 8),
            text: widget.errorText ?? '',
            color: FNColors.backgroundWarning,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /*
   * @description: 构建普通表单
   * @param
   * @return
   * @author: Yman Chen
   * @time: 2023/5/23 15:56
   */
  Widget _buildNormalForm() {
    FNFormThemeData contextThemeData = FNFormTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.required ?? contextThemeData.required,
          child: const FNUIText(
            padding: EdgeInsets.only(top: 3),
            text: '*',
            color: FNColors.backgroundWarning,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            alignment: Alignment.centerLeft,
          ),
        ),
        FNUIText(
          padding: const EdgeInsets.only(right: 16),
          width: 120,
          text: widget.title ?? '',
          color: widget.readOnly ?? contextThemeData.readOnly
              ? FNColors.textSecondaryColor
              : FNColors.textColor,
          fontWeight: widget.readOnly ?? contextThemeData.readOnly
              ? FontWeight.normal
              : FontWeight.bold,
          fontSize: 16,
          maxLines: 2,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (!(widget.readOnly ?? contextThemeData.readOnly)) {
                widget.clickCallBack?.call();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FNUIText(
                    text: _inputText,
                    fontSize: 16,
                    color: FNColors.textColor,
                  ),
                ),
                Image.asset(
                  'lib/assets/images/icon_arrow_forward.png',
                  /*KImagePath.commonArrowForward,*/
                  width: 12,
                  height: 24,
                  package: LibRes.PLUGIN_NAME,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /*
   * @description: 构建多行文本输入框
   * @param
   * @return
   * @author: Yman Chen
   * @time: 2023/5/23 15:57
   */
  _buildMultiLinesInputForm() {
    FNFormThemeData contextThemeData = FNFormTheme.of(context);
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.textFieldHeight,
          child: FNUITextField(
              maxLength: widget.maxLength,
              textAlign: TextAlign.start,
              inputText: _inputText,
              textStyle: const TextStyle(
                  fontSize: 14, color: FNColors.textColor, height: 1.57),
              hintText: widget.inputHintText ?? '',
              hintStyle:
                  const TextStyle(fontSize: 14, color: FNColors.textTipColor),
              cursorColor: FNColors.primary,
              enabled: !(widget.readOnly ?? contextThemeData.readOnly),
              fieldCallBack: (value) {
                widget.fieldCallBack?.call(value);
                _inputText = value;
                _textCountSetState?.call(() {
                  _textCount = value.length;
                });
              }),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              _textCountSetState = setState;
              return Text.rich(TextSpan(children: [
                TextSpan(
                    text: '$_textCount',
                    style: TextStyle(
                        color: _textCount > 0
                            ? FNColors.textColor
                            : FNColors.textTipColor,
                        fontSize: 12)),
                TextSpan(
                    text: '/${widget.maxLength}',
                    style: const TextStyle(
                        color: FNColors.textTipColor, fontSize: 12)),
              ]));
            },
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Divider(
              height: 0.5,
              color: FNColors.backgroundWarning,
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: FNUIText(
            margin: const EdgeInsets.only(top: 8),
            text: widget.errorText ?? '',
            color: FNColors.backgroundWarning,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
