import 'package:flutter/material.dart';

class Calculators extends StatefulWidget {
  const Calculators({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.amber.shade500),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
              ),

              // Label for the PS
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Position Sizing Calculators',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // PS for the stoccs

              tileItem(
                  'stocks',
                  Icon(Icons.business_outlined, color: Colors.white),
                  Colors.amber.shade400,
                  0),

              // PS for the forex guys

              tileItem(
                  'forex',
                  Icon(Icons.monetization_on_outlined, color: Colors.white),
                  Colors.green.shade300,
                  1),

              // PS for the futures buddies
              tileItem(
                  'futures',
                  Icon(Icons.query_stats_outlined, color: Colors.white),
                  Colors.indigo.shade300,
                  2),

              // Label for the TA tools
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Technical analysis tools',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Standard PP
              tileItem(
                  'standard Pivot Points',
                  Icon(Icons.line_style_rounded, color: Colors.white),
                  Colors.lime.shade300,
                  3),

              // Fibonacci retracement tool
              tileItem(
                  'Fibo Pivot Points',
                  Icon(Icons.line_weight_rounded, color: Colors.white),
                  Colors.orange.shade300,
                  4),

              // CPP tool
              tileItem(
                  'Camarilla Pivot Points',
                  Icon(Icons.straighten_rounded, color: Colors.white),
                  Colors.pink.shade300,
                  5),

              // Denmark PP
              tileItem(
                  'Denmark Pivot Points',
                  Icon(Icons.add, color: Colors.white),
                  Colors.purple.shade300,
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
// // Go to the calculation page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) {
// // Check The selection
//               },
//             ),
//           );
        },
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
}
