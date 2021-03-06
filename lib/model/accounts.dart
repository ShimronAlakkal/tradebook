import 'package:flutter/cupertino.dart';
import 'database.dart';
import 'transaction_database.dart';

class Accounts extends ChangeNotifier {
  Dbase _helper;
  Tdbase _thelper;

  List<Map<String, dynamic>> trades = [];
  List<Map<String, dynamic>> transactions = [];

  Accounts() {
    _helper = Dbase.instance;
    _thelper = Tdbase.instance;
  }

  double accountBalance = 0.0;
  double totalInvestments = 0.0;

  getTotalInvestment() async {
    trades = await _helper.fetchTrades();
    trades.map((i) {
      i['buyorsell'] == 1
          ? totalInvestments = totalInvestments + i['entry'] * i['qty']
          : totalInvestments = totalInvestments + 0;
    });
  }

  getAccountBalance() async {
    transactions = await _thelper.fetchTransactions();

    transactions.map((i) {
      i['type'] == 1
          ? accountBalance = accountBalance + i['amount']
          : accountBalance = accountBalance - i['amount'];
    });
  }
}
