import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'CategoryPage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'WishlistPage.dart';

class BotNavBarPage extends StatefulWidget {
  @override
  _BotNavBarPageState createState() => _BotNavBarPageState();
}

class _BotNavBarPageState extends State<BotNavBarPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    WishlistPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      //jika curent index = 3 maka akan diarahkan ke halaman cart dengan navigasi push
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
      } else {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(bottom: 5), child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green.shade700,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_grid_2x2_fill,
              color: Colors.green.shade700,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.green.shade700,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.green.shade700,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.green.shade700,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
