part of pin_code_fields;

/*
* @description:     验证码输入组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/12 17:12
*/
class PinCodeTextField extends StatefulWidget {
  /// 上下文
  final BuildContext appContext;

  /// 填充容器的阴影
  final List<BoxShadow>? boxShadows;

  /// 验证码的预设长度（默认6）
  final int length;

  /// 是否显示掩码
  final bool obscureText;

  /// obscureText为true时，此属性不能为空，默认为 ●
  final String obscuringCharacter;

  /// 掩码视图，如果这个属性被设置，那么obscuringCharacter将被覆盖
  final Widget? obscuringWidget;

  /// 是否启用触觉反馈
  final bool useHapticFeedback;

  /// 触觉反馈类型
  final HapticFeedbackTypes hapticFeedbackTypes;

  /// 掩码展示时是否闪烁
  final bool blinkWhenObscuring;

  /// blinkWhenObscuring 设置为真时 动画时长
  final Duration blinkDuration;

  /// 当前输入文本变化时触发
  final ValueChanged<String>? onChanged;

  /// 全部输入完成时触发
  final ValueChanged<String>? onCompleted;

  /// 当点击键盘（done/next ）完成按钮时触发
  final ValueChanged<String>? onSubmitted;

  /// [onEditingComplete] 回调也会在用户完成编辑时运行。
  /// 它与 [onSubscribed] 不同，因为它有一个默认值
  /// 更新文本控制器并产生键盘焦点。 应用程序
  /// 需要不同的行为可以覆盖默认的[onEditingComplete]
  /// 当用户按下完成/下一步时如果你不希望键盘自动关闭，请将其设置为空函数
  final VoidCallback? onEditingComplete;

  /// 输入的文本样式 默认为 [ fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? textStyle;

  /// 错误的文本样式
  final TextStyle? errorTextStyle;

  /// 粘贴的文本样式 默认为 [fontWeight: FontWeight.bold] while
  /// [TextStyle.color] is [ThemeData.colorScheme.onSecondary]
  final TextStyle? pastedTextStyle;

  /// 整个行视图的背景颜色.
  final Color? backgroundColor;

  /// 验证码的布局方式 默认为 [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment;

  /// [AnimationType] 用于显示在 pin 代码字段中的文本。 默认为 [AnimationType.slide]
  final AnimationType animationType;

  /// 动画的持续时间。 默认为 [持续时间（毫秒：150）]
  final Duration animationDuration;

  /// [曲线]用于动画。 默认为 [Curves.easeInOut]
  final Curve animationCurve;

  /// [TextInputType] 用于 pin 代码字段。 默认为 [TextInputType.visiblePassword]
  final TextInputType keyboardType;

  /// PIN 码字段是否应自动对焦。 默认为[假]
  final bool autoFocus;

  /// 应该传递一个 [FocusNode] 从父级管理它
  final FocusNode? focusNode;

  /// 输入的格式验证列表
  final List<TextInputFormatter> inputFormatters;

  /// 启用或禁用该字段。 默认为[真]
  final bool enabled;

  /// [TextEditingController] 手动控制文本。 如果没有给定，则设置默认的 [TextEditingController()] 对象
  final TextEditingController? controller;

  /// 为各个 pin 字段启用颜色填充，默认为 [false]
  final bool enableActiveFill;

  /// 输入最后一个字段的值后自动关闭键盘。 默认为[真]
  final bool autoDismissKeyboard;

  /// 当组件从组件树中销毁时，自动处置 [controller] 和 [FocusNode]。 默认为[真]
  final bool autoDisposeControllers;

  /// 配置平台键盘如何选择大写或小写键盘。
  /// 仅支持文本键盘，其他键盘类型将忽略此配置。 大小写是区域感知的。
  /// - 复制自“https://api.flutter.dev/flutter/services/TextCapitalization-class.html”
  /// 默认为 [TextCapitalization.none]
  final TextCapitalization textCapitalization;

  final TextInputAction textInputAction;

  /// 错误动画控制器
  final StreamController<ErrorAnimationType>? errorAnimationController;

  /// 验证文本是否可以粘贴的回调方法。 当我们需要在粘贴之前验证文本时，这非常有用。
  /// 例如 验证文本是否为数字。 默认值将按收到时的样子粘贴。
  final bool Function(String? text)? beforeTextPaste;

  /// 检测pin_code表单点击的方法
  /// 适用于所有窗体窗口
  final Function? onTap;

  /// 粘贴对话框的配置。 了解更多 [DialogConfig]
  final DialogConfig? dialogConfig;

  /// 单元格样式主题
  final PinTheme pinTheme;

  /// iOS 键盘的亮度深色或浅色选择。
  final Brightness? keyboardAppearance;

  /// [TextFormField] 的验证器
  final FormFieldValidator<String>? validator;

  /// 保存表单时使用最终值调用的可选方法
  /// [FormState.save]。
  final FormFieldSetter<String>? onSaved;

  /// 启用 [TextFormField] 自动验证
  /// 默认为 [AutovalidateMode.onUserInteraction]
  final AutovalidateMode autovalidateMode;

  /// 从 [PinCodeTextField] 到错误文本的垂直填充高度
  /// 默认值为 16。
  final double errorTextSpace;

  /// 错误文本的边距
  /// 默认为 [EdgeInsets.zero]。
  final EdgeInsets errorTextMargin;

  /// [TextDirection] 控制文本流动的方向。
  /// 默认为 [TextDirection.ltr]
  final TextDirection errorTextDirection;

  /// 启用 TextFormField 的 pin 自动填充。
  /// 默认为 true
  final bool enablePinAutofill;

  /// 错误动画持续时间
  final int errorAnimationDuration;

  /// 是否显示光标
  final bool showCursor;

  /// 光标的颜色，默认为 Theme.of(context).accentColor
  final Color? cursorColor;

  /// 光标宽度，默认为2
  final double cursorWidth;

  /// 光标高度，默认为FontSize + 8；
  final double? cursorHeight;

  /// 自动填充清理操作
  final AutofillContextAction onAutoFillDisposeAction;

  /// 使用外部[自动填充组]
  final bool useExternalAutoFillGroup;

  /// 如果字段的值为空，则在字段中显示提示或占位符。
  /// 仅当不为 null 时才会出现。 建议使用单个字符。
  final String? hintCharacter;

  /// [hintCharacter]的样式，默认为[fontSize: 20, fontWeight: FontWeight.bold]
  /// 并且它还使用了 [textStyle] 的属性
  /// [TextStyle.color] 是 [Colors.grey]
  final TextStyle? hintStyle;

  /// ScrollPadding 遵循与 TextField 的 ScrollPadding 相同的属性，默认为
  /// const EdgeInsets.all(20),
  final EdgeInsets scrollPadding;

  /// 文本渐变
  final Gradient? textGradient;

  /// 是否为只读
  final bool readOnly;

  /// 启用自动散焦
  final bool autoUnfocus;

  /// 分隔构建器
  final IndexedWidgetBuilder? separatorBuilder;

  PinCodeTextField({
    Key? key,
    required this.appContext,
    required this.length,
    this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.obscuringWidget,
    this.blinkWhenObscuring = false,
    this.blinkDuration = const Duration(milliseconds: 500),
    this.onChanged,
    this.onCompleted,
    this.backgroundColor,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.animationType = AnimationType.slide,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.onTap,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle,
    this.errorTextStyle,
    this.useHapticFeedback = false,
    this.hapticFeedbackTypes = HapticFeedbackTypes.light,
    this.pastedTextStyle,
    this.enableActiveFill = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.onSubmitted,
    this.onEditingComplete,
    this.errorAnimationController,
    this.beforeTextPaste,
    this.dialogConfig,
    this.pinTheme = const PinTheme.defaults(),
    this.keyboardAppearance,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorTextSpace = 16,
    this.errorTextDirection = TextDirection.ltr,
    this.errorTextMargin = EdgeInsets.zero,
    this.enablePinAutofill = true,
    this.errorAnimationDuration = 500,
    this.boxShadows,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.hintCharacter,
    this.hintStyle,
    this.textGradient,
    this.readOnly = false,
    this.autoUnfocus = true,

    /// Default for [AutofillGroup]
    this.onAutoFillDisposeAction = AutofillContextAction.commit,

    /// Default create internal [AutofillGroup]
    this.useExternalAutoFillGroup = false,
    this.scrollPadding = const EdgeInsets.all(20),
    this.separatorBuilder,
  })  : assert(obscuringCharacter.isNotEmpty),
        super(key: key);

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField>
    with TickerProviderStateMixin {
  TextEditingController? _textEditingController;
  FocusNode? _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;
  BorderRadius? borderRadius;

  // Whether the character has blinked
  bool _hasBlinked = false;

  // AnimationController for the error animation
  late AnimationController _controller;

  late AnimationController _cursorController;

  StreamSubscription<ErrorAnimationType>? _errorAnimationSubscription;
  bool isInErrorMode = false;

  // Animation for the error animation
  late Animation<Offset> _offsetAnimation;

  late Animation<double> _cursorAnimation;
  DialogConfig get _dialogConfig => widget.dialogConfig == null
      ? DialogConfig()
      : DialogConfig(
          affirmativeText: widget.dialogConfig!.affirmativeText,
          dialogContent: widget.dialogConfig!.dialogContent,
          dialogTitle: widget.dialogConfig!.dialogTitle,
          negativeText: widget.dialogConfig!.negativeText,
          platform: widget.dialogConfig!.platform,
        );
  PinTheme get _pinTheme => widget.pinTheme;

  Timer? _blinkDebounce;

  TextStyle get _textStyle => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ).merge(widget.textStyle);

  TextStyle get _hintStyle => _textStyle
      .copyWith(
        color: _pinTheme.disabledColor,
      )
      .merge(widget.hintStyle);

  bool get _hintAvailable => widget.hintCharacter != null;

  @override
  void initState() {
    super.initState();
    // if (!kReleaseMode) {
    //   print(
    //       "IF YOU WANT TO USE COLOR FILL FOR EACH CELL THEN SET enableActiveFill = true");
    // }

    _checkForInvalidValues();
    _assignController();
    if (_pinTheme.shape != PinCodeFieldShape.circle &&
        _pinTheme.shape != PinCodeFieldShape.underline) {
      borderRadius = _pinTheme.borderRadius;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(() {
      _setState(() {});
    }); // Rebuilds on every change to reflect the correct color on each field.
    _inputList = List<String>.filled(widget.length, "");

    _hasBlinked = true;

    _cursorController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _cursorController,
      curve: Curves.easeIn,
    ));
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.errorAnimationDuration),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    if (widget.showCursor) {
      _cursorController.repeat();
    }

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    if (widget.errorAnimationController != null) {
      _errorAnimationSubscription =
          widget.errorAnimationController!.stream.listen((errorAnimation) {
        if (errorAnimation == ErrorAnimationType.shake) {
          _controller.forward();

          _setState(() => isInErrorMode = true);
        } else if (errorAnimation == ErrorAnimationType.clear) {
          _setState(() => isInErrorMode = false);
        }
      });
    }
    // If a default value is set in the TextEditingController, then set to UI
    if (_textEditingController!.text.isNotEmpty)
      _setTextToInput(_textEditingController!.text);
  }

  // validating all the values
  void _checkForInvalidValues() {
    assert(widget.length > 0);
    assert(_pinTheme.fieldHeight > 0);
    assert(_pinTheme.fieldWidth > 0);
    assert(_pinTheme.borderWidth >= 0);
    assert(_dialogConfig.affirmativeText != null &&
        _dialogConfig.affirmativeText!.isNotEmpty);
    assert(_dialogConfig.negativeText != null &&
        _dialogConfig.negativeText!.isNotEmpty);
    assert(_dialogConfig.dialogTitle != null &&
        _dialogConfig.dialogTitle!.isNotEmpty);
    assert(_dialogConfig.dialogContent != null &&
        _dialogConfig.dialogContent!.isNotEmpty);
  }

  runHapticFeedback() {
    switch (widget.hapticFeedbackTypes) {
      case HapticFeedbackTypes.heavy:
        HapticFeedback.heavyImpact();
        break;

      case HapticFeedbackTypes.medium:
        HapticFeedback.mediumImpact();
        break;

      case HapticFeedbackTypes.light:
        HapticFeedback.lightImpact();
        break;

      case HapticFeedbackTypes.selection:
        HapticFeedback.selectionClick();
        break;

      case HapticFeedbackTypes.vibrate:
        HapticFeedback.vibrate();
        break;

      default:
        break;
    }
  }

  // Assigning the text controller, if empty assigning a new one.
  void _assignController() {
    _textEditingController = widget.controller ?? TextEditingController();

    _textEditingController?.addListener(_textEditingControllerListener);
  }

  void _textEditingControllerListener() {
    if (widget.useHapticFeedback) {
      runHapticFeedback();
    }

    if (isInErrorMode) {
      _setState(() => isInErrorMode = false);
    }

    _debounceBlink();

    var currentText = _textEditingController!.text;

    if (widget.enabled && _inputList.join("") != currentText) {
      if (currentText.length >= widget.length) {
        if (widget.onCompleted != null) {
          if (currentText.length > widget.length) {
            // removing extra text longer than the length
            currentText = currentText.substring(0, widget.length);
          }
          //  delay the onComplete event handler to give the onChange event handler enough time to complete
          Future.delayed(Duration(milliseconds: 300),
              () => widget.onCompleted!(currentText));
        }

        if (widget.autoDismissKeyboard) _focusNode!.unfocus();
      }
      _setTextToInput(currentText);

      widget.onChanged?.call(currentText);
    }
  }

  void _debounceBlink() {
    // set has blinked to false and back to true
    // after duration
    if (widget.blinkWhenObscuring &&
        _textEditingController!.text.length >
            _inputList.where((x) => x.isNotEmpty).length) {
      _setState(() {
        _hasBlinked = false;
      });

      if (_blinkDebounce?.isActive ?? false) {
        _blinkDebounce!.cancel();
      }

      _blinkDebounce = Timer(widget.blinkDuration, () {
        _setState(() {
          _hasBlinked = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _textEditingController!.removeListener(_textEditingControllerListener);
    if (widget.autoDisposeControllers) {
      _textEditingController!.dispose();
      _focusNode!.dispose();
      // if (!kReleaseMode) {
      //   print(
      //       "*** Disposing _textEditingController and _focusNode, To disable this feature please set autoDisposeControllers = false***");
      // }
    }

    _errorAnimationSubscription?.cancel();

    _cursorController.dispose();

    _controller.dispose();
    super.dispose();
  }

  // selects the right color for the field
  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disableBorderColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus &&
        !isInErrorMode) {
      return _pinTheme.selectedColor;
    } else if (_selectedIndex > index) {
      Color relevantActiveColor = _pinTheme.activeColor;
      if (isInErrorMode) relevantActiveColor = _pinTheme.errorBorderColor;
      return relevantActiveColor;
    }

    Color relevantInActiveColor = _pinTheme.inactiveColor;
    if (isInErrorMode) relevantInActiveColor = _pinTheme.errorBorderColor;
    return relevantInActiveColor;
  }

  double _getBorderWidthForIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledBorderWidth;
    }

    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus) {
      return _pinTheme.selectedBorderWidth;
    } else if (_selectedIndex > index) {
      double relevantActiveBorderWidth = _pinTheme.activeBorderWidth;
      if (isInErrorMode) relevantActiveBorderWidth = _pinTheme.errorBorderWidth;
      return relevantActiveBorderWidth;
    }

    double relevantActiveBorderWidth = _pinTheme.inactiveBorderWidth;
    if (isInErrorMode) relevantActiveBorderWidth = _pinTheme.errorBorderWidth;
    return relevantActiveBorderWidth;
  }

  List<BoxShadow>? _getBoxShadowFromIndex(int index) {
    if (_selectedIndex == index) {
      return _pinTheme.activeBoxShadows;
    } else if (_selectedIndex > index) {
      return _pinTheme.inActiveBoxShadows;
    }

    return [];
  }

  Widget _renderPinField({
    @required int? index,
  }) {
    assert(index != null);

    bool showObscured = !widget.blinkWhenObscuring ||
        (widget.blinkWhenObscuring && _hasBlinked) ||
        index != _inputList.where((x) => x.isNotEmpty).length - 1;

    if (widget.obscuringWidget != null) {
      if (showObscured) {
        if (_inputList[index!].isNotEmpty) {
          return widget.obscuringWidget!;
        }
      }
    }

    if (_inputList[index!].isEmpty && _hintAvailable) {
      return Text(
        widget.hintCharacter!,
        key: ValueKey(_inputList[index]),
        style: _hintStyle,
      );
    }

    final text =
        widget.obscureText && _inputList[index].isNotEmpty && showObscured
            ? widget.obscuringCharacter
            : _inputList[index];
    return widget.textGradient != null
        ? Gradiented(
            gradient: widget.textGradient!,
            child: Text(
              text,
              key: ValueKey(_inputList[index]),
              style: _textStyle.copyWith(color: Colors.white),
            ),
          )
        : Text(
            text,
            key: ValueKey(_inputList[index]),
            style: _textStyle,
          );
  }

// selects the right fill color for the field
  Color _getFillColorFromIndex(int index) {
    if (!widget.enabled) {
      return _pinTheme.disabledColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus) {
      return _pinTheme.selectedFillColor;
    } else if (_selectedIndex > index) {
      return _pinTheme.activeFillColor;
    }
    return _pinTheme.inactiveFillColor;
  }

  /// Builds the widget to be shown
  Widget buildChild(int index) {
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode!.hasFocus &&
        widget.showCursor) {
      final cursorColor = widget.cursorColor ??
          Theme.of(widget.appContext).textSelectionTheme.cursorColor ??
          Theme.of(context).colorScheme.onSecondary;
      final cursorHeight = widget.cursorHeight ?? _textStyle.fontSize! + 8;

      if ((_selectedIndex == index + 1 && index + 1 == widget.length)) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: _textStyle.fontSize! / 1.5),
                child: FadeTransition(
                  opacity: _cursorAnimation,
                  child: CustomPaint(
                    size: Size(0, cursorHeight),
                    painter: CursorPainter(
                      cursorColor: isInErrorMode
                          ? _pinTheme.errorBorderColor
                          : cursorColor,
                      cursorWidth: widget.cursorWidth,
                    ),
                  ),
                ),
              ),
            ),
            _renderPinField(
              index: index,
            ),
          ],
        );
      } else {
        return Center(
          child: FadeTransition(
            opacity: _cursorAnimation,
            child: CustomPaint(
              size: Size(0, cursorHeight),
              painter: CursorPainter(
                cursorColor: cursorColor,
                cursorWidth: widget.cursorWidth,
              ),
            ),
          ),
        );
      }
    }
    return _renderPinField(
      index: index,
    );
  }

  Future<void> _showPasteDialog(String pastedText) {
    final formattedPastedText = pastedText
        .trim()
        .substring(0, min(pastedText.trim().length, widget.length));

    final defaultPastedTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSecondary,
    );

    return showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) => _dialogConfig.platform == PinCodePlatform.iOS
          ? CupertinoAlertDialog(
              title: Text(_dialogConfig.dialogTitle!),
              content: RichText(
                text: TextSpan(
                  text: _dialogConfig.dialogContent,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelLarge!.color,
                  ),
                  children: [
                    TextSpan(
                      text: formattedPastedText,
                      style: widget.pastedTextStyle ?? defaultPastedTextStyle,
                    ),
                    TextSpan(
                      text: "?",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge!.color,
                      ),
                    )
                  ],
                ),
              ),
              actions: _getActionButtons(formattedPastedText),
            )
          : AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(_dialogConfig.dialogTitle!),
              content: RichText(
                text: TextSpan(
                  text: _dialogConfig.dialogContent,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.labelLarge!.color),
                  children: [
                    TextSpan(
                      text: formattedPastedText,
                      style: widget.pastedTextStyle ?? defaultPastedTextStyle,
                    ),
                    TextSpan(
                      text: " ?",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge!.color,
                      ),
                    )
                  ],
                ),
              ),
              actions: _getActionButtons(formattedPastedText),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Directionality textField = Directionality(
      textDirection: widget.errorTextDirection,
      child: Padding(
        padding: widget.errorTextMargin,
        child: TextFormField(
          textInputAction: widget.textInputAction,
          controller: _textEditingController,
          focusNode: _focusNode,
          enabled: widget.enabled,
          autofillHints: widget.enablePinAutofill && widget.enabled
              ? <String>[AutofillHints.oneTimeCode]
              : null,
          autofocus: widget.autoFocus,
          autocorrect: false,
          keyboardType: widget.keyboardType,
          keyboardAppearance: widget.keyboardAppearance,
          textCapitalization: widget.textCapitalization,
          validator: widget.validator,
          onSaved: widget.onSaved,
          autovalidateMode: widget.autovalidateMode,
          inputFormatters: [
            ...widget.inputFormatters,
            LengthLimitingTextInputFormatter(
              widget.length,
            ), // this limits the input length
            CustomFormatter(),
          ],
          // trigger on the complete event handler from the keyboard
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          enableInteractiveSelection: false,
          showCursor: false,
          // using same as background color so tha it can blend into the view
          cursorWidth: 0.01,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
              fillColor: widget.backgroundColor,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorStyle: widget.errorTextStyle),
          style: const TextStyle(
            color: Colors.transparent,
            height: .01,
            fontSize: kIsWeb
                ? 1
                : 0.01, // it is a hidden textfield which should remain transparent and extremely small
          ),
          scrollPadding: widget.scrollPadding,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText,
        ),
      ),
    );

    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        // adding the extra space at the bottom to show the error text from validator
        height: (widget.autovalidateMode == AutovalidateMode.disabled &&
                widget.validator == null)
            ? widget.pinTheme.fieldHeight
            : widget.pinTheme.fieldHeight + widget.errorTextSpace,
        color: widget.backgroundColor,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            AbsorbPointer(
              // this is a hidden textfield under the pin code fields.
              absorbing: true, // it prevents on tap on the text field
              child: widget.useExternalAutoFillGroup
                  ? textField
                  : AutofillGroup(
                      onDisposeAction: widget.onAutoFillDisposeAction,
                      child: textField,
                    ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.onTap != null) widget.onTap!();
                  _onFocus();
                },
                onLongPress: widget.enabled
                    ? () async {
                        var data = await Clipboard.getData("text/plain");
                        if (data?.text?.isNotEmpty ?? false) {
                          if (widget.beforeTextPaste != null) {
                            if (widget.beforeTextPaste!(data!.text)) {
                              _showPasteDialog(data.text!);
                            }
                          } else {
                            _showPasteDialog(data!.text!);
                          }
                        }
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: widget.mainAxisAlignment,
                  children: _generateFields(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(
        Container(
            padding: _pinTheme.fieldOuterPadding,
            child: AnimatedContainer(
              curve: widget.animationCurve,
              duration: widget.animationDuration,
              width: _pinTheme.fieldWidth,
              height: _pinTheme.fieldHeight,
              decoration: BoxDecoration(
                color: widget.enableActiveFill
                    ? _getFillColorFromIndex(i)
                    : Colors.transparent,
                boxShadow: (_pinTheme.activeBoxShadows != null ||
                        _pinTheme.inActiveBoxShadows != null)
                    ? _getBoxShadowFromIndex(i)
                    : widget.boxShadows,
                shape: _pinTheme.shape == PinCodeFieldShape.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: borderRadius,
                border: _pinTheme.shape == PinCodeFieldShape.underline
                    ? Border(
                        bottom: BorderSide(
                          color: _getColorFromIndex(i),
                          width: _getBorderWidthForIndex(i),
                        ),
                      )
                    : Border.all(
                        color: _getColorFromIndex(i),
                        width: _getBorderWidthForIndex(i),
                      ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: widget.animationCurve,
                  switchOutCurve: widget.animationCurve,
                  duration: widget.animationDuration,
                  transitionBuilder: (child, animation) {
                    if (widget.animationType == AnimationType.scale) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    } else if (widget.animationType == AnimationType.fade) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    } else if (widget.animationType == AnimationType.none) {
                      return child;
                    } else {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, .5),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }
                  },
                  child: buildChild(i),
                ),
              ),
            )),
      );
      if (widget.separatorBuilder != null && i != widget.length - 1) {
        result.add(widget.separatorBuilder!(context, i));
      }
    }
    return result;
  }

  void _onFocus() {
    if (widget.autoUnfocus) {
      if (_focusNode!.hasFocus &&
          MediaQuery.of(widget.appContext).viewInsets.bottom == 0) {
        _focusNode!.unfocus();
        Future.delayed(
            const Duration(microseconds: 1), () => _focusNode!.requestFocus());
      } else {
        _focusNode!.requestFocus();
      }
    } else {
      _focusNode!.requestFocus();
    }
  }

  void _setTextToInput(String data) async {
    var replaceInputList = List<String>.filled(widget.length, "");

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    _setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }

  List<Widget> _getActionButtons(String pastedText) {
    var resultList = <Widget>[];
    if (_dialogConfig.platform == PinCodePlatform.iOS) {
      resultList.addAll([
        CupertinoDialogAction(
          child: Text(_dialogConfig.negativeText!),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(_dialogConfig.affirmativeText!),
          onPressed: () {
            _textEditingController!.text = pastedText;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ]);
    } else {
      resultList.addAll([
        TextButton(
          child: Text(_dialogConfig.negativeText!),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        TextButton(
          child: Text(_dialogConfig.affirmativeText!),
          onPressed: () {
            _textEditingController!.text = pastedText;
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ]);
    }
    return resultList;
  }

  void _setState(void Function() function) {
    if (mounted) {
      setState(function);
    }
  }
}

enum PinCodeFieldShape { box, underline, circle }

enum ErrorAnimationType { shake, clear }

class CustomFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text,
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}
