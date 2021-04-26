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
            // Symbol input text field
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              // Symbol of the stock which is important.
              child: TextFormField(
                textInputAction: TextInputAction.done,
                textDirection: TextDirection.ltr,
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
                  hintStyle: TextStyle(fontWeight: FontWeight.w200),
                  labelText: 'Symbol',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.normal,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            //Quantity entered

            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                showCursor: true,
                maxLines: 1,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a valid quantity';
                  } else {
                    this.qtyController.text = value;
                  }
                },
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.phone,
                controller: qtyController,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'bought or sold (required)',
                  hintStyle: TextStyle(fontWeight: FontWeight.w200),
                  labelText: 'Qty',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.normal,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            // enter price text field
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Price';
                  } else {
                    this.enterPriceController.text = value;
                  }
                },

                controller: enterPriceController,
                keyboardType: TextInputType.phone,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Enter the price entered',
                  labelText: 'Enter',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.normal,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

// Row for getting the oppsitoin entered
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.only(left: 15, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(dfltPosition),
                  DropdownButton(
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
                ],
              ),
            ),

            // current day end
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter a CDE';
                  } else {
                    this.currentDayEndController.text = value;
                  }
                },

                controller: currentDayEndController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'price per stock at the end of the day',
                  labelText: 'CDE price',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.normal,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

// Button for adding the data to the database from the UI

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    _addItem(context);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                child: Text('close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            title: Text('Error'),
                            content: Text(e),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          );
                        });
                  }
                },
                icon: Icon(Icons.add_box),
                label: Text('Add'),
              ),
            ),

            Container(
              color: Colors.grey[50],
              child: Center(
                child: Text('AD space'),
              ),
            )
          ],
        ),
      ),
    );
  }

  _addItem(context) async {
    if (formKey.currentState.validate()) {
      _helper.insert({
        'symbol': symbolController.text,
        'Enter': enterPriceController.text,
        'position': dfltPosition,
        'Qty': qtyController.text,
        'DayEndPrice': currentDayEndController.text
      });
      _backToMain(context);
    }
  }

  _backToMain(context) {
    Navigator.pop(context, true);
  }
}
