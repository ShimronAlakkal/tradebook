// @dart=2.9

import 'package:flutter/material.dart';
import 'package:fraction/model/database.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:fraction/services/ad_services.dart';

// ignore: must_be_immutable
class TradeEntry extends StatefulWidget {
  TradeEntry(
      {Key key,
      @required this.ab,
      this.id,
      this.entry,
      this.sl,
      this.bs,
      this.scrip,
      this.position,
      this.qty,
      this.edit})
      : super(key: key);

  String scrip;
  String qty;
  String sl;
  String entry;
  int bs;
  int position;
  int edit;
  int id;
  double ab;
  @override
  // ignore: no_logic_in_create_state
  _TradeEntryState createState() => _TradeEntryState(
      ab: ab,
      edit: edit,
      id: id,
      bs: bs,
      entry: entry,
      sl: sl,
      qty: qty,
      position: position,
      scrip: scrip);
}

class _TradeEntryState extends State<TradeEntry> {
  _TradeEntryState(
      {@required this.ab,
      this.entry,
      this.id,
      this.sl,
      this.bs,
      this.scrip,
      this.position,
      this.qty,
      this.edit});
  int edit;
  String scrip;
  String qty;
  String sl;
  String entry;
  int bs;
  int position;
  int id;

  double ab;

  // BannerAd _bannerAd;

  // bool _isBannerAdReady = false;

  TextEditingController scripController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController slController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  int step = 0;
  DateTime date;
  List<bool> isSelectedForBS = [true, false]; // [BUY,SELL]
  List<bool> isSelectedForPosition = [true, false, false]; // [In,Sw,Dl]

  Dbase _helper;

  @override
  void initState() {
    super.initState();
    // _bannerAd = BannerAd(
    //   adUnitId: AdServices().androidBannerId,
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    // )..load();

    if (bs == 0) {
      setState(() {
        isSelectedForBS[0] = false;
        isSelectedForBS[1] = true;
      });
    } else {
      isSelectedForBS[0] = true;
      isSelectedForBS[1] = false;
    }

    if (position == 0) {
      setState(() {
        isSelectedForPosition[0] = true;
        isSelectedForPosition[1] = false;
        isSelectedForPosition[2] = false;
      });
    } else if (position == 1) {
      setState(() {
        isSelectedForPosition[0] = false;
        isSelectedForPosition[1] = true;
        isSelectedForPosition[2] = false;
      });
    } else {
      setState(() {
        isSelectedForPosition[0] = false;
        isSelectedForPosition[1] = false;
        isSelectedForPosition[2] = true;
      });
    }

    setState(() {
      _helper = Dbase.instance;
      ab == null ? ab = 0.0 : ab = ab;
      scripController.text = scrip;
      qtyController.text = qty;
      entryController.text = entry;
      sl == 'null' ? slController.clear() : slController.text = sl;
    });
  }

  @override
  void dispose() {
    // _bannerAd.dispose();

    entryController.clear();
    qtyController.clear();
    slController.clear();
    scripController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appbar
      appBar: AppBar(
        title: edit == 0 ? const Text('Add a trade') : const Text('Edit trade'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),

      // body
      body: ListView(
        children: [
          //  Ad banner
          // _isBannerAdReady
          //     ? Center(
          //         child: SizedBox(
          //           width: _bannerAd.size.width.toDouble(),
          //           height: _bannerAd.size.height.toDouble(),
          //           child: AdWidget(ad: _bannerAd),
          //         ),
          //       )
          //     : const SizedBox(),

          const SizedBox(
            height: 25,
          ),

          // Main UI
          Stepper(
            currentStep: step,
            controlsBuilder: (context, details) {
              return Row(
                children: [
// The button in on continue

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.deepPurple.shade400),
                      ),
                      onPressed: () async {
                        details.onStepContinue();
                      },
                      child: Text(
                        step == _getSteps(height, width).length - 1
                            ? edit == 1
                                ? '   UPDATE   '
                                : '   SAVE   '
                            : '   Next   ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

//  The button stating back or edit

                  OutlinedButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.cyan.shade50),
                    ),
                    onPressed: () {
                      details.onStepCancel();
                    },
                    child: Text(
                      step == _getSteps(height, width).length - 1
                          ? '   Edit   '
                          : '   Back   ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(1),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              );
            },
            onStepTapped: (nstep) {
              if (nstep != _getSteps(height, width).length - 1) {
                setState(
                  () {
                    step = nstep;
                  },
                );
              }
            },

            onStepCancel: step == 0
                ? null
                : () => setState(
                      () {
                        step--;
                      },
                    ),

            onStepContinue: () {
              if (step != _getSteps(height, width).length - 1) {
                // The first page
                if (step == 0) {
                  // IS the stock name input by the user?
                  if (scripController.text.isNotEmpty && date != null) {
                    setState(() {
                      step++;
                    });
                  } else if (scripController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Please complete the above field'),
                      ),
                    );
                  } else if (date == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Please set a date'),
                      ),
                    );
                  }

                  // The third page
                }
                // The third page
                else if (step == 2) {
                  if (entryController.text.isNotEmpty &&
                      qtyController.text.isNotEmpty &&
                      date != null &&
                      slController.text.isNotEmpty &&
                      scripController.text.isNotEmpty) {
                    _logicOfEntrySL(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
              } else if (step == _getSteps(height, width).length - 1) {
                edit == 0 ? _addToDB() : _updateDB();
              }
            },

            // Steps
            steps: _getSteps(height, width),
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
        state: step > 0 ? StepState.complete : StepState.indexed,
        title: const Text(
          'name and date',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: height * 0.27,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              TextFormField(
                controller: scripController,
                // ignore: missing_return
                textInputAction: TextInputAction.done,
                autofocus: false, showCursor: false,
                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Example : AAPL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                maxLength: 7,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  date == null
                      ? 'Date'
                      : 'Selected date : ${date.day} - ${date.month} - ${date.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(date == null
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
                    date = null;
                  });
                },
              )
            ],
          ),
        ),
      ),

      // The positions tab
      Step(
        state: step > 1 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Position',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          width: double.infinity,
          height: height * 0.3,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buys of sell
              const Text(
                'Order type',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.4),
              ),
              const SizedBox(
                height: 20,
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
                disabledColor: Colors.grey,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                borderWidth: 3,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(17.0),
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

              const SizedBox(
                height: 10,
              ),

              // Trade positon type

              ToggleButtons(
                disabledColor: Colors.grey,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                children: const [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Day',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Swing',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Hold',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
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
        state: step > 2 ? StepState.complete : StepState.indexed,
        title: const Text(
          'Entry details',
          style: TextStyle(fontSize: 18),
        ),
        content: Container(
          height: height * 0.35,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // The entry price
              TextFormField(
                maxLength: 10,
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

              // The stop loss field
              TextFormField(
                maxLength: 10,
                controller: slController,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Stop Loss ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              // Qty Field
              TextFormField(
                maxLength: 8,
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
        state: step > 3 ? StepState.complete : StepState.indexed,
        title: const Text(
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
        date = pickedDate;
      },
    );
  }

  _makePreview(double height) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _previewRows('Stock  :', scripController.text),
          _previewRows(date == null ? '' : 'Entry date :',
              date == null ? '' : '${date.day}/${date.month}/${date.year}'),
          _previewRows('Entry Price :', entryController.text),
          _previewRows('Stop Loss : ', slController.text),
          _previewRows('Quantity : ', qtyController.text),
          _previewRows('Side : ', isSelectedForBS[0] ? 'Buy' : 'Sell'),
          _previewRows(
              'Type : ',
              isSelectedForPosition[0]
                  ? 'Day'
                  : isSelectedForPosition[1]
                      ? 'Swing'
                      : 'Delivery'),
        ],
      ),
    );
  }

  _previewRows(String txt, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _logicOfEntrySL(BuildContext context) {
    if (isSelectedForBS[0] &&
        double.parse(entryController.text) <= double.parse(slController.text)) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Entry should be greater than SL for BUY')));
    } else if (isSelectedForBS[1] &&
        double.parse(entryController.text) >= double.parse(slController.text)) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Entry should be smaller than SL for SELL')));
    } else {
      setState(() {
        step++;
      });
    }
  }

  _addToDB() async {
    if (isSelectedForBS[0]) {
      if (ab >=
          double.parse(double.parse(entryController.text).toStringAsFixed(2)) *
              double.parse(
                  double.parse(qtyController.text).toStringAsFixed(2))) {
        //account balance is greater than trade worth

        await _helper.insertToTrades(
          {
            Dbase.entry: double.parse(
                double.parse(entryController.text).toStringAsFixed(2)),
            Dbase.date: '${date.day}/${date.month}/${date.year}',
            Dbase.sl: slController.text.isNotEmpty
                ? double.parse(
                    double.parse(slController.text).toStringAsFixed(2))
                : null,
            Dbase.scrip: scripController.text,
            Dbase.qty: double.parse(
                double.parse(qtyController.text).toStringAsFixed(2)),
            Dbase.bs: isSelectedForBS[0] ? 1 : 0,
            Dbase.ls: isSelectedForPosition[0]
                ? 0
                : isSelectedForPosition[1]
                    ? 1
                    : 2,
          },
        );
        Navigator.pop(context, true);
      } else {
        _showMsg('Not enough account balance to execute trade.');
      }
    } else {
      await _helper.insertToTrades(
        {
          Dbase.entry: double.parse(
              double.parse(entryController.text).toStringAsFixed(2)),
          Dbase.date: '${date.day}/${date.month}/${date.year}',
          Dbase.sl: slController.text.isNotEmpty
              ? double.parse(double.parse(slController.text).toStringAsFixed(2))
              : null,
          Dbase.scrip: scripController.text,
          Dbase.qty:
              double.parse(double.parse(qtyController.text).toStringAsFixed(2)),
          Dbase.bs: isSelectedForBS[0] ? 1 : 0,
          Dbase.ls: isSelectedForPosition[0]
              ? 0
              : isSelectedForPosition[1]
                  ? 1
                  : 2,
        },
      );
      Navigator.pop(context, true);
    }
  }

  _updateDB() async {
    if (isSelectedForBS[0]) {
      if (ab >=
          double.parse(double.parse(entryController.text).toStringAsFixed(2)) *
              double.parse(
                  double.parse(qtyController.text).toStringAsFixed(2))) {
        //account balance is greater than trade worth

        await _helper.updateTrade({
          Dbase.entry: double.parse(
              double.parse(entryController.text).toStringAsFixed(2)),
          Dbase.date: '"${date.day}/${date.month}/${date.year}"',
          Dbase.sl: slController.text.isNotEmpty
              ? double.parse(double.parse(slController.text).toStringAsFixed(2))
              : null,
          Dbase.scrip: scripController.text,
          Dbase.qty:
              double.parse(double.parse(qtyController.text).toStringAsFixed(2)),
          Dbase.bs: isSelectedForBS[0] ? 1 : 0,
          Dbase.ls: isSelectedForPosition[0]
              ? 0
              : isSelectedForPosition[1]
                  ? 1
                  : 2,
        }, id);
        Navigator.pop(context, true);
      } else {
        _showMsg('Not enough account balance to execute this trade');
      }
    } else {
      await _helper.updateTrade({
        Dbase.entry:
            double.parse(double.parse(entryController.text).toStringAsFixed(2)),
        Dbase.date: '"${date.day}/${date.month}/${date.year}"',
        Dbase.sl: slController.text.isNotEmpty
            ? double.parse(double.parse(slController.text).toStringAsFixed(2))
            : null,
        Dbase.scrip: scripController.text,
        Dbase.qty:
            double.parse(double.parse(qtyController.text).toStringAsFixed(2)),
        Dbase.bs: isSelectedForBS[0] ? 1 : 0,
        Dbase.ls: isSelectedForPosition[0]
            ? 0
            : isSelectedForPosition[1]
                ? 1
                : 2,
      }, id);
      Navigator.pop(context, true);
    }
  }

  _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(msg),
    ));
  }
}
