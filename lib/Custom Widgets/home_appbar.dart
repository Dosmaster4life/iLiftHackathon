import 'package:flutter/material.dart';
import 'package:ilift/Screens/navigationbottombar.dart';
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.index}) : super(key: key);
  final int index;
  @override

  Size get preferredSize => const Size.fromHeight(50);

  String getScreenText() {
    if(index == 0) {
      return ("See");
    }else if(index == 1) {
      return "Share";
    }else if(index == 2) {
      return "Settings";
    }
    return "Empty";
  }
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(getScreenText()),
    );
  }
}
