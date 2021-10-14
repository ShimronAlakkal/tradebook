// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController scripController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController slController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  int step = 0;
  DateTime date;

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
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Ad Unit

            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 20, top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.amber.shade500),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
            ),

            // Main UI
            Stepper(
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
                        },
                        child: Text(
                          this.step == _getSteps(height, width).length - 1
                              ? '    Calculate     '
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
                setState(() {
                  step = nstep;
                });
              },
              onStepCancel: step == 0
                  ? null
                  : () => setState(() {
                        step--;
                      }),
              onStepContinue: () {
                if (this.step != _getSteps(height, width).length - 1) {
                  setState(() {
                    step++;
                  });
                } else {
                  print('completed');
                }
              },
              steps: _getSteps(height, width),
            ),
          ],
        ),
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                },
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
          height: height * 0.2,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              // Buys of sell
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
          height: height * 0.2,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              // The entry price
              TextFormField(
                controller: scripController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                },
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                },
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
            ],
          ),
        ),
      ),
      Step(
        state: this.step > 3 ? StepState.complete : StepState.indexed,
        title: Text(
          'Preview',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: 50,
        ),
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
}
