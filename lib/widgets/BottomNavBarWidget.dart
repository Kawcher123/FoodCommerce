import 'package:flutter/material.dart';
import 'package:flutter_app/pages/CartScreen/cartScreen.dart';
import 'package:flutter_app/pages/Profile/profileScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/FoodOrderPage.dart';
import '../pages/FoodOrderPage.dart';
import '../pages/FoodOrderPage.dart';
import '../pages/FoodOrderPage.dart';
import '../pages/HomePage.dart';
import '../pages/SignInPage.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;
  List<Widget> originalScreens;
  List<Widget> listScreens;
  List<int> listScreensIndex;
  Map<int, bool> originalDic;

  void initState() {
    super.initState();
    originalScreens = [HomePage(), HomePage(), Cart(), Profile()];
    originalDic = {0: true, 1: false, 2: false, 3: false};
    listScreens = [HomePage()];
    listScreensIndex = [0];
  }

  void _onItemTapped(int index) async {
    if (originalDic[index] == false) {
      listScreensIndex.add(index);
      originalDic[index] = true;
      listScreensIndex.sort();
      listScreens = listScreensIndex.map((index) {
        return originalScreens[index];
      }).toList();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Winson FYP Food Delivery'),
          ),
          body: IndexedStack(index: _selectedIndex, children: listScreens),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(color: Color(0xFF2c2b2b)),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.near_me),
                title: Text(
                  'Near By',
                  style: TextStyle(color: Color(0xFF2c2b2b)),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                title: Text(
                  'Cart',
                  style: TextStyle(color: Color(0xFF2c2b2b)),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user),
                title: Text(
                  'Account',
                  style: TextStyle(color: Color(0xFF2c2b2b)),
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFfd5352),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
