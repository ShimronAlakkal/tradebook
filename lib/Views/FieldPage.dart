import 'package:flutter/material.dart';
import 'package:appa/utils/Backend.dart';

class FieldPage extends StatefulWidget {
  @override
  _FieldPageState createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  @override
  void initState() {
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
  TextEditingController targetController = TextEditingController();
  TextEditingController exitController = TextEditingController();
  TextEditingController stopLossController = TextEditingController();
  TextEditingController currentDayEndController = TextEditingController();

  List<String> position = ['BUY', "SELL"];
  List<String> typeOfOrder = ['Delivery', 'Intraday'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded), onPressed: () {}),
        title: Text('Info input page'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Symbol input text field
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    ),
                  ),
                ),

                // enter price text field
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        ),
                      ),

                      // Dropdown fro choosing the type of order

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

                // target price controller null
                //
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,

                    // ignore: missing_return
                    autocorrect: true,
                    controller: targetController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    ),
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
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    ),
                  ),
                ),

                // Exit price
                //
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    autocorrect: true,
                    controller: exitController,
                    enabled: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    ),
                  ),
                ),

// Button for adding the data to the database from the UI

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_box),
                  label: Text('Add'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addItem() async {
    if (formKey.currentState.validate()) {}
  }
}
