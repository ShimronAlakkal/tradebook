import 'package:flutter/material.dart';

class PositionSizer extends StatefulWidget {
  final int index;
  const PositionSizer({@required this.index});

  @override
  _PositionSizerState createState() =>
      _PositionSizerState(pageIndex: this.index);
}

class _PositionSizerState extends State<PositionSizer> {
  _PositionSizerState({this.pageIndex});
  int pageIndex;
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Widget body(int index) {
    if (index == 0) {
      // PS for stock body
    } else if (index == 1) {
      // PS for forex
    } else {
      // PS for futures
    }
  }
}
