import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // Add button

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xffAB9AFF),
        onPressed: () {
          debugPrint('Height = $height ,  width =  $width');
        },
        label: Text(
          'add',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),

      body: Column(
        children: [
          //  Ad banner

          Container(
            height: height * 0.1,
            width: width,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
            color: Color(0xff4E60FF),
          ),

          //  Total investment
          dashLists(height * 0.09, width, Color(0xff223A32),
              'Account balance  - ', '\$234'),

          //  Total asset under management
          dashLists(height * 0.09, width, Color(0xff223A32), 'Total Investment',
              '\$232'),

          // Position final
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
//  The icon indicating the position trend
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.cyan.shade300,
                    ),
                    height: height * 0.08,
                    child: Center(
                      child: Icon(
                        Icons.show_chart,
                        size: 30,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                ),

                // The text of position and the amoutn in red or green
                Expanded(
                  flex: 3,
                  child: Container(
                    height: height * 0.08,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding:
                        EdgeInsets.only(left: 15, right: 25, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Position',
                          style: TextStyle(color: Colors.black87, fontSize: 22),
                        ),
                        Text(
                          '\$2',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // The trades panel
          Container(
            height: height * 0.3,
            width: width,
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: PageView.builder(
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color(0xff6C61B8),
                  ),
                  height: height * 0.3,
                  width: width,
                  child: Center(
                    child: Text('$index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dashLists(height, width, Color color, String t1, String t2) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.only(left: 15, right: 25, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            t1,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          Text(
            t2,
            style: TextStyle(
              fontSize: 22,
              color: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
