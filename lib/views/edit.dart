import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Deposit or Withdraw button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('deposit / withdraw'),
        icon: Icon(Icons.add),
      ),

      // ListView builder here
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.amber.shade50,
              title: Text('Deposit'),
              trailing: Text('123442'),
              subtitle: Text('12/4/1999'),
            ),
          );
        },
      ),
    );
  }
}
