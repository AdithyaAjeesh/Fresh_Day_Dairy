import 'package:flutter/material.dart';
import 'package:fresh_day_dairy_project/common/controller/bottom_nav_controller.dart';
import 'package:fresh_day_dairy_project/home/home_screen.dart';
import 'package:fresh_day_dairy_project/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer<BottomNavController>(builder: (context, provider, child) {
      List screens = [
        const HomeScreen(),
        const ProfileScreen(),
      ];
      return Scaffold(
        body: screens[provider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: theme.primary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          showUnselectedLabels: false,
          currentIndex: provider.currentIndex,
          onTap: (value) {
            provider.navigateToNextScreen(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }
}
