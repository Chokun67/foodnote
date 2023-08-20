import 'package:flutter/material.dart';
import 'package:foodnote/stock.dart';
import 'home.dart';

class Testnavigation extends StatefulWidget {
  const Testnavigation({super.key});

  @override
  State<Testnavigation> createState() => _TestnavigationState();
}

class _TestnavigationState extends State<Testnavigation> {
  var pages = <Widget>[const Stock(), const MyHomePage()];
    int _navItemIndex = 0;
  @override
  Widget build(BuildContext context) {
     var heightsize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[_navItemIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: heightsize * 0.025,
        selectedFontSize: heightsize * 0.025,
        iconSize: heightsize * 0.04,
        backgroundColor: const Color.fromARGB(255, 244, 117, 39),
        unselectedItemColor: const Color.fromARGB(255, 255, 0, 0),
        selectedItemColor: const Color.fromARGB(255, 255, 230, 2),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.access_alarms), label: 'มี EXP'),
          BottomNavigationBarItem(
              icon: Icon(Icons.alarm_off_outlined), label: 'ไม่มี EXP'),
        ],
        currentIndex: _navItemIndex,
        onTap: (index)=> setState(() {
          _navItemIndex = index;
        }),
      ),
    );
  }
}
