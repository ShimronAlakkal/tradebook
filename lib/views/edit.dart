import 'dart:ui';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    setState(() {
      _helper = Tdbase.instance;
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
                return const Transactions();
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
                    title: Text(
                      transacts[index]['type'] == 1 ? 'Deposit' : 'Withdrew',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: transacts[index]['type'] == 1
                            ? Colors.green.shade400
                            : Colors.red.shade400,
                      ),
                    ),
                    subtitle: Text('${transacts[index]['date']}'),
                    trailing: Text('${transacts[index]['amount']}'),
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
    setState(() {
      transacts = x;
    });
  }
}
