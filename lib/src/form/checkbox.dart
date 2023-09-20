import 'package:flutter/material.dart';
import '../../res/lib_res.dart';
import '../constant/colors.dart';
import '../theme/index.dart';

///单选框 or 复选框类型
enum FNUICheckBoxType {
  ///单选
  single,

  ///复选
  multi
}

///单选框 or 复选框样式
enum FNUICheckBoxStyle {
  ///选项样式，选中时为" ✔ "
  action,

  ///列表项样式，带标题，箭头，选中时为 “ ◉ ”
  cell
}

/*
 * @description: 表单组件-单选or 复选
 * 传入的泛型需要重写toString(),列表展示时采用toString()来展示
 * @author: Yman Chen
 * @time: 2023/5/29 10:23
 */
class FNUICheckBox extends StatefulWidget {
  ///单选 or 复选
  final FNUICheckBoxType? checkBoxType;

  ///checkBox样式
  final FNUICheckBoxStyle? checkBoxStyle;

  ///选项
  final List<String> actions;

  ///每一项的内边距
  final EdgeInsets? padding;

  ///文字颜色
  final Color? textColor;

  ///选中回调
  final Function(List<int> indexs)? selectCallback;

  const FNUICheckBox(
      {Key? key,
      required this.actions,
      this.textColor,
      this.padding,
      this.checkBoxType = FNUICheckBoxType.single,
      this.checkBoxStyle,
      this.selectCallback})
      : super(key: key);

  @override
  State<FNUICheckBox> createState() => _FNUICheckBoxState();
}

class _FNUICheckBoxState extends State<FNUICheckBox> {
  ///右箭头
  final String _iconUnChecked = 'lib/assets/images/icon_checkbox_unchecked.png';

  ///右箭头
  final String _iconChecked = 'lib/assets/images/icon_checkbox_checked.png';

  ///右箭头
  final String _iconCheckedCircle =
      'lib/assets/images/icon_checkbox_checked_circle.png';

  ///右箭头
  final String _iconCheckedSelected =
      'lib/assets/images/icon_checkbox_checked_selected.png';

  ///右箭头
  final String _iconForward = 'lib/assets/images/icon_arrow_forward.png';

  ///选中的选项
  final Set<int> _indexSelected = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FNColors.card,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  if (widget.checkBoxType == FNUICheckBoxType.single) {
                    ///单选
                    _indexSelected.clear();
                    _indexSelected.add(index);
                  } else {
                    ///多选
                    if (_indexSelected.contains(index)) {
                      _indexSelected.remove(index);
                    } else {
                      _indexSelected.add(index);
                    }
                  }
                  widget.selectCallback?.call(_indexSelected.toList());
                });
              },
              child: Padding(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: _buildRow(index),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: widget.padding?.left ?? 16,
                  right: widget.padding?.right ?? 16),
              child: Divider(
                height: 0.5,
                color: FNThemeManager
                        .instance.themeData.otherConfig?.splitter_bg ??
                    const Color(0xffeaeaea),
              ),
            );
          },
          itemCount: widget.actions.length),
    );
  }

  /*
   * @description: 构建选项行
   * @param
   * @return
   * @author: Yman Chen
   * @time: 2023/5/29 12:19
   */
  Row _buildRow(int index) {
    if (widget.checkBoxStyle == FNUICheckBoxStyle.action) {
      return Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              widget.actions[index].toString(),
              style: TextStyle(
                  color: widget.textColor ??
                      (FNThemeManager.instance.theme == FNThemeType.light
                          ? FNColors.mainColor
                          : FNColors.fontMain),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          SizedBox(
            width: 24,
            child: Visibility(
                visible: _indexSelected.contains(index),
                child: Image.asset(
                  _iconCheckedSelected,
                  width: 24,
                  height: 24,
                  package: LibRes.PLUGIN_NAME,
                )),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset(
            _indexSelected.contains(index)
                ? widget.checkBoxType == FNUICheckBoxType.single
                    ? _iconCheckedCircle
                    : _iconChecked
                : _iconUnChecked,
            width: 24,
            height: 24,
            package: LibRes.PLUGIN_NAME,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.actions[index].toString(),
              style: TextStyle(
                  color: widget.textColor ?? FNColors.fontMain,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          Image.asset(
            _iconForward,
            width: 24,
            height: 24,
            package: LibRes.PLUGIN_NAME,
          ),
        ],
      );
    }
  }
}
