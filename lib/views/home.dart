import 'package:flutter/material.dart';
import 'package:pron/views/dashboard.dart';
import 'package:pron/views/edit.dart';
import 'calculators.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int index = 0;
  List screens = [const Dashboard(), const Calculators(), const Edit()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: screens[index],

// Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header image here
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://github.com/ShimronAlakkal/tradebook/blob/main/dh.jpg?raw=true'),
                ),
              ),
              child: Stack(
                children: const [
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("Fraction",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // List items here
            // Home
            _drawerItem('Home', const Icon(Icons.home), 1),

            // faq
            _drawerItem('Help', const Icon(Icons.help), 2),

            // donate
            _drawerItem(
                'Contribute', const Icon(Icons.attach_money_rounded), 3),

            // Contact developer
            _drawerItem('Contact Support', const Icon(Icons.person), 4),

            // Report an issue
            _drawerItem(
                'Report an issue', const Icon(Icons.bug_report_rounded), 4),

            // Divider
            const Divider(),

            // Privacy Policy
            _drawerItem('Privacy Policy', const Icon(Icons.policy_rounded), 5),
          ],
        ),
      ),

      // appbar
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 1,
        title: const Text('fraction'),
        centerTitle: true,
      ),

      //    Bottom nav bar location here
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: MediaQuery.of(context).size.height * 0.07,
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: const Color(0xff9b77da),
        ),
        child: NavigationBar(
          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (nIndex) {
            setState(() {
              index = nIndex;
            });
          },
          animationDuration: const Duration(seconds: 1),
          destinations: const [
//  Tradebook Screen

            NavigationDestination(
                selectedIcon: Icon(Icons.analytics_rounded),
                icon: Icon(Icons.analytics_outlined),
                label: 'dashboard'),

// Stats Screen
            NavigationDestination(
                selectedIcon: Icon(Icons.pie_chart_rounded),
                icon: Icon(Icons.pie_chart_outline),
                label: 'calculator'),

// Reminders screen
            NavigationDestination(
              selectedIcon: Icon(Icons.edit),
              icon: Icon(Icons.edit_outlined),
              label: 'transact',
            ),
          ],
        ),
      ),
    );
  }

  _launchItemInPhone(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Could not open link.'),
        action: SnackBarAction(
            label: 'try again',
            onPressed: () {
              _launchItemInPhone(url);
            }),
      ));
    }
  }

  _drawerItem(String title, Icon icon, int index) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      leading: icon,
      onTap: () {
        switch (index) {
          case 1:
            Navigator.pop(context);

            break;
          case 2:
            _launchItemInPhone(
                'https://github.com/ShimronAlakkal/tradebook/blob/main/Help.md');
            break;
          case 3:
            _launchItemInPhone(
                'https://github.com/ShimronAlakkal/tradebook/blob/main/Contribute.md');
            break;
          case 4:
            _launchItemInPhone("mailto:shimron.alakkal1804@gmail.com");
            break;
          case 5:
            _launchItemInPhone(
                'https://github.com/ShimronAlakkal/tradebook/blob/main/Privacy_Policy.md');
            break;
        }
      },
    );
  }
}
