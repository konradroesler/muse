import 'package:flutter/material.dart';
import 'package:muse/metronome.dart';

class MuseNavigationBar extends StatefulWidget {
  const MuseNavigationBar({super.key});

  @override
  State<MuseNavigationBar> createState() => _MuseNavigationBarState();
}

class _MuseNavigationBarState extends State<MuseNavigationBar> {
  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    Metronome(),
    Text("Under Construction")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "Metronome",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speed),
            label: "Tuner",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
  }
}
