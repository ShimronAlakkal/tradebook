import 'package:flutter/material.dart';
import 'package:pron/tools/stockps.dart';
import 'package:pron/tools/pivot_points.dart';

class Calculators extends StatefulWidget {
  const Calculators({Key key}) : super(key: key);

  @override
  _CalculatorsState createState() => _CalculatorsState();
}

class _CalculatorsState extends State<Calculators> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          Column(
            children: [
              // Ad Unit

              Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.amber.shade500),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
              ),

              // Label for the PS
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Position Sizing Calculators',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Technical analysis tools',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.all(8.0),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
