import 'package:flutter/material.dart';

import '../basic/image/image.dart';
import '../basic/text/normal.dart';

class FNUITable extends StatefulWidget {
  /// 数据列表
  final List<dynamic> dataList;

  /// 数据组头名称
  final List<String> dataHeaderList;

  /// 点击回调
  final Function(int index)? callBack;

  const FNUITable(
      {Key? key,
      required this.dataList,
      required this.dataHeaderList,
      this.callBack})
      : super(key: key);

  @override
  FNUITableState createState() => FNUITableState();
}

class FNUITableState extends State<FNUITable> {
  @override
  Widget build(BuildContext context) {
    List<DataRow> dataRows = [];

    for (int i = 0; i < widget.dataList.length; i++) {
      dataRows.add(DataRow(
          cells: [
            DataCell(Text("$i")),
            DataCell(
              Row(
                children: [
                  FNUIImage(
                    widget.dataList[i].logo ?? "",
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                  FNUIText(
                    margin: const EdgeInsets.only(left: 4),
                    width: 100,
                    autoSize: false,
                    maxLines: 1,
                    text: widget.dataList[i].nameAbbreviation,
                  ),
                ],
              ),
            ),
            DataCell(FNUIText(
              alignment: Alignment.center,
              text: widget.dataList[i].age,
            )),
            DataCell(FNUIText(
              alignment: Alignment.center,
              text: widget.dataList[i].superviseCountry,
              maxLength: 3,
              maxLines: 1,
            )),
            DataCell(FNUIText(
              alignment: Alignment.center,
              text: widget.dataList[i].score.toString(),
              textAlign: TextAlign.center,
              fontFamilyType: FontFamilyType.numBold,
            )),
          ],
          onSelectChanged: (isSelected) {
            widget.callBack!(i);
          }));
    }

    List<DataColumn> dataCloumns = [];

    for (int i = 0; i < widget.dataHeaderList.length; i++) {
      dataCloumns.add(
        DataColumn(
            label: Text(
          widget.dataHeaderList[i],
          textAlign: TextAlign.center,
        )),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: dataCloumns,
          rows: dataRows,
          showCheckboxColumn: false,
          dividerThickness: 0.01,
        ),
      ),
    );
  }
}
