import 'package:flutter/material.dart';

class StockPS extends StatefulWidget {
  const StockPS();

  @override
  _StockPSState createState() => _StockPSState();
}

class _StockPSState extends State<StockPS> {
  int ps;
  String ratio;
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
        elevation: 0,
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
                      }
                    },
                    maxLines: 1,
                    cursorWidth: 3,
                    decoration: InputDecoration(
                      hintText: ' Entry',
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

                  //  Elevated button
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.deepPurple.shade400,
                      elevation: 1,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          double leverageBasedCapital =
                              double.parse(leverageController.text) *
                                  double.parse(capitalContorller.text);

                          print('$leverageBasedCapital lbc');

                          double accountRisk =
                              (double.parse(riskController.text) / 100.00) *
                                  leverageBasedCapital;

                          print('$accountRisk , acr');

                          double tradeRisk = 100 -
                              (double.parse(slController.text) * 100) /
                                  double.parse(entryController.text);

                          print('$tradeRisk trade risk');

                          int ns = (accountRisk / tradeRisk).round();
                          double totalRisk = ns * tradeRisk;

                          double reward = (double.parse(targetController.text) -
                                  double.parse(entryController.text)) *
                              ns;

                          setState(
                            () {
                              this.ps = ns;
                              this.ratio =
                                  '${totalRisk / totalRisk} : ${reward / totalRisk}';
                            },
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Calculations'),
                                content: Column(
                                  children: [
                                    Text('Number of Shares : ${this.ps}'),
                                    Text(
                                        'Risk To Reward ratio : ${this.ratio}'),
                                  ],
                                ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
