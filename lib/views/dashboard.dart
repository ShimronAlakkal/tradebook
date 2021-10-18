import 'package:flutter/material.dart';
import 'package:pron/model/database.dart';
import 'package:pron/views/trade_entry.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> items = [];
  Dbase _helper;
  @override
  void initState() {
    super.initState();
    setState(() {
      _helper = Dbase.instance;
    });
    _refreshStorageData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // Add button

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffAB9AFF),
        onPressed: () {
          var res = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TradeEntry();
              },
            ),
          );

          if (res == true) {
            _refreshStorageData();
          }
        },
        label: const Text(
          'add',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
        ),
        icon: const Icon(
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
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
            color: const Color(0xff4E60FF),
          ),

          //  Total investment
          dashLists(height * 0.09, width, const Color(0xff223A32),
              'Account balance  - ', '\$234'),

          //  Total asset under management
          dashLists(height * 0.09, width, const Color(0xff223A32),
              'Total Investment', '\$232'),

          // Position final
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
//  The icon indicating the position trend
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.only(
                        left: 15, right: 25, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
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
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: items.isEmpty
                ? const Center(
                    child: Text('Add your first trade'),
                  )
                : PageView.builder(
                    pageSnapping: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xff6C61B8),
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.only(left: 15, right: 25, top: 5, bottom: 5),
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
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          Text(
            t2,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
    );
  }

  _refreshStorageData() async {
    List<Map<String, dynamic>> item = await _helper.fetch(Dbase.tradesTable);
    setState(() {
      items = item;
    });
  }
}
