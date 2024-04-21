import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Add this line

        elevation: 0,
        selectedItemColor: BrandColors.blackExtraLight,
        unselectedItemColor: BrandColors.blackExtraLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? const Icon(Icons.alarm_on) : const Icon(Icons.alarm_on_outlined),
            label: 'Time out',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? const Icon(Icons.play_lesson) : const Icon(Icons.play_lesson_outlined),
            label: 'Instructions',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3 ? const Icon(Icons.account_circle) : const Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}