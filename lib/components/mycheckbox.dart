import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  ValueChanged<bool> onchange;
  bool value = false;

  MyCheckbox({Key key, this.value = false, this.onchange}) : super(key: key);

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool _ischecked;
  @override
  Widget build(BuildContext context) {
    _ischecked = widget.value;
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            widget.onchange(!widget.value);
          },
          child: widget.value
              ? Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 14.0,
                    color: Colors.white,
                  ),
                )
              : Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
