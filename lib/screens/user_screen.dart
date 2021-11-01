import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/user/change_password.dart';
import 'package:flutter_firebase_signin/user/dashboard.dart';
import 'package:flutter_firebase_signin/user/profile.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  int _selectedIndex=0;

  static List<Widget> _widgetOptions=<Widget>[
    DashBoard(),
    Profile(),
    ChangePassword(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
          label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'change Password')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
