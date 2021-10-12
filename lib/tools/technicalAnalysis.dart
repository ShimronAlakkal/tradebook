import 'package:flutter/material.dart';

class TechnicalAnalysis extends StatefulWidget {
  final int index;
  TechnicalAnalysis({@required this.index});

  @override
  _TechnicalAnalysisState createState() =>
      _TechnicalAnalysisState(index: this.index);
}

class _TechnicalAnalysisState extends State<TechnicalAnalysis> {
  _TechnicalAnalysisState({this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
