import 'package:learn_apps/constants/color.dart';
import 'package:learn_apps/constants/icons.dart';
import 'package:learn_apps/constants/size.dart';
import 'package:learn_apps/screens/featured_screen.dart';
import 'package:flutter/material.dart';



class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const FeaturedScreen(),
    const FeaturedScreen(),
    const FeaturedScreen(),
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icFeatured,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icFeaturedOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Featured",
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icArPage,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icArPageOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Fun AR ",
          
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                icSetting,
                height: kBottomNavigationBarItemSize,
              ),
              icon: Image.asset(
                icSettingOutlined,
                height: kBottomNavigationBarItemSize,
              ),
              label: "Settings",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}