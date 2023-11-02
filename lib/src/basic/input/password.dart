import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

import '../../../res/lib_res.dart';

class FNUIPasswordInputController extends ChangeNotifier {
  bool _obscureText = false;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }
}

/*
* @description:     密码输入组件
* param:
* @return:
* @author:          novice.cai
* @time:            2023/7/13 15:00
*/
class FNUIPasswordInputWidget extends StatefulWidget {
  final FNUIPasswordInputController? passwordInputController;
  final BaseKeyBoardType? keyboardType;
  final String? hintText;
  final FocusNode? focusNode;
  final String? errorText;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final int? maxLines;
  final bool enabled;

  ///内容边距
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? fieldCallBack;
  const FNUIPasswordInputWidget({
    super.key,
    required this.hintText,
    this.maxLines,
    this.fieldCallBack,
    this.focusNode,
    this.errorText,
    this.controller,
    this.passwordInputController,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.prefix,
    this.contentPadding = const EdgeInsets.only(bottom: 16),
  });

  @override
  State<FNUIPasswordInputWidget> createState() =>
      _FNUIPasswordInputWidgetState();
}

class _FNUIPasswordInputWidgetState extends State<FNUIPasswordInputWidget> {
  BorderSide get defaultBorderSide =>
      const BorderSide(color: FNColors.splitLineColor);

  late FNUIPasswordInputController realPasswordInputController;

  @override
  void initState() {
    realPasswordInputController =
        widget.passwordInputController ?? FNUIPasswordInputController();
    super.initState();
  }

  Widget _buildSuffixIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            realPasswordInputController.obscureText =
                !realPasswordInputController.obscureText;
          },
          child: Image.asset(
            realPasswordInputController.obscureText
                ? FNImagePath.openEyeIcon
                : FNImagePath.closeEyeIcon,
            width: 24.0,
            height: 24.0,
            package: LibRes.PLUGIN_NAME,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: realPasswordInputController,
        builder: (context, _) {
          return FNUITextField(
            keyboardType: widget.keyboardType ?? BaseKeyBoardType.password,
            controller: widget.controller,
            focusNode: widget.focusNode,
            hintText: widget.hintText ?? '',
            fieldCallBack: widget.fieldCallBack ?? (value) {},
            errorText: widget.errorText,
            errorBorder: UnderlineInputBorder(
                borderSide: defaultBorderSide.copyWith(
                    color: FNColors.textWarningColor)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: defaultBorderSide.copyWith(
                    color: FNColors.textWarningColor)),
            errorStyle: const TextStyle(
              color: FNColors.textWarningColor,
              fontSize: FNFontSize12,
              height: 1.5,
            ),
            cursorColor: FNColors.blank,
            enabledBorder: UnderlineInputBorder(borderSide: defaultBorderSide),
            inputBorder: UnderlineInputBorder(borderSide: defaultBorderSide),
            focusedBorder: UnderlineInputBorder(borderSide: defaultBorderSide),
            contentPadding: widget.contentPadding ?? EdgeInsets.zero,
            disabledBorder: UnderlineInputBorder(borderSide: defaultBorderSide),
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ?? _buildSuffixIcon(),
            suffixIconConstraints: const BoxConstraints(maxHeight: 40),
            obscureText: !realPasswordInputController.obscureText,
            // maxLines: maxLines,
            textStyle: const TextStyle(
                fontSize: FNFontSize16, color: FNColors.textColor),
            hintStyle: const TextStyle(fontSize: FNFontSize16),
            autoHeight: false,
            enabled: widget.enabled,
          );
        });
  }
}
