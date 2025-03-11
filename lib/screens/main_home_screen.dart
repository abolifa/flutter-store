import 'package:app/screens/account/account_screen.dart';
import 'package:app/screens/cart/cart_screens.dart';
import 'package:app/screens/category/category_screen.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:app/screens/offer/offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const OfferScreen(),
    const AccountScreen(),
    const CartScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          iconSize: 29,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 2.3,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.house,
              ),
              label: 'الرئيسية',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.grid2x2,
              ),
              label: 'الأقسام',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.percent,
              ),
              label: 'العروض',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.user,
              ),
              label: 'الحساب',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.shoppingCart,
              ),
              label: 'السلة',
            ),
          ],
        ),
      ),
    );
  }
}
