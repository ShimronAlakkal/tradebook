import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:fraction/services/ad_services.dart';

class PivotPoints extends StatefulWidget {
  final int index;
  final String title;
  const PivotPoints({Key key, @required this.index, this.title})
      : super(key: key);

  @override
  _PivotPointsState createState() =>
      // ignore: no_logic_in_create_state
      _PivotPointsState(index: index, title: title);
}

class _PivotPointsState extends State<PivotPoints> {
  // BannerAd _bannerAd;
  // bool _isBannerAdReady = false;

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
  }

  @override
  void dispose() {
    // _bannerAd.dispose();

    highController.dispose();
    lowController.dispose();
    closeController.dispose();
    openController.dispose();
    super.dispose();
  }

  _PivotPointsState({this.index, this.title});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController highController = TextEditingController();
  TextEditingController lowController = TextEditingController();
  TextEditingController closeController = TextEditingController();
  TextEditingController openController = TextEditingController();

  int index;
  String title;

  ListView resultList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        elevation: 1,
        title: Text(title),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
// Ads here
              // _isBannerAdReady
              //     ? Center(
              //         child: SizedBox(
              //           width: _bannerAd.size.width.toDouble(),
              //           height: _bannerAd.size.height.toDouble(),
              // //           child: AdWidget(ad: _bannerAd),
              //         ),
              //       )
                  // : const SizedBox(),

              const SizedBox(
                height: 25,
              ),

              // High Field
              TextFormField(
                textInputAction: TextInputAction.next,

                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                },
                maxLines: 1, autofocus: true,

                cursorWidth: 3,
                decoration: InputDecoration(
                  hintText: ' High Price',
                  hintStyle: const TextStyle(
                    letterSpacing: 1.1,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: highController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(
                height: 15,
              ),

              // Low Field
              TextFormField(
                textInputAction: TextInputAction.next,

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
                cursorWidth: 3, autofocus: true,

                decoration: InputDecoration(
                  hintText: ' Low Price',
                  hintStyle: const TextStyle(
                    letterSpacing: 1.1,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: lowController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 15,
              ),

              // Close field
              TextFormField(
                textInputAction:
                    index == 5 ? TextInputAction.next : TextInputAction.done,

                autofocus: true,
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
                  hintStyle: const TextStyle(
                    letterSpacing: 1.1,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: closeController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.deepPurple.shade300,
                cursorHeight: 28,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 15,
              ),

              // If the index  == 5, there oughta be another field called open
              _isDenmark(index),

              // FAB

              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 40),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.deepPurple.shade400,
                  elevation: 1,
                  label: const Text(
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

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.deepPurple.shade200,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurple.shade400),
                                ),
                                child: const Text(
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
                            title: const ListTile(
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
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: _formResultList(result, index),
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
        'p': p,
        'r1': (2 * p) - low,
        'r2': p + high - low,
        'r3': high + 2 * (p - low),
        's1': (2 * p) - high,
        's2': p - (((2 * p) - low) - ((2 * p) - high)),
        's3': low - 2 * (high - p),
      };
    }
  }

  Widget _isDenmark(int index) {
    if (index == 5) {
      return TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.done,
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
          hintStyle: const TextStyle(
            letterSpacing: 1.1,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        controller: openController,
        keyboardType: TextInputType.number,
        cursorColor: Colors.deepPurple.shade300,
        cursorHeight: 28,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  _formResultList(Map<String, double> result, int index) {
    switch (index) {
      case 2:
        //  results for spp
        return ListView(
          children: [
            // p r1 r2 s1 s2
            ListTile(
              leading: const Text(
                'Resistance 2  : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Pivot Point : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['p'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
        break;
      case 3:
// result for fibo pp
        return ListView(
          children: [
            // p r1 r2 s1 s2
            ListTile(
              leading: const Text(
                'Resistance 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Pivot Point : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['p'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
        break;
      case 4:
        // Camarilla pp
        return ListView(
          children: [
            ListTile(
              leading: const Text(
                'Resistance 4 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r4'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 4 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s4'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
        break;
      case 5:
        // denmark pp
        return ListView(
          children: [
            // p r1 r2 s1 s2
            ListTile(
              leading: const Text(
                'Resistance 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Pivot Point : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['p'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
        break;

      case 6:
        // woodies pp
        return ListView(
          children: [
            // p r1 r2 s1 s2
            ListTile(
              leading: const Text(
                'Resistance 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Resistance 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['r1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Pivot Point : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['p'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 1 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s1'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 2 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s2'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Support 3 : ',
                style: TextStyle(fontSize: 16),
              ),
              title: Text(
                result['s3'].toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
        break;
    }
  }
}
