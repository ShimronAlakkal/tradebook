import 'package:flutter/material.dart';
import 'package:pron/model/database.dart';
import 'package:pron/model/transaction_database.dart';
import 'package:pron/views/transactions.dart';

class Edit extends StatefulWidget {
  const Edit({Key key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  List<Map<String, dynamic>> transacts = [];
  Tdbase _helper;
  double ab;
  Dbase _dbaseHelper;
  @override
  void initState() {
    super.initState();
    setState(() {
      _helper = Tdbase.instance;
      _dbaseHelper = Dbase.instance;
    });

    _refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Deposit or Withdraw button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffAB9AFF),
        onPressed: () async {
          bool res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Transactions(accountBalance: ab);
              },
            ),
          );
          if (res) {
            _refreshTransactions();
          }
        },
        label: const Text(
          'deposit / withdraw',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),

      // ListView builder here
      body: transacts.isNotEmpty
          ? ListView.builder(
              itemCount: transacts.length,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    isThreeLine: false,
                    onLongPress: () {
                      // delete the item here
                      _deleteTransaction(index);
                    },
                    leading: transacts[index]['type'] == 1
                        ? Icon(
                            Icons.upload_rounded,
                            color: Colors.green.shade400,
                            size: 26,
                          )
                        : Icon(
                            Icons.download_rounded,
                            size: 26,
                            color: Colors.red.shade400,
                          ),
                    title: Text(
                      transacts[index]['type'] == 1 ? 'Deposit' : 'Withdrew',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text('${transacts[index]['date']}'),
                    trailing: Text(
                      kmbGenerator(transacts[index]['amount']),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('Add your first deposit to keep track of trading')),
    );
  }

  _refreshTransactions() async {
    List<Map<String, dynamic>> x = await _helper.fetchTransactions();
    double tdep = await _helper.getTotalDeposit();
    double twdrw = await _helper.getTotalWithdrawal();
    double ti = await _dbaseHelper.getTotalInvestment();
    ti == null ? ti = 0 : ti = ti;
    tdep == null ? tdep = 0 : tdep = tdep;
    twdrw == null ? twdrw = 0.0 : twdrw = twdrw;

    setState(() {
      transacts = x;
      ab = tdep - twdrw - ti;
    });
  }

  _deleteTransaction(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are you sure you want to delete this?'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),

              // The cancel button on alert dialog
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple.shade400)),
                onPressed: () {
                  _helper.deleteTransaction(transacts[index]['id']);
                  _refreshTransactions();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          );
        });
  }

  String kmbGenerator(amount) {
    if (amount > 999 && amount < 99999) {
      return "${(amount / 1000).toStringAsFixed(2)} K";
    } else if (amount > 99999 && amount < 999999) {
      return "${(amount / 1000).toStringAsFixed(2)} K";
    } else if (amount > 999999 && amount < 999999999) {
      return "${(amount / 1000000).toStringAsFixed(2)} M";
    } else if (amount > 999999999) {
      return "${(amount / 1000000000).toStringAsFixed(2)} B";
    } else {
      return amount.toString();
    }
  }
}
