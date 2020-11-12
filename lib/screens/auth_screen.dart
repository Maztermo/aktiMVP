import 'package:aktiMVP/widgets/auth_tabs/log_in_tab.dart';
import 'package:aktiMVP/widgets/auth_tabs/register_tab.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentNavBarIndex = 1;

  // Link Navbar with Active Screen/Tab
  final screenTabs = [
    Center(
      child: Text('closing page'),
    ),
    LogInTab(),
    RegisterTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenTabs[_currentNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavBarIndex,
        backgroundColor: Color.fromRGBO(129, 168, 121, 1),
        iconSize: 30,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.8),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            title: Text('Gå tilbake'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Logg inn'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Opprett ny bruker'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentNavBarIndex = index;
            print(index);
            if (_currentNavBarIndex == 0) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          });
        },
      ),
    );
  }
}
