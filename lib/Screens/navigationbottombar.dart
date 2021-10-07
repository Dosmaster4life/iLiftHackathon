import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'package:ilift/Screens/home_feed.dart';
import 'package:ilift/Screens/home_post.dart';
import 'package:ilift/Screens/home_settings.dart';
import 'package:ilift/Custom Widgets/home_appbar.dart';
import 'package:ilift/main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({Key? key}) : super(key: key);

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {


  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> screenList = <Widget>[ // Current Home Screens
    const home_feed(),
    const home_post(),
    const home_settings()
  ];
  List<PersistentBottomNavBarItem> _navItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("See"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.share_solid),
        title: ("Share"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  Widget build(BuildContext context) {

    List<Widget> _Screens() {
      return [
        home_feed(),
        home_post(),
        home_settings()
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _Screens(),
      items: _navItems(),
      navBarStyle: NavBarStyle.style3, // Ch
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),


    );

  }
}