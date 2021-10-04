import 'package:flutter/material.dart';
import 'package:ilift/Screens/home_feed.dart';
import 'package:ilift/Screens/home_post.dart';
import 'package:ilift/Screens/home_settings.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({Key? key}) : super(key: key);

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int currentIndex = 0;
  void onClick(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  List<Widget> screenList = <Widget>[
    const home_feed(),
    const home_post(),
    const home_settings()
  ];
  BottomNavigationBar navBar() {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
          icon: Icon(Icons.home), label: ('Feed')),
      BottomNavigationBarItem(
          icon: Icon(Icons.accessibility_sharp), label: ('Share')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: ('Settings')),
    ],
        currentIndex: currentIndex,
        onTap: onClick,
        type: BottomNavigationBarType.fixed);
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: screenList.elementAt(currentIndex),
      bottomNavigationBar: navBar(),
    );

  }
}
