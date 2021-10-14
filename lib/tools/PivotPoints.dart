import 'package:flutter/material.dart';

class PivotPoints extends StatefulWidget {
  final int index;
  final String title;
  PivotPoints({@required this.index, this.title});

  @override
  _PivotPointsState createState() =>
      _PivotPointsState(index: this.index, title: this.title);
}

class _PivotPointsState extends State<PivotPoints> {
  @override
  void dispose() {
    highController.dispose();
    lowController.dispose();
    closeController.dispose();
    openController.dispose();
    super.dispose();
  }

  _PivotPointsState({this.index, this.title});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController highController = TextEditingController();
  TextEditingController lowController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  TextEditingController openController = TextEditingController();

  int index;
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        elevation: 1,
        title: Text(title),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              // High Field
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
                  hintText: ' High Price',
                  hintStyle: TextStyle(
                    letterSpacing: 1.4,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: highController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 15,
              ),

              // Low Field
              TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  } else if (double.parse(value) >
                      double.parse(highController.text)) {
                    return 'Low should always be smaller than high';
                  }
                },
                maxLines: 1,
                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' Low Price',
                  hintStyle: TextStyle(
                    letterSpacing: 1.4,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: lowController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 15,
              ),

              // Close field
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
                  hintText: ' Close Price',
                  hintStyle: TextStyle(
                    letterSpacing: 1.4,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: closeController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 15,
              ),

              // If the index  == 5, there oughta be another field called open
              _isDenmark(index),
              // FAB

              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.deepPurple.shade400,
                  elevation: 1,
                  label: Text(
                    'Caclulate',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      double high = double.parse(highController.text);
                      double low = double.parse(lowController.text);
                      double open =
                          index == 5 ? double.parse(openController.text) : 1.0;
                      double close = double.parse(closeController.text);

                      Map<String, double> result =
                          _pivotpoints(index, high, low, close, open);
                      debugPrint('okay til here');
                      debugPrint('$result is the results ');

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
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
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Text('$result'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, double> _pivotpoints(
      int index, double high, double low, double close, double open) {
    if (index == 2) {
      // spp
      double p = double.parse(((high + low + close) / 3).toStringAsFixed(2));
      return {
        'p': p,
        's1': (p * 2) - high,
        's2': p - (high - low),
        'r1': (p * 2) - low,
        'r2': p + (high - low),
      };
    } else if (index == 3) {
      // Fibo PP
      double p = double.parse(((high + low + close) / 3).toStringAsFixed(2));
      return {
        'p': p,
        's1': p - 0.382 * (high - low),
        's2': p - 0.618 * (high - low),
        'r1': p + 0.382 * (high - low),
        'r2': p + 0.618 * (high - low),
        'r3': p + (high - low),
      };
    } else if (index == 4) {
      // camarilla
      var a = (high - low) * 1.1;
      return {
        'r1': a / 12 + close,
        'r2': a / 6 + close,
        'r3': a / 4 + close,
        'r4': a / 2 + close,
        's1': close - a / 12,
        's2': close - a / 6,
        's3': close - a / 4,
        's4': close - a / 2
      };
    } else if (index == 5) {
      // denmarks
      if (close < open) {
        var x = high + (2 * low) + close;
        var p = x / 4;
        return {
          'p': p,
          's1': x / 2 - high,
          'r1': x / 2 - low,
        };
      } else if (close > open) {
        var x = 2 * high + low + close;
        var p = x / 4;
        return {
          'p': p,
          's1': x / 2 - high,
          'r1': x / 2 - low,
        };
      } else {
        var x = high + low + 2 * close;
        var p = x / 4;
        return {
          'p': p,
          's1': x / 2 - high,
          'r1': x / 2 - low,
        };
      }
    } else {
      // woodies
      var p = (high + low + 2 * close) / 4;
      return {
        'r1': (2 * p) - low,
        'r2': p + high - low,
        'r3': high + 2 * (p - low),
        's1': (2 * p) - high,
        's2': p - ((2 * p) - low) - ((2 * p) - high),
        's3': low - 2 * (high - p),
      };
    }
  }

  Widget _isDenmark(int index) {
    if (index == 5) {
      return TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return 'This field cannot be empty';
          }
        },
        maxLines: 1,
        cursorWidth: 3,
        decoration: InputDecoration(
          hintText: ' Open Price',
          hintStyle: TextStyle(
            letterSpacing: 1.4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        controller: openController,
        keyboardType: TextInputType.number,
        cursorColor: Colors.deepPurple.shade300,
        cursorHeight: 28,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
