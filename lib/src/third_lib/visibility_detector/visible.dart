import 'package:flutter/material.dart';

import 'src/visibility_detector.dart';

class WidgetVisibilityDetector extends StatefulWidget {
  const WidgetVisibilityDetector({
    Key? key,
    required this.child,
    this.onAppear,
    this.onDisappear,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onAppear;
  final VoidCallback? onDisappear;

  @override
  State<WidgetVisibilityDetector> createState() =>
      _WidgetVisibilityDetectorState();
}

class _WidgetVisibilityDetectorState extends State<WidgetVisibilityDetector>
    with WidgetsBindingObserver {
  final _key = UniqueKey();
  VisibilityInfo? _info;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (_isShowing()) {
        widget.onDisappear?.call();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isShowing()) {
        widget.onAppear?.call();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  bool _isShowing() {
    return (_info?.visibleFraction ?? 0) == 1;
  }

  void _handleVisibilityInfoChanged(VisibilityInfo info) {
    _info = info;

    if (info.visibleFraction == 1) {
      widget.onAppear?.call();
      return;
    }
    if (info.visibleFraction == 0) {
      widget.onDisappear?.call();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: _handleVisibilityInfoChanged,
      child: widget.child,
    );
  }
}
