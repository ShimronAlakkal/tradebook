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
      PageController(viewportFraction: 0, initialPage: 0);

  @override
  void initState() {
    super.initState();
    setState(() {
      instance = Helper.dbInstance;
    });
    _getPageData(instance);
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
                    color: Colors.white70,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, left: 10, right: 25),
                  ),
                  Text(
                    'POSITIONS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('$index')),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),

      //
      backgroundColor: Colors.white70,
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('Add'),
      ),
    );
  }

  _getPageData(Helper instance) async {
    var x = await instance.select();
    setState(() {
      this.rows = x;
    });
  }
}
