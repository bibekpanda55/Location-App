import 'package:flutter/material.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key}) : super(key: key);
  static const routeName = '/bottom-widget-screen';
  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
      currentIndex: idx,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey[300],
      selectedItemColor: Colors.black,
      onTap: (index) {
        setState(() {
          idx = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              size: 30,
            )),
        BottomNavigationBarItem(
            label: 'Portfolio',
            icon: Icon(
              Icons.pie_chart,
              size: 30,
            )),
        BottomNavigationBarItem(
            label: "Ideas",
            icon: Icon(
              Icons.lightbulb_outline,
              size: 30,
            )),
        BottomNavigationBarItem(
            label: "Watchlist",
            icon: Icon(
              Icons.list_alt,
              size: 30,
            )),
        BottomNavigationBarItem(
            label: "Notfications",
            icon: Icon(
              Icons.notifications_outlined,
              size: 30,
            ))
      ],
    ));
  }
}
