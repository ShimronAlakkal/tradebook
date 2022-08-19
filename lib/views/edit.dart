import 'package:flutter/material.dart';
import 'package:fraction/model/database.dart';
import 'package:fraction/model/transaction_database.dart';
import 'package:fraction/views/transactions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fraction/services/ad_services.dart';

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

  double mainTdep;
  double maintWithdraw;
  double mainTi;

  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    InterstitialAd.load(
      adUnitId: AdServices().androidInterstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          _isInterstitialAdReady = false;
        },
      ),
    );

    setState(() {
      _helper = Tdbase.instance;
      _dbaseHelper = Dbase.instance;
    });

    _refreshTransactions();
  }

  @override
  void dispose() {
    super.dispose();
    // _interstitialAd.dispose();
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
                return Transactions(
                  accountBalance: ab,
                );
              },
            ),
          );
          if (res) {
            if(_isInterstitialAdReady){
              _interstitialAd.show();
              _refreshTransactions();
            }
            _refreshTransactions();
          }
        },
        label: const Text(
          'add / withdraw',
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
      body: //  The main transactions ui part
          transacts.isNotEmpty
              ? ListView.builder(
                  itemCount: transacts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(6),
                      child: ListTile(
                        isThreeLine: false,
                        onLongPress: () {
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
                          transacts[index]['type'] == 1
                              ? 'Deposit'
                              : 'Withdrew',
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
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'Add your first deposit to make a new trade',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )),
                ),
    );
  }

  _refreshTransactions() async {
    List<Map<String, dynamic>> x = await _helper.fetchTransactions();
    double tdep = await _helper.getTotalDeposit();
    double tWithdraw = await _helper.getTotalWithdrawal();
    double ti = await _dbaseHelper.getTotalInvestment();

    setState(() {
      ti == null ? mainTi = 0 : mainTi = ti;
      tdep == null ? mainTdep = 0 : mainTdep = tdep;
      tWithdraw == null ? maintWithdraw = 0.0 : maintWithdraw = tWithdraw;
      transacts = x;
      ab = mainTdep - maintWithdraw - mainTi;
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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              // The cancel button on alert dialog
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple.shade400)),
                onPressed: () {
                  // if total deposit - total investment is greater or equals to the deletion, then execute else msg
                  if (mainTdep - mainTi >= transacts[index]['amount']) {
                    _helper.deleteTransaction(transacts[index]['id']);
                    _refreshTransactions();
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Cannot delete this transaction'),
                        duration: Duration(seconds: 3)));
                  }
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
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
