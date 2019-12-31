import 'package:flutter/material.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:provide/provide.dart';

class SaleDataTable extends StatefulWidget {
  List list = [];

  SaleDataTable({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  _SaleDataTableState createState() => _SaleDataTableState();
}

class _SaleDataTableState extends State<SaleDataTable> {
  int _sortindex = 0;
  bool _sort = true;

  @override
  Widget build(BuildContext context) {
    var model = Provide.value<SearchProvide>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("航次${model.current_rcno}销售详情："),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: DataTable(
                sortColumnIndex: _sortindex,
                sortAscending: _sort,
                columns: [
                  DataColumn(
                    label: Text("销售点"),
                    onSort: (index, s) {

                      setState(() {
                        _sortindex = index;
                        _sort = s;
                        if (!_sort) {
                          widget.list.sort((a, b) {
                            return a['placename'].toString().length
                                .compareTo(b['placename'].toString().length);
                          });
                        }
                        else
                          {
                            widget.list.sort((a, b) {
                              return b['placename'].toString().length
                                  .compareTo(a['placename'].toString().length);
                            });
                          }
                      });

                    },
                  ),
                  DataColumn(
                    label: Text("类别"),
                  ),
                  DataColumn(
                    label: Text("金额"),
                    onSort: (index, s) {
                      setState(() {
                        _sortindex = index;
                        _sort = s;
                        print(_sort);
                        if (!_sort) {
                          widget.list.sort((a, b) {
                            return double.parse(a['je'].toString())
                                .compareTo(double.parse(b['je'].toString()));
                          });
                        }
                        else
                          {
                            widget.list.sort((a, b) {
                              return double.parse(b['je'].toString())
                                  .compareTo(double.parse(a['je'].toString()));
                            });
                          }
                      });
                    },
                    numeric: true,
                  ),
                ],
                rows: widget.list.map((item) {
                  return DataRow(
                    onSelectChanged: (v){
                      print(v);
                    },
                      selected: true,
                      cells: [
                    DataCell(Text(item['placename'].toString())),
                    DataCell(Text(item['typename'].toString())),
                    DataCell(Text(item['je'].toString())),
                  ]);
                }).toList()),
          ),
        ),
      ],
    );
  }
}
