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
        body: Column(
          children: [
            // Label for the PS
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Position Sizing Calculators',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // PS for the stoccs
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('stocks'),
                leading: Icon(Icons.business_outlined),
              ),
            ),

            // PS for the forex guys
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('forex'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),

            // PS for the futures buddies
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('futures'),
                leading: Icon(Icons.query_stats_outlined),
              ),
            ),

            // Label for the TA tools
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Technical analysis tools',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // Standard PP
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Standard Pivot Points'),
                leading: Icon(Icons.line_style_rounded),
              ),
            ),

            // Fibonacci retracement tool
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Fibonacci Pivot Points'),
                leading: Icon(Icons.line_weight_rounded),
              ),
            ),

            // CPP tool
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Camarilla Pivot Points'),
                leading: Icon(Icons.straighten_rounded),
              ),
            ),

            // Denmark PP
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Denmark Pivot Points'),
                leading: Icon(Icons.add),
              ),
            ),

            // Ad Unit

            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.amber.shade500),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ));
  }
}
