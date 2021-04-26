import 'package:appa/Views/FieldPage.dart';
import 'package:flutter/material.dart';
import 'package:appa/utils/Backend.dart';
import 'package:flutter/widgets.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Map<String, dynamic>> rows;
  Helper instance;
  PageController pageController =
      PageController(viewportFraction: 0.98, initialPage: 0);

  @override
  void initState() {
    super.initState();
    setState(() {
      instance = Helper.dbInstance;
      _refreshView(instance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              color: Colors.black45,
              icon: Icon(Icons.bubble_chart_outlined),
              onPressed: () {},
            ),
            Text(
              'AUM',
              style: TextStyle(
                color: Colors.green[700],
              ),
            ),
            IconButton(
              color: Colors.black45,
              icon: Icon(Icons.person_outline_rounded),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5)),
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Total A U M',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text('630'),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Total Investment ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text('630.00'),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Day P & L',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text('19.29'),
                    Text('3.59 %'),
                  ],
                ),
              ),

              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.trending_up_outlined,
                      color: Colors.green,
                      size: 30,
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, left: 10, right: 25),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'POSITIONS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //
              // The main pageview container
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                alignment: Alignment.centerLeft,
                child: PageView.builder(
                  pageSnapping: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.08,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: this.rows.length != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                          'Symbol : ${this.rows[index]['symbol']}'),
                                      IconButton(
                                        icon:
                                            Icon(Icons.vertical_split_outlined),

                                        //  go to edit from here
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  Text('Total QTY : ${this.rows[index]['Qty']}')
                                ],
                              ),
                            )
                          : Center(child: Text('ENTER A VALUE TO VIEW HERE')),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: this.rows.length != null ? this.rows.length : 1,
                ),
              ),
            ],
          ),
        ),
      ),

      //
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FieldPage();
              },
            ),
          );
          if (result) {
            _refreshView(instance);
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Alert'),
                  content: Text(
                      'Try inputting the index again as it was not added to the db'),
                  actions: [
                    ElevatedButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
    );
  }

  _refreshView(Helper instance) async {
    var x = await instance.select();
    setState(() {
      this.rows = x;
    });
  }
}
