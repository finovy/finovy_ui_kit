import 'package:flutter/material.dart';

//////////////////////////// 直线进度条 ////////////////////////////

class FNUILinearProgress extends StatefulWidget {
  /// 百分比 0-1之间
  final double percent;

  /// 宽度
  final double? width;

  /// 高度
  final double lineHeight;

  /// 填充颜色 默认是透明transparent
  final Color fillColor;

  /// 背景色
  // Color get backgroundColor => _backgroundColor;
  // late Color _backgroundColor;
  final Color backgroundColor;

  /// 进度条||背景色渐变色
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final bool clipLinearGradient;

  /// 进度条颜色
  // Color get progressColor => _progressColor;
  // late Color _progressColor;
  final Color progressColor;

  /// 数值变化是否开启动画
  final bool animation;

  /// 动画时间
  final int animationDuration;

  /// 动画类型
  final Curve curve;

  /// 左侧Widget
  final Widget? leading;

  /// 右侧Widget
  final Widget? trailing;

  /// 中间Widget
  final Widget? center;

  /// 当动画开启时，数值变化 indicator widget
  final Widget? widgetIndicator;

  /// 圆角
  final Radius? barRadius;

  /// 对齐方式
  final MainAxisAlignment alignment;

  /// 外边距
  final EdgeInsets padding;

  /// 数值变化动画
  final bool animateFromLastPercent;

  /// 是否开启重置动画
  final bool restartAnimation;

  /// keep alive
  final bool addAutomaticKeepAlive;

  ///
  final bool isRTL;

  ///
  final MaskFilter? maskFilter;

  /// 动画结束时间回调
  final VoidCallback? onAnimationEnd;

  FNUILinearProgress({
    Key? key,
    this.fillColor = Colors.transparent,
    this.percent = 0.0,
    this.lineHeight = 5.0,
    this.width,
    this.backgroundColor = const Color(0xFFB8C7CB),
    this.linearGradientBackgroundColor,
    this.linearGradient,
    this.progressColor = Colors.red,
    this.animation = false,
    this.animationDuration = 500,
    this.animateFromLastPercent = false,
    this.isRTL = false,
    this.leading,
    this.trailing,
    this.center,
    this.addAutomaticKeepAlive = true,
    // this.linearStrokeCap,
    this.barRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.maskFilter,
    this.clipLinearGradient = false,
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
  }) : super(key: key) {
    if (linearGradient != null) {
      throw ArgumentError(
          'Cannot provide both linearGradient and progressColor');
    }

    if (linearGradientBackgroundColor != null) {
      throw ArgumentError(
          'Cannot provide both linearGradientBackgroundColor and backgroundColor');
    }

    if (percent < 0.0 || percent > 1.0) {
      throw Exception(
          "Percent value must be a double between 0.0 and 1.0, but it's $percent");
    }
  }

  @override
  FNUILinearProgressState createState() => FNUILinearProgressState();
}

class FNUILinearProgressState extends State<FNUILinearProgress>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation? _animation;
  double _percent = 0.0;
  final _containerKey = GlobalKey();
  final _keyIndicator = GlobalKey();
  double _containerWidth = 0.0;
  double _containerHeight = 0.0;
  double _indicatorWidth = 0.0;
  double _indicatorHeight = 0.0;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _containerWidth = _containerKey.currentContext?.size?.width ?? 0.0;
          _containerHeight = _containerKey.currentContext?.size?.height ?? 0.0;
          if (_keyIndicator.currentContext != null) {
            _indicatorWidth = _keyIndicator.currentContext?.size?.width ?? 0.0;
            _indicatorHeight =
                _keyIndicator.currentContext?.size?.height ?? 0.0;
          }
        });
      }
    });
    if (widget.animation) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.animationDuration));
      _animation = Tween(begin: 0.0, end: widget.percent).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
          setState(() {
            _percent = _animation!.value;
          });
          if (widget.restartAnimation && _percent == 1.0) {
            _animationController!.repeat(min: 0, max: 1.0);
          }
        });
      _animationController!.addStatusListener((status) {
        if (widget.onAnimationEnd != null &&
            status == AnimationStatus.completed) {
          widget.onAnimationEnd!();
        }
      });
      _animationController!.forward();
    } else {
      _updateProgress();
    }
    super.initState();
  }

  void _checkIfNeedCancelAnimation(FNUILinearProgress oldWidget) {
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  void didUpdateWidget(FNUILinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(
                begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
                end: widget.percent)
            .animate(
          CurvedAnimation(parent: _animationController!, curve: widget.curve),
        );
        _animationController!.forward(from: 0.0);
      } else {
        _updateProgress();
      }
    }
    _checkIfNeedCancelAnimation(oldWidget);
  }

  _updateProgress() {
    setState(() {
      _percent = widget.percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>.empty(growable: true);
    if (widget.leading != null) {
      items.add(widget.leading!);
    }
    final hasSetWidth = widget.width != null;
    final percentPositionedHorizontal =
        _containerWidth * _percent - _indicatorWidth / 3;
    var containerWidget = Container(
      width: hasSetWidth ? widget.width : double.infinity,
      height: widget.lineHeight,
      padding: widget.padding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            key: _containerKey,
            painter: _LinearPainter(
              isRTL: widget.isRTL,
              progress: _percent,
              progressColor: widget.progressColor,
              linearGradient: widget.linearGradient,
              backgroundColor: widget.backgroundColor,
              barRadius: widget.barRadius ??
                  Radius.zero, // If radius is not defined, set it to zero
              linearGradientBackgroundColor:
                  widget.linearGradientBackgroundColor,
              maskFilter: widget.maskFilter,
              clipLinearGradient: widget.clipLinearGradient,
            ),
            child: (widget.center != null)
                ? Center(child: widget.center)
                : Container(),
          ),
          if (widget.widgetIndicator != null && _indicatorWidth == 0)
            Opacity(
              opacity: 0.0,
              key: _keyIndicator,
              child: widget.widgetIndicator,
            ),
          if (widget.widgetIndicator != null &&
              _containerWidth > 0 &&
              _indicatorWidth > 0)
            Positioned(
              right: widget.isRTL ? percentPositionedHorizontal : null,
              left: !widget.isRTL ? percentPositionedHorizontal : null,
              top: _containerHeight / 2 - _indicatorHeight,
              child: widget.widgetIndicator!,
            ),
        ],
      ),
    );

    if (hasSetWidth) {
      items.add(containerWidget);
    } else {
      items.add(Expanded(
        child: containerWidget,
      ));
    }
    if (widget.trailing != null) {
      items.add(widget.trailing!);
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        color: widget.fillColor,
        child: Row(
          mainAxisAlignment: widget.alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

class _LinearPainter extends CustomPainter {
  final Paint _paintBackground = new Paint();
  final Paint _paintLine = new Paint();
  final double progress;
  final bool isRTL;
  final Color progressColor;
  final Color backgroundColor;
  final Radius barRadius;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final MaskFilter? maskFilter;
  final bool clipLinearGradient;

  _LinearPainter({
    required this.progress,
    required this.isRTL,
    required this.progressColor,
    required this.backgroundColor,
    required this.barRadius,
    this.linearGradient,
    this.maskFilter,
    required this.clipLinearGradient,
    this.linearGradientBackgroundColor,
  }) {
    _paintBackground.color = backgroundColor;

    _paintLine.color = progress.toString() == "0.0"
        ? progressColor.withOpacity(0.0)
        : progressColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background first
    Path backgroundPath = Path();
    backgroundPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), barRadius));
    canvas.drawPath(backgroundPath, _paintBackground);

    if (maskFilter != null) {
      _paintLine.maskFilter = maskFilter;
    }

    if (linearGradientBackgroundColor != null) {
      Offset shaderEndPoint =
          clipLinearGradient ? Offset.zero : Offset(size.width, size.height);
      _paintBackground.shader = linearGradientBackgroundColor
          ?.createShader(Rect.fromPoints(Offset.zero, shaderEndPoint));
    }

    // Then draw progress line
    final xProgress = size.width * progress;
    Path linePath = Path();
    if (isRTL) {
      if (linearGradient != null) {
        _paintLine.shader = _createGradientShaderRightToLeft(size, xProgress);
      }
      linePath.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(
              size.width - size.width * progress, 0, xProgress, size.height),
          barRadius));
    } else {
      if (linearGradient != null) {
        _paintLine.shader = _createGradientShaderLeftToRight(size, xProgress);
      }
      linePath.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, xProgress, size.height), barRadius));
    }
    canvas.drawPath(linePath, _paintLine);
  }

  Shader _createGradientShaderRightToLeft(Size size, double xProgress) {
    Offset shaderEndPoint =
        clipLinearGradient ? Offset.zero : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset(size.width, size.height),
        shaderEndPoint,
      ),
    );
  }

  Shader _createGradientShaderLeftToRight(Size size, double xProgress) {
    Offset shaderEndPoint = clipLinearGradient
        ? Offset(size.width, size.height)
        : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset.zero,
        shaderEndPoint,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
