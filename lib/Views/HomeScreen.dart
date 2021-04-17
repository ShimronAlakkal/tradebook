import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5),
            child: Container(
              child: Text(
                '$index',
                style: TextStyle(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
