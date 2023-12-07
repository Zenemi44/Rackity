import 'package:flutter/material.dart';
import '../tabs/search_tab.dart';
import '../tabs/closet_tab.dart';
import '../tabs/generate_tab.dart';
import '../tabs/outfits_tab.dart';
import '../tabs/profile_tab.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  double _iconSize = 30.0;
  bool showNames = true; // add the boolean variable

  static List<Widget> _widgetOptions = <Widget>[
    ClosetTab(),
    GenerateTab(),
    OutfitsTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Closet',
            onPressed: () {
              _onItemTapped(0);
            },
            tooltip: 'Closet',
            child: Icon(Icons.door_back_door),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'Generate',
            onPressed: () {
              _onItemTapped(1);
            },
            tooltip: 'Generate',
            child: Icon(Icons.auto_awesome),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'Outfits',
            onPressed: () {
              _onItemTapped(2);
            },
            tooltip: 'Outfits',
            child: Icon(Icons.people),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
            tooltip: 'Profile',
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
