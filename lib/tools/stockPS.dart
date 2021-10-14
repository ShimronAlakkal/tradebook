import 'package:flutter/material.dart';

class StockPS extends StatefulWidget {
  const StockPS();

  @override
  _StockPSState createState() => _StockPSState();
}

class _StockPSState extends State<StockPS> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController capitalContorller = TextEditingController();
  TextEditingController riskController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController slController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController leverageController = TextEditingController();

  @override
  void dispose() {
    capitalContorller.dispose();
    riskController.dispose();
    entryController.dispose();
    slController.dispose();
    targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Position Size Calculator',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      // body of the stocks page

      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  // Capital Field
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Capital',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: capitalContorller,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // Leverage on capital
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Leverage on capital',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: leverageController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Risk Field
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Risk ( % )',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: riskController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // The Entry
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (double.parse(value) >
                          double.parse(capitalContorller.text)) {
                        return 'Entry Price cannot be over capital';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Entry Price',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: entryController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // SL
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (double.parse(value) >
                          double.parse(entryController.text)) {
                        return 'SL should always be smaller than entry';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Stop Loss',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: slController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Target
                  TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Target',
                      hintStyle: TextStyle(
                        letterSpacing: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: targetController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.deepPurple.shade300,
                    cursorHeight: 28,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  //  fa button
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.deepPurple.shade400,
                      elevation: 1,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          // Total capital leveraged leverage
                          double leverageBasedCapital =
                              double.parse(leverageController.text) *
                                  double.parse(capitalContorller.text);

                          print('$leverageBasedCapital lbc');

                          // Total money risking per trade AKA account risk

                          double accountRisk = double.parse(
                              ((double.parse(riskController.text) / 100.00) *
                                      leverageBasedCapital)
                                  .toStringAsFixed(2));

// trade risk calc in percentage =   % difference in the entry and sl

                          double tradeRisk = double.parse(
                              (double.parse(entryController.text) -
                                      double.parse(slController.text))
                                  .toStringAsFixed(2));

// Position Size in number of shares

                          int numberOfShares =
                              (accountRisk / tradeRisk).round();

// Total risk with capital
                          double totalRisk = numberOfShares *
                              (double.parse(
                                  (double.parse(entryController.text) -
                                          double.parse(slController.text))
                                      .toStringAsFixed(2)));

// Total profit to be made
                          double targetProfit = numberOfShares *
                              (double.parse(
                                  (double.parse(targetController.text) -
                                          double.parse(entryController.text))
                                      .toStringAsFixed(2)));

// Rewars per share
                          double rewardPerShare = double.parse(
                              (double.parse(targetController.text) -
                                      double.parse(entryController.text))
                                  .toStringAsFixed(2));

                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: ListTile(
                                  tileColor: Colors.deepPurple,
                                  title: Center(
                                    child: Text(
                                      'Calculations',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                ),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                          'Leveraged Capital : $leverageBasedCapital'),
                                      Text(
                                          'Number of shares : $numberOfShares'),
                                      Text(
                                          'Total Risk Involved : ${totalRisk.toStringAsFixed(2)}'),
                                      Text(
                                          'Risk per Share : ${totalRisk / numberOfShares}'),
                                      Text(
                                          'Reward per Share : $rewardPerShare'),
                                      Text('Target profit :  $targetProfit'),
                                      Text(
                                          'risk to reward ratio : ${totalRisk / totalRisk} : ${(targetProfit / totalRisk).toStringAsFixed(2)} ')
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple.shade400),
                                    ),
                                    child: Text(
                                      'Close',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      label: Text(
                        'Caclulate',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  // Ad Unit

                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.amber.shade500),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
