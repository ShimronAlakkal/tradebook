import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({Key key}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // Deposit or Withdraw button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffAB9AFF),
        onPressed: () {},
        label: const Text(
          'deposit / withdraw',
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
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            height: height * 0.1,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: const ListTile(
              title: Text('Deposit'),
              subtitle: Text('12/3/2222'),
              trailing: Text('2132a'),
              leading: Icon(
                Icons.money_rounded,
              ),
            ),
          );
        },
      ),
    );
  }
}
