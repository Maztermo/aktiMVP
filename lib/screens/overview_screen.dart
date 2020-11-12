import 'package:aktiMVP/providers/tickets_provider.dart';
import 'package:aktiMVP/widgets/landing_tabs/landing_tab0.dart';
import 'package:aktiMVP/widgets/landing_tabs/landing_tab1.dart';
import 'package:aktiMVP/widgets/landing_tabs/landing_tab2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatefulWidget {
  static const routeName = '/OverviewScreen';
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int currentNavBarIndex = 0;

  _OverviewScreenState({this.currentNavBarIndex = 0});

  // Link Navbar with Active Screen/Tab
  final screenTabs = [
    // Tab 0
    Tab0(),

    // Tab 1
    Tab1(),

    // Tab 2
    Tab2(),
  ];

  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<Tickets>(context, listen: false).fetchAndSetTickets().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : screenTabs[currentNavBarIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavBarIndex,
        backgroundColor:
            Color.fromRGBO(129, 168, 121, 1), // Color.fromRGBO(63, 107, 71, 1),
        iconSize: 30,
        selectedItemColor: Colors.white, // Color.fromRGBO(209, 223, 205, 1),
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.3),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Hjem'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favoritter'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil'),
          ),
        ],
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
      ),
    );
  }
}
