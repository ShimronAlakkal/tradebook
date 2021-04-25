import 'package:flutter/material.dart';
import 'package:appa/utils/Backend.dart';

class FieldPage extends StatefulWidget {
  @override
  _FieldPageState createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _helper = Helper.dbInstance;
    });
  }

  Helper _helper;

  var formKey = GlobalKey<FormState>();

  String dfltPosition = 'BUY';
  String dfltTypeOfOrder = 'Delivery';

  TextEditingController symbolController = TextEditingController();
  TextEditingController enterPriceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController currentDayEndController = TextEditingController();

  List<String> position = ['BUY', "SELL"];
  List<String> typeOfOrder = ['Delivery', 'Intraday'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded), onPressed: () {}),
        title: Text(
          'Info input page',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Column(
              children: [
                // Symbol input text field
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    showCursor: true,
                    maxLines: 1,
                    keyboardAppearance: Brightness.dark,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Symbol of stock required (e.g. RIL, APPL)';
                      } else {
                        this.symbolController.text = value;
                      }
                    },
                    autocorrect: true,
                    controller: symbolController,
                    enabled: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Symbol (required)',
                      labelText: 'Symbol',
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 1.2,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                //Quantity entered

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    controller: qtyController,
                    enabled: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),

                // enter price text field
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Price';
                      } else {
                        this.enterPriceController.text = value;
                      }
                    },
                    autocorrect: true,
                    controller: enterPriceController,
                    enabled: true,

                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Enter',
                      labelText: 'Enter',
                      labelStyle: TextStyle(
                        color: Colors.black87,
                        letterSpacing: 1.2,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Dropdown fro choosing the type of order

                Container(
                  child: DropdownButton(
                    icon: Icon(Icons.arrow_drop_down),
                    items: position.map((String position) {
                      return DropdownMenuItem(
                        child: Text(position),
                        value: position,
                      );
                    }).toList(),
                    onChanged: (newPosition) {
                      setState(() {
                        this.dfltPosition = newPosition;
                      });
                    },
                  ),
                ),

                // current day end
                //
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // ignore: missing_return

                    autocorrect: true,
                    controller: currentDayEndController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: InputBorder.none,
                    ),
                  ),
                ),

// Button for adding the data to the database from the UI

                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      _addItem();
                    } catch (e) {
                      debugPrint(
                          '$e is the goddamn error here bithccccc ***************************************************');
                    }
                  },
                  icon: Icon(Icons.add_box),
                  label: Text('Add'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addItem() async {
    if (formKey.currentState.validate()) {
      _helper.insert({
        'symbol': symbolController.text,
        'Enter': enterPriceController.text,
        'position': position,
        'Qty': qtyController.text,
        'DayEndPrice': currentDayEndController.text
      });
    }
  }
}
