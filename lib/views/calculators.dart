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
        body: Column(
      children: [
        // Label for the PS
        Padding(
          padding: EdgeInsets.all(10),
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
          padding: EdgeInsets.all(10),
          child: Text(
            'Technical analysis tools',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        // Fibonacci retracement tool
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Fibonacci retracement'),
            leading: Icon(Icons.manage_search_outlined),
          ),
        ),

        // RSI tool
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('RSI'),
            leading: Icon(Icons.straighten_rounded),
          ),
        ),
      ],
    ));
  }
}
