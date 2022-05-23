import 'package:flutter/material.dart';
import 'package:pc_parts_app/screens/cart_screen.dart';
import 'package:pc_parts_app/screens/hot_screen.dart';
import 'package:pc_parts_app/screens/shop_screen.dart';
import 'package:provider/provider.dart';
import 'package:pc_parts_app/models/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /*
  int _selectedIndex = 0;

  void _onNavItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  */

  static List pages = [
    HotScreen(),
    ShopScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'PC Parts Shop'
            ),
            centerTitle: false,
          ),
          body: pages[tabManager.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: tabManager.selectedTab,
            onTap: (index){
              tabManager.goToTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.whatshot,
                ),
                label: 'What\'s Hot',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_checkout,
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      }
    );
  }
}
