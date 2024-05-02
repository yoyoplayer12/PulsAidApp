import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int _selectedIndex;

    @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/doNotDisturb');
        break;
      case 2:
        Navigator.pushNamed(context, '/instructions');
        break;
      case 3:
        Navigator.pushNamed(context, '/account');
        break;
    }
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
            icon: _selectedIndex == 1 ? const Icon(Icons.timer) : const Icon(Icons.timer_outlined),
            label: AppLocalizations.of(context).translate('do_not_disturb'),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? const Icon(Icons.play_lesson) : const Icon(Icons.play_lesson_outlined),
            label: AppLocalizations.of(context).translate('instructions'),
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