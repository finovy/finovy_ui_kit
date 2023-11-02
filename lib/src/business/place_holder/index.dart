import 'package:flutter/material.dart';
import 'package:fn_ui_kit/fn_ui_kit.dart';

import '../../../res/lib_res.dart';

/// 页面状态
enum EmptyWidgetState {
  /// 空数据
  nodata,

  /// 服务器异常
  serverError,

  /// 内容不存在
  noContent,

  /// 搜索无结果
  noSearchResult,

  /// 网络异常
  networkConnectError,

  ///  加载失败
  loadError,

  /// 暂无网络
  noNetwork,

  /// 自定义
  custom,
}

/// 空白页图片路径
class EmptyPlaceHolderImage {
  static String loadFailImagePath =
      'lib/assets/images/icon_status_loadfail.png';
  static String networkErrorImagePath =
      'lib/assets/images/icon_status_networkerror.png';
  static String noDataImagePath = 'lib/assets/images/icon_status_nodata.png';
  static String noExistImagePath = 'lib/assets/images/icon_status_noexist.png';
  static String noNetworkImagePath =
      'lib/assets/images/icon_status_nonetwork.png';
  static String searchNullImagePath =
      'lib/assets/images/icon_status_searchnull.png';
  static String serverErrorImagePath =
      'lib/assets/images/icon_status_servererror.png';
  static String systemImagePath = 'lib/assets/images/icon_status_system.png';
}

/// 调整内容位置的配置类
class EmptyWidgetContentPosition {
  final double? top, bottom, left, right;

  EmptyWidgetContentPosition({this.top, this.bottom, this.left, this.right});
}

/*
* @description: 空白占位组件
* @param:
* @return:
* @author: Ethan Zhu
* @time: 2023-07-25 14:08:47 星期二
*/
class FNUIEmptyWidget extends StatelessWidget {
  /// 状态
  final EmptyWidgetState state;

  /// 自定义空白占位图片路径，需要和EmptyWidgetState.custom配合使用
  final String? customImagePath;

  /// 自定义图片属于的包路径，不填默认该包
  final String? package;

  /// 占位图片大小
  final Size imgSize;

  /// 占位图到标题的距离
  final double imageTitleSpacing;

  /// 标题到操作区的距离
  final double titleOptionAreaSpacing;

  /// 标题内容
  final String title;

  /// 按下按钮的反馈，不写该方法不会出现按钮组件
  final VoidCallback? onTapButton;

  /// 按钮的文字
  final String? buttonTitle;

  /// 内容在屏幕的位置
  final EmptyWidgetContentPosition? position;

  /// 按钮的padding
  final EdgeInsetsGeometry? buttonPadding;

  /// 按钮背景颜色
  final Color? buttonBackgroundColor;

  /// 按钮边框弧度
  final double? buttonRadius;

  /// 按钮尺寸
  final Size? buttonSize;

  /// 按钮文字样式
  final TextStyle? buttonTextStyle;

  /// 自定义占位组件（优先级高于预设）
  final Widget? placeHolderWidget;

  /// 自定义title组件（优先级高于预设）
  final Widget? titleWidget;

  /// 自定义操作区（优先级高于预设）
  final Widget? optionWidget;
  const FNUIEmptyWidget({
    super.key,
    required this.state,
    required this.title,
    this.imgSize = const Size(120, 120),
    this.customImagePath,
    this.package,
    this.imageTitleSpacing = 16,
    this.titleOptionAreaSpacing = 24,
    this.onTapButton,
    this.buttonTitle,
    this.position,
    this.buttonPadding,
    this.buttonBackgroundColor,
    this.buttonRadius,
    this.buttonSize,
    this.buttonTextStyle,
    this.placeHolderWidget,
    this.titleWidget,
    this.optionWidget,
  });

  /// 默认字体样式
  TextStyle get defaultTitleStyle => const TextStyle(
        fontFamily: 'PingFangSC',
        fontSize: 14,
        color: FNColors.textSecondaryColor,
      );

  /// 根据状态获取图片路径
  String get imagePath {
    switch (state) {
      case EmptyWidgetState.nodata:
        return EmptyPlaceHolderImage.noDataImagePath;
      case EmptyWidgetState.serverError:
        return EmptyPlaceHolderImage.serverErrorImagePath;
      case EmptyWidgetState.noContent:
        return EmptyPlaceHolderImage.noExistImagePath;
      case EmptyWidgetState.noSearchResult:
        return EmptyPlaceHolderImage.searchNullImagePath;
      case EmptyWidgetState.networkConnectError:
        return EmptyPlaceHolderImage.networkErrorImagePath;
      case EmptyWidgetState.loadError:
        return EmptyPlaceHolderImage.loadFailImagePath;
      case EmptyWidgetState.noNetwork:
        return EmptyPlaceHolderImage.noNetworkImagePath;
      case EmptyWidgetState.custom:
        return customImagePath ?? EmptyPlaceHolderImage.noDataImagePath;
    }
  }

  /// 构建占位图
  Widget _buildPlaceHolderImage() {
    return placeHolderWidget ??
        Image.asset(
          imagePath,
          package: state != EmptyWidgetState.custom
              ? LibRes.PLUGIN_NAME
              : package ?? LibRes.PLUGIN_NAME,
          width: imgSize.width,
          height: imgSize.height,
        );
  }

  /// 构建标题
  Widget _buildTitle() {
    return titleWidget ??
        Text(
          title,
          style: defaultTitleStyle,
        );
  }

  /// 内容的容器组件
  Widget contentWrapper(List<Widget> children) {
    if (position == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: children,
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 从InheritedWidget获取配置
    FNEmptyThemeData config = FNEmptyTheme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: position?.left,
          right: position?.right,
          top: position?.top,
          bottom: position?.bottom,
          child: contentWrapper([
            _buildPlaceHolderImage(),
            SizedBox(
              height: imageTitleSpacing,
            ),
            _buildTitle(),
            if (optionWidget != null) ...[
              SizedBox(
                height: titleOptionAreaSpacing,
              ),
              optionWidget!
            ],
            if (optionWidget == null && onTapButton != null) ...[
              SizedBox(
                height: titleOptionAreaSpacing,
              ),
              _EmptyOperationButton(
                cb: onTapButton,
                title: buttonTitle,
                textStyle: defaultTitleStyle.copyWith(color: Colors.white),
              )
            ]
          ]),
        ),
      ],
    );
  }
}

/*
* @description: 预设的操作区按钮组件
* @param:
* @return:
* @author: Ethan Zhu
* @time: 2023-07-25 14:14:38 星期二
*/
class _EmptyOperationButton extends StatelessWidget {
  /// 按钮标题
  final String? title;

  /// 按钮回调
  final VoidCallback? cb;

  /// 按钮文字样式
  final TextStyle? textStyle;
  const _EmptyOperationButton({
    Key? key,
    this.title,
    this.cb,
    this.textStyle,
  }) : super(key: key);

  /// 按钮的背景颜色
  MaterialStateProperty<Color?>? _getButtonBgColor(FNEmptyThemeData? config) {
    Color buttonColor = config?.buttonBackgroundColor ?? FNColors.primary;
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return buttonColor.withOpacity(0.8);
      }
      return buttonColor;
    });
  }

  /// 按钮样式配置
  ButtonStyle buttonStyle(FNEmptyThemeData config) {
    return ButtonStyle(
      backgroundColor: _getButtonBgColor(config),
      padding: MaterialStatePropertyAll(
        config.buttonPadding ??
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(config.btnRadius),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FNEmptyThemeData config = FNEmptyTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: config.buttonSize.width,
          height: config.buttonSize.height,
          child: TextButton(
            onPressed: cb,
            style: buttonStyle(config),
            child: Text(
              title ?? '',
              style: config.buttonTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

// /*
// * @description: 对EmptyWidget扩展的配置
// * @param:
// * @return:
// * @author: Ethan Zhu
// * @time: 2023-07-25 14:16:11 星期二
// */
// /// 使用方式：
// /// SMUIEmptyWidgetConfigure(
// ///   buttonSize: Size(200, 100),
// ///   child: SMUIEmptyWidget(..)
// /// )
// class FNUIEmptyWidgetConfigure extends InheritedWidget {
//   /// 按钮的padding
//   final EdgeInsetsGeometry? buttonPadding;
//
//   /// 按钮背景颜色
//   final Color? buttonBackgroundColor;
//
//   /// 按钮边框弧度
//   final double? buttonRadius;
//
//   /// 按钮尺寸
//   final Size? buttonSize;
//
//   /// 按钮文字样式
//   final TextStyle? buttonTextStyle;
//
//   /// 自定义占位组件（优先级高于预设）
//   final Widget? placeHolderWidget;
//
//   /// 自定义title组件（优先级高于预设）
//   final Widget? titleWidget;
//
//   /// 自定义操作区（优先级高于预设）
//   final Widget? optionWidget;
//
//   const FNUIEmptyWidgetConfigure({
//     required super.child,
//     super.key,
//     this.buttonPadding,
//     this.buttonBackgroundColor,
//     this.buttonRadius,
//     this.buttonSize,
//     this.buttonTextStyle,
//     this.placeHolderWidget,
//     this.titleWidget,
//     this.optionWidget,
//   });
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
//
//   static FNUIEmptyWidgetConfigure? of(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<FNUIEmptyWidgetConfigure>();
//   }
// }
