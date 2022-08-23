import 'package:flutter/material.dart';
import 'package:fraction/tools/stockps.dart';
import 'package:fraction/tools/pivot_points.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:fraction/services/ad_services.dart';

class Calculators extends StatefulWidget {
  const Calculators({Key key}) : super(key: key);

  @override
  _CalculatorsState createState() => _CalculatorsState();
}

class _CalculatorsState extends State<Calculators> {
 
  //  BannerAd _bannerAd;

  // bool _isBannerAdReady = false;


  @override
  void initState() {
    super.initState();
// _bannerAd = BannerAd(
//     adUnitId: AdServices().androidBannerId,
//     request: const AdRequest(),
//     size: AdSize.banner,
//     listener: BannerAdListener(
//       onAdLoaded: (_) {
//         setState(() {
//           _isBannerAdReady = true;
//         });
//       },
//       onAdFailedToLoad: (ad, err) {
//         _isBannerAdReady = false;
//         ad.dispose();
//       },
//     ),
//   )..load();
  
  }

  @override
  void dispose() {
    // _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // _isBannerAdReady ? Center(
              //         child: SizedBox(
              //           width: _bannerAd.size.width.toDouble(),
              //           height: _bannerAd.size.height.toDouble(),
              //           child: AdWidget(ad: _bannerAd),
              //         ),
              //       )
              //     : const SizedBox(),
              // //  Ad banner
             const SizedBox(
                      height: 10,
                    ),

              // Label for the PS
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10, left: 20),
                child: Text(
                  'Position Sizing Calculators',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              // PS for the stoccs

              tileItem(
                  'stocks',
                  const Icon(Icons.business_outlined, color: Colors.white),
                  Colors.amber.shade400,
                  0),

              // Label for the TA tools
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 10, left: 20),
                child: Text(
                  'Technical Analysis Tools',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              // Standard PP
              tileItem(
                  'standard Pivot Points',
                  const Icon(Icons.line_style_rounded, color: Colors.white),
                  Colors.lime.shade300,
                  2),

              // Fibonacci retracement tool
              tileItem(
                  'Fibonacci Pivot Points',
                  const Icon(Icons.line_weight_rounded, color: Colors.white),
                  Colors.orange.shade300,
                  3),

              // CPP tool
              tileItem(
                  'Camarilla Pivot Points',
                  const Icon(Icons.straighten_rounded, color: Colors.white),
                  Colors.pink.shade300,
                  4),

              // Denmark PP
              tileItem(
                  'Denmark\'s Pivot Points',
                  const Icon(Icons.add, color: Colors.white),
                  Colors.purple.shade300,
                  5),

              // Woodies PP
              tileItem(
                  'Woodie\'s Pivot Points',
                  const Icon(Icons.waterfall_chart_rounded,
                      color: Colors.white),
                  Colors.green.shade300,
                  6),
            ],
          ),
        ],
      ),
    );
  }

  Widget tileItem(String title, Icon icon, Color bgc, int pageIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: ListTile(
        onTap: () {
          if (pageIndex == 0) {
            // Stock PS
            moveToPage(const StockPS());
          } else if (pageIndex == 2) {
            // standard Pivot points
            moveToPage(const PivotPoints(
              index: 2,
              title: 'Standard Pivot Points',
            ));
          } else if (pageIndex == 3) {
            // Fibo PP
            moveToPage(const PivotPoints(
              index: 3,
              title: 'Fibonacci Pivot Points',
            ));
          } else if (pageIndex == 4) {
            // Camarilla PP
            moveToPage(const PivotPoints(
              index: 4,
              title: 'Camarilla Pivot Points',
            ));
          } else if (pageIndex == 5) {
            // Denmark PP
            moveToPage(const PivotPoints(
              index: 5,
              title: 'Denmark\'s Pivot Point',
            ));
          } else {
            moveToPage(const PivotPoints(
              index: 6,
              title: 'Woodie\'s Pivot Points',
            ));
          }
        },
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: bgc,
          ),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.15,
          child: icon,
        ),
      ),
    );
  }

  moveToPage(page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }
}
