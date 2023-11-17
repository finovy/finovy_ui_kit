part of toast;

/*
* @description: Toast管理器，采用队列的方式进行管理
* @param: 
* @return: 
* @author: Ethan Zhu
* @time: 2023-11-13 11:55:52 星期一
*/
class _ToastManager {
  /// 单例
  _ToastManager._();
  static final _ToastManager _instance = _ToastManager._();
  static _ToastManager get instance => _instance;

  /// overlayEntry队列，全局只能有一个entry
  Queue<OverlayEntry> entries = Queue();

  /// toast自动消失的timer
  Timer? _timer;

  /// 防抖的timer
  Timer? _delay;

  /// 创建toast，加入防抖
  void create({
    required OverlayEntry overlayEntry,
    Duration? duration,
    required BuildContext context,
  }) {
    _nextTick(
      () => _toast(
        overlayEntry: overlayEntry,
        context: context,
        duration: duration,
      ),
    );
  }

  /// solve setState() or markNeedsBuild() called during build error
  void _nextTick(VoidCallback fn, {Duration duration = Duration.zero}) {
    if (_delay?.isActive ?? false) {
      _delay?.cancel();
      _delay = null;
    }
    _delay ??= Timer(duration, () {
      fn();
      _delay?.cancel();
      _delay = null;
    });
  }

  /// 真正创建toast的地方
  void _toast({
    required OverlayEntry overlayEntry,
    required BuildContext context,
    Duration? duration,
  }) {
    final OverlayState overlayState = Overlay.of(context);
    while (entries.isNotEmpty) {
      dismiss();
    }
    entries.addFirst(overlayEntry);
    overlayState.insert(overlayEntry);
    if (duration != null) {
      _timer ??= Timer(duration, () {
        dismiss();
      });
    }
  }

  /// 取消toast
  void dismiss() {
    _delay?.cancel();
    _delay = null;
    _timer?.cancel();
    _timer = null;
    if (entries.isEmpty) return;
    OverlayEntry entry = entries.removeFirst();
    entry.remove();
  }
}
