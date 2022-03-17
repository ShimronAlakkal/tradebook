// ignore_for_file: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:fraction/model/transaction_database.dart';

// ignore: must_be_immutable
class Transactions extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  Transactions({this.accountBalance});
  double accountBalance;

  @override
  _TransactionsState createState() =>
      _TransactionsState(accountBalance: accountBalance);
}

class _TransactionsState extends State<Transactions> {
  _TransactionsState({this.accountBalance});

  TextEditingController amountController = TextEditingController();
  DateTime _date;
  // [deposit , withdraw]
  List<bool> dwButtons = [true, false];
  bool isAdLoaded = false;
  Tdbase _helper;
  double accountBalance;
  @override
  void initState() {
    super.initState();

    setState(() {
      _helper = Tdbase.instance;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Transaction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The ads unit

                // The text saying transaction details
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // The amount field
                TextField(
                  maxLength: 12,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  showCursor: false,
                  cursorWidth: 3,
                  decoration: InputDecoration(
                    hintText: ' Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  maxLines: 1,
                ),

                // Date field
                ListTile(
                  title: Text(
                    _date == null
                        ? 'Date'
                        : 'Selected date : ${_date.year} - ${_date.month} - ${_date.day}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(_date == null
                      ? 'The date on which you tool this trade'
                      : 'Long press to reset date'),
                  leading: const Icon(Icons.calendar_today_outlined),
                  onTap: () {
                    _dateSetUp(context);
                  },
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Resetting date'),
                      ),
                    );
                    setState(() {
                      _date = null;
                    });
                  },
                ),

                // The text saying transaction
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 30, bottom: 10),
                  child: Text(
                    'Transaction type ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // The deposit or withdrawal
                ToggleButtons(
                  onPressed: (index) {
                    setState(() {
                      if (index == 0) {
                        dwButtons[0] = true;
                        dwButtons[1] = false;
                      } else {
                        dwButtons[1] = true;
                        dwButtons[0] = false;
                      }
                    });
                  },
                  fillColor: dwButtons[0] == true ? Colors.green : Colors.red,
                  disabledColor: Colors.grey,
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  borderWidth: 3,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      child: Text(
                        'Deposit',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      child: Text(
                        'withdraw',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4),
                      ),
                    )
                  ],
                  isSelected: dwButtons,
                ),

                // The add to db button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0 ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _validateAndAddToDatabase(context);
                      },
                      child: Text(
                        dwButtons[0] ? 'make deposit' : 'make withdrawal',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _validateAndAddToDatabase(context) async {
    if (amountController.text.isNotEmpty && _date != null) {
      if (dwButtons[1] &&
          accountBalance < double.parse(amountController.text)) {
        _showMsg('Cannot withdraw more than $accountBalance');
      } else {
        await _helper.insertTransaction(
          {
            Tdbase.amount: double.parse(
                double.parse(amountController.text).toStringAsFixed(2)),
            Tdbase.date: '${_date.year}/${_date.month}/${_date.day}',
            Tdbase.type: dwButtons[0] == true ? 1 : 0
          },
        );
        Navigator.pop(context, true);
      }
    } else if (amountController.text.isEmpty) {
      _showMsg('Please add an amount');
    } else {
      _showMsg('Pick a date');
    }
  }

  _dateSetUp(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
    );

    setState(() {
      _date = pickedDate;
    });
  }

  _showMsg(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(msg),
    ));
  }
}
