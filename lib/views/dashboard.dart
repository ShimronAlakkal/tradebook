import 'package:flutter/material.dart';
import 'package:fraction/model/database.dart';
import 'package:fraction/views/trade_entry.dart';
import 'package:fraction/model/transaction_database.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:fraction/services/ad_services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> trades = [];
  Dbase _helper;
  Tdbase _tdbaseHelper;
  double totalInvestment = 0.0;
  double accountBalance = 0.0;

  // BannerAd _bannerAd;
  // bool _isBannerAdReady = false;

  // InterstitialAd _interstitialAd;
  // bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    // _bannerAd = BannerAd(
    //   adUnitId: AdServices().androidBannerId,
    //   request: const AdRequest(keywords: [
    //     "finance",
    //     "jobs",
    //     "money",
    //     "business",
    //     "trading",
    //     "stocks",
    //     "crypto",
    //     "market",
    //     "coins",
    //     "currency",
    //     "cryptocurrency"
    //   ]),
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

    // InterstitialAd.load(
    //   adUnitId: AdServices().androidInterstitialId,
    //   request: const AdRequest(),
    //   adLoadCallback: InterstitialAdLoadCallback(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _interstitialAd = ad;
    //         _isInterstitialAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (err) {
    //       _isInterstitialAdReady = false;
    //     },
    //   ),
    // );

    setState(() {
      _helper = Dbase.instance;
      _tdbaseHelper = Tdbase.instance;
    });
    _refreshStorageData();
  }

  @override
  void dispose() {
    // _bannerAd.dispose();
// _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // Add button

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffAB9AFF),
        onPressed: () async {
          bool res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TradeEntry(
                  ab: accountBalance,
                  bs: 1,
                  edit: 0,
                  entry: '',
                  position: 0,
                  qty: '',
                  scrip: '',
                  sl: '',
                );
              },
            ),
          );

          if (res) {
            // if (trades.length % 3 == 0 && _isInterstitialAdReady) {
            //   _interstitialAd.show();
            //   _refreshStorageData();
            // }
            _refreshStorageData();
          }
        },
        label: const Text(
          'add',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),

      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 10,
              ),

              // The text stating stats
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 20, bottom: 10),
                child: Text(
                  'Stats',
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              //  Total investment
              dashLists(
                  height * 0.1,
                  width,
                  'Account balance  ',
                  accountBalance == null ? '0.0' : kmbGenerator(accountBalance),
                  const Icon(Icons.cases_rounded)),

              //  Total asset under management
              dashLists(
                  height * 0.1,
                  width,
                  'Total Investment ',
                  totalInvestment == null
                      ? '0.0'
                      : kmbGenerator(totalInvestment),
                  const Icon(Icons.monetization_on)),

              // dsah list of short positions
              // dashLists(height * 0.09, width, 'Short Position',  totalShortPosition.toString() ,const Icon(Icons.border_top_rounded)),

              // Position final
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
                child: Text(
                  'Trades',
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              // The trades panel
              Container(
                height: height * 0.33,
                width: width,
                margin: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 8),
                decoration: BoxDecoration(
                  color: trades.isNotEmpty
                      ? Colors.transparent
                      : const Color(0xff272727),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: trades.isEmpty
                    ? const Center(
                        child: Text(
                          'Add your first trade',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      )
                    : _pageview(height, width),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _pageview(height, width) {
    return PageView.builder(
      pageSnapping: true,
      physics: const BouncingScrollPhysics(),
      itemCount: trades.length,

      // The trade cards that are shown in the main screen
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff6C61B8),
          ),
          height: height * 0.4,
          width: width,
          child: InkWell(
            onLongPress: () {
              _deleteTrade(index);
            },
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The  scrip date , positoin and icon button to delete
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.black54,
                      ),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 15.0, left: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // The scrip and date panels
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${trades[index]['scrip']} ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),

                              const SizedBox(
                                width: 15,
                              ),

                              // The dates panel
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 4,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: trades[index]['buyorsell'] == 1
                                        ? [
                                            Colors.green[500],
                                            Colors.lightGreen[500]
                                          ]
                                        : [Colors.pink[500], Colors.red[500]],
                                  ),
                                ),
                                child: Text(
                                  '${trades[index]['date']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // The edit and delete button dropdown
                          PopupMenuButton(onSelected: (value) {
                            if (value == 1) {
                              _editPage(index);
                            } else {
                              _deleteTrade(index);
                            }
                          }, itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                child: Text('Edit'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text('Delete'),
                                value: 2,
                              ),
                            ];
                          }),
                        ],
                      ),
                    ),

                    // The entry , Qty and SL tab
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //  The entry tab
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                'Entry',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${trades[index]['entry']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),

                          // The Qty tab
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${trades[index]['qty']}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),

                          // The sl tab
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Stop Loss',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                trades[index]['sl'] == null
                                    ? 'NA'
                                    : '${trades[index]['sl']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    // The row for intraday and shyt and approx trade worth
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //The  product type
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                trades[index]['longorshort'] == 0
                                    ? 'Day'
                                    : trades[index]['longorshort'] == 1
                                        ? 'Swing'
                                        : 'Delivery',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),

                          // The total amount used tab
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trades[index]['buyorsell'] == 1
                                    ? 'Approx Trade Worth'
                                    : 'Approx Risk in Trade',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                trades[index]['buyorsell'] == 1
                                    ? (trades[index]['entry'] *
                                            trades[index]['qty'])
                                        .toString()
                                    : (trades[index]['qty'] *
                                            (-trades[index]['entry'] +
                                                trades[index]['sl']))
                                        .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget dashLists(height, width, String t1, String t2, Icon icon) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff272727),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.08),
                ),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.15,
                child: icon,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                t1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            t2,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: t2 != '0.0' ? Colors.greenAccent.shade200 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _refreshStorageData() async {
    List<Map<String, dynamic>> item = await _helper.fetchTrades();
    _setAccountDetails();

    setState(() {
      trades = item;
    });
  }

  _deleteTrade(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this trade?'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),

            // The cancel button on alert dialog
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple.shade400)),
              onPressed: () {
                _helper.deleteTrade(trades[index]['id']);
                Navigator.pop(context);
                _refreshStorageData();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      },
    );
  }

  _editPage(int index) async {
    bool res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TradeEntry(
            ab: accountBalance,
            // + trades[index]['entry'] * trades[index]['qty'],
            edit: 1,
            id: trades[index]['id'],
            scrip: trades[index]['scrip'],
            sl: '${trades[index]['sl']}',
            bs: trades[index]['buyorsell'],
            qty: '${trades[index]['qty']}',
            position: trades[index]['longorshort'],
            entry: '${trades[index]['entry']}',
          );
        },
      ),
    );
    if (res) {
      // if (trades.length % 3 == 0 && _isInterstitialAdReady) {
      //   _interstitialAd.show();
      //   _refreshStorageData();
      // }
      _refreshStorageData();
    }
  }

  _setAccountDetails() async {
    double ti = await _helper.getTotalInvestment();
    double tdep = await _tdbaseHelper.getTotalDeposit();
    double twdrw = await _tdbaseHelper.getTotalWithdrawal();
    ti == null ? ti = 0 : ti = ti;
    twdrw == null ? twdrw = 0.0 : twdrw = twdrw;
    tdep == null ? tdep = 0 : tdep = tdep;

    setState(() {
      totalInvestment = ti;
      accountBalance = tdep - ti - twdrw;
      // totalShortPosition = tshort;
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
