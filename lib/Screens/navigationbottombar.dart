import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'package:ilift/Screens/home_feed.dart';
import 'package:ilift/Screens/home_post.dart';
import 'package:ilift/Screens/home_settings.dart';
import 'package:ilift/Custom Widgets/home_appbar.dart';
import 'package:ilift/Screens/login_check.dart';
import 'package:ilift/main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
class NavigationBottomBar extends StatefulWidget {


  const NavigationBottomBar({Key? key,required this.hideB}) : super(key: key);
  final bool hideB;


  @override

  _NavigationBottomBarState createState() => _NavigationBottomBarState();

}

class _NavigationBottomBarState extends State<NavigationBottomBar> {

 void hideBarNow() {
   hideBar = true;
   setState(() {

   });
 }


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
  bool hideBar = false;
  List<Widget> _Screens() {
    return [
      home_feed(),
      home_post(),
      home_settings()
    ];
  }
  PersistentTabView pBuilder(context) {
    if(hideBar == true) {
      return PersistentTabView(
        context,
        hideNavigationBar: true,
        controller: _controller,
        screens: _Screens(),
        items: _navItems(),
        navBarStyle: NavBarStyle.style3,
        // Ch
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),


      );
    }else {
      return PersistentTabView(
        context,
        hideNavigationBar: false,
        controller: _controller,
        screens: _Screens(),
        items: _navItems(),
        navBarStyle: NavBarStyle.style3,
        // Ch
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),


      );
    }
  }
  Widget build(BuildContext context) {
    return pBuilder(context);
    print("Hide Bar" + hideBar.toString());



  }
}