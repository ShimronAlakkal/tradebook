import 'package:flutter/material.dart';
import 'package:appa/utils/Backend.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<Map<String, dynamic>> rows;
  Helper instance;
  PageController pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);

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
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
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
                  horizontal: 5,
                  vertical: 2.5,
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
                  horizontal: 5,
                  vertical: 2.5,
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
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
                child: PageView.builder(
                  pageSnapping: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                        child: Text('$index'),
                      ),
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
        floatingActionButton: ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                'Add',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.add)
            ],
          ),
        ),
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
