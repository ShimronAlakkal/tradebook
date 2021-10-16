// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pron/model/database.dart';

class TradeEntry extends StatefulWidget {
  TradeEntry();
  // {this.newTrade,
  // this.entry,
  // this.date,
  // this.positoin,
  // this.scrip,
  // this.qty,
  // this.sl,
  // this.type});

  bool newTrade;
  String scrip;
  String date;
  int type; // Buy or sell => 0 or 1
  int positoin; // Intraday or delivery or swing = > 0 or 1 or 2
  double entry;
  double sl;
  int qty;

  @override
  _TradeEntryState createState() => _TradeEntryState(
      // date: this.date,
      // sl: this.sl,
      // type: this.type,
      // scrip: this.scrip,
      // qty: this.qty,
      // positoin: this.positoin,
      // newTrade: this.newTrade,
      // entry: this.entry,
      );
}

class _TradeEntryState extends State<TradeEntry> {
  _TradeEntryState();
  // {this.newTrade,
  // this.entry,
  // this.date,
  // this.positoin,
  // this.scrip,
  // this.qty,
  // this.sl,
  // this.type});

// The fields that has to be here

  // bool newTrade;
  // String scrip;
  // String date;
  // int type; // Buy or sell => 0 or 1
  // int positoin; // Intraday or delivery or swing = > 0 or 1 or 2
  // double entry;
  // double sl;
  // int qty;

  TextEditingController scripController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController slController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  int step = 0;
  DateTime date;
  List<bool> isSelectedForBS = [true, false];
  List<bool> isSelectedForPosition = [true, false, false];

  @override
  void initState() {
    Dbase db;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      // body
      body: ListView(
        children: [
          // Ad Unit

          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.amber.shade500),
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width,
          ),

          // Main UI
          Theme(
            data: ThemeData(
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(primary: Colors.amber),
            ),
            child: Stepper(
              currentStep: step,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurple.shade400),
                        ),
                        onPressed: () {
                          // ignore: unnecessary_statements
                          details.onStepContinue();

                          //
                          //
                          // ************************************************   The main function that links the database to the UI goes here
                          //  the funcrion is likelt to be db.insert(a)
                          //
                          //
                        },
                        child: Text(
                          this.step == _getSteps(height, width).length - 1
                              ? '       SAVE       '
                              : '       Next       ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.cyan.shade50),
                      ),
                      onPressed: () {
                        details.onStepCancel();
                      },
                      child: Text(
                        this.step == _getSteps(height, width).length - 1
                            ? '       Edit       '
                            : '       Back       ',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                );
              },
              onStepTapped: (nstep) {
                setState(
                  () {
                    step = nstep;
                  },
                );
              },

              onStepCancel: step == 0
                  ? null
                  : () => setState(
                        () {
                          step--;
                        },
                      ),

              onStepContinue: () {
                if (this.step != _getSteps(height, width).length - 1) {
                  // The first page
                  if (this.step == 0) {
                    // IS the stock name input by the user?
                    if (scripController.text.isNotEmpty && this.date != null) {
                      setState(() {
                        step++;
                      });
                    } else if (scripController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Please complete the above field'),
                        ),
                      );
                    } else if (this.date == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Please set a date'),
                        ),
                      );
                    }

                    // The third page
                  } else if (this.step == 2) {
                    if (entryController.text.isNotEmpty &&
                        qtyController.text.isNotEmpty &&
                        slController.text.isNotEmpty) {
                      _logicOfEntrySL(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Please complete the above fields'),
                        ),
                      );
                    }
                  } else {
                    setState(() {
                      step++;
                    });
                  }
                }
              },

              // Steps
              steps: _getSteps(height, width),
            ),
          ),
        ],
      ),
    );
  }

// These are the widgets inside the main UI
  List<Step> _getSteps(double height, double width) {
    return [
      // The stocks and date
      Step(
        state: this.step > 0 ? StepState.complete : StepState.indexed,
        title: Text(
          'Stock and date',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: height * 0.25,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              TextFormField(
                controller: scripController,
                // ignore: missing_return
                textInputAction: TextInputAction.done,
                autofocus: false,
                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  labelText: 'Stock',
                  labelStyle: TextStyle(fontSize: 18),
                  hintText: ' Example : AAPL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                maxLength: 15,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(this.date == null
                    ? 'Date'
                    : 'Selected Date :  ${this.date.year} - ${this.date.month} - ${this.date.day}'),
                subtitle: Text(this.date == null
                    ? 'The date on which you tool this trade'
                    : 'Long press to reset date'),
                leading: Icon(Icons.calendar_today_outlined),
                onTap: () {
                  _dateSetUp(context);
                },
                onLongPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Resetting date'),
                    ),
                  );
                  setState(() {
                    this.date = null;
                  });
                },
              )
            ],
          ),
        ),
      ),

      // The positions tab
      Step(
        state: this.step > 1 ? StepState.complete : StepState.indexed,
        title: Text(
          'Position',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: height * 0.25,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Buys of sell
              Text(
                'Order type',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.4),
              ),
              SizedBox(
                height: 10,
              ),
              ToggleButtons(
                onPressed: (index) {
                  setState(() {
                    if (index == 0) {
                      isSelectedForBS[0] = true;
                      isSelectedForBS[1] = false;
                    } else {
                      isSelectedForBS[1] = true;
                      isSelectedForBS[0] = false;
                    }
                  });
                },
                fillColor:
                    isSelectedForBS[0] == true ? Colors.green : Colors.red,
                color: Colors.black,
                disabledColor: Colors.grey,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                borderWidth: 3,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      'Sell',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  )
                ],
                isSelected: isSelectedForBS,
              ),

              // Trade positon type

              ToggleButtons(
                disabledColor: Colors.grey,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                borderWidth: 3,
                fillColor: Colors.indigo.shade300,
                onPressed: (index) {
                  setState(() {
                    switch (index) {
                      case 0:
                        isSelectedForPosition[0] = true;
                        isSelectedForPosition[1] = false;
                        isSelectedForPosition[2] = false;
                        break;
                      case 1:
                        isSelectedForPosition[0] = false;
                        isSelectedForPosition[1] = true;
                        isSelectedForPosition[2] = false;
                        break;
                      case 2:
                        isSelectedForPosition[0] = false;
                        isSelectedForPosition[1] = false;
                        isSelectedForPosition[2] = true;
                    }
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: Text(
                      'Intraday',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: Text(
                      'Swing',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: Text(
                      'Delivery',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                ],
                isSelected: isSelectedForPosition,
              ),
            ],
          ),
        ),
      ),

      // The entry and stop loss
      Step(
        state: this.step > 2 ? StepState.complete : StepState.indexed,
        title: Text(
          'Entry details',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: height * 0.3,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              // The entry price
              TextFormField(
                controller: entryController,
                // ignore: missing_return
                textInputAction: TextInputAction.next,

                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Entry Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),

              // The stop loss field
              TextFormField(
                controller: slController,
                // ignore: missing_return
                textInputAction: TextInputAction.next,

                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Stop Loss',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                keyboardType: TextInputType.number,
              ),

              SizedBox(
                height: 20,
              ),

              // Qty Field
              TextFormField(
                controller: qtyController,
                // ignore: missing_return
                textInputAction: TextInputAction.done,

                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Quantity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),

      // The preview step
      Step(
        state: this.step > 3 ? StepState.complete : StepState.indexed,
        title: Text(
          'Preview',
          style: TextStyle(fontSize: 18),
        ),
        content: _makePreview(height * 0.3),
      ),
    ];
  }

  _dateSetUp(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
    );
    setState(
      () {
        this.date = pickedDate;
      },
    );
  }

  _makePreview(double height) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Stock  :  ${scripController.text}'),
          Text(this.date == null
              ? ''
              : 'Entry date : ${this.date.year} - ${this.date.month} - ${this.date.day}'),
          Text('Entry Price  :  ${entryController.text}'),
          Text('Stop Loss  :  ${slController.text}'),
          Text('Quantity  :  ${qtyController.text}'),
          Text(isSelectedForBS[0] ? 'Side :  Buy' : 'Side : Sell'),
          Text(isSelectedForPosition[0]
              ? 'Type : Intraday'
              : isSelectedForPosition[1]
                  ? 'Type : Swing'
                  : 'Type : Delivery'),
        ],
      ),
    );
  }

  _logicOfEntrySL(BuildContext context) {
    if (this.isSelectedForBS[0] &&
        double.parse(this.entryController.text) <
            double.parse(this.slController.text)) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Entry should be greater than SL for BUY')));
    } else if (this.isSelectedForBS[1] &&
        double.parse(this.entryController.text) >
            double.parse(this.slController.text)) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Entry should be smaller than SL for SELL')));
    } else {
      setState(() {
        this.step++;
      });
    }
  }
}
