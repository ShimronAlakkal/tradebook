import 'package:flutter/material.dart';

class Formatter {
  String symbol;
  double enterPrice;
  String position;
  DateTime dateEntered;
  double qty;
  double target;
  DateTime exitDate;
  double currentDayEndPrice;
  double exitPrice;

  Formatter({
    @required this.symbol,
    @required this.enterPrice,
    @required this.qty,
    @required this.position,
    this.dateEntered,
    this.exitDate,
    this.exitPrice,
    this.target,
    this.currentDayEndPrice,
  });

  toMap() {
    return {
      'symbol': symbol,
      'Enter': enterPrice,
      'dateOfEntering': dateEntered,
      'position': position,
      'Qty': qty,
      'targetPrice': target,
      'ExitDate': exitDate,
      'DayEndPrice': currentDayEndPrice,
      'exit': exitPrice
    };
  }
}
