import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late String _role = '';
  List<BottomNavigationBarItem> navBarItems = [];
  bool _isLoading = true;


    @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    fetchRole();
  }

  Future<String> getRole() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? role = prefs.getString('role');
      return role ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> fetchRole() async {
    final String role = await getRole();
    setState(() {
      _role = role;
      buildNavBarItems();
      _isLoading = false;
    });
  }

    void buildNavBarItems() {
    navBarItems = [];
    // Common item for all roles
    navBarItems.add(
      BottomNavigationBarItem(
        icon: _selectedIndex == 0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
        label: 'Home',
      ),
    );
    if (_role == 'AED' || _role == 'EHBO') {
      navBarItems.add(
        BottomNavigationBarItem(
          icon: _selectedIndex == 1 ? const Icon(Icons.timer) : const Icon(Icons.timer_outlined),
          label: AppLocalizations.of(context).translate('do_not_disturb'),
        ),
      );
      navBarItems.add(
        BottomNavigationBarItem(
          icon: _selectedIndex == 2 ? const Icon(Icons.play_lesson) : const Icon(Icons.play_lesson_outlined),
          label: AppLocalizations.of(context).translate('instructions'),
        ),
      );
    } else if (_role == 'ListeningEar') {
      navBarItems.add(
        BottomNavigationBarItem(
          icon: _selectedIndex == 1 ? const Icon(Icons.contacts) : const Icon(Icons.contacts_outlined),
          label: 'Contacten',
        ),
      );
    }
  
    // Common item for all roles
    navBarItems.add(
      BottomNavigationBarItem(
        icon: _selectedIndex == 3 ? const Icon(Icons.account_circle) : const Icon(Icons.account_circle_outlined),
        label: 'Account',
      ),
    );
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_role) {
      case 'AED':
      case 'EHBO':
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
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
        break;
      case 'ListeningEar':
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/contacts');
            break;
          case 2:
            Navigator.pushNamed(context, '/account');
            break;
        }
        break;
      default:
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/account');
            break;
        }
        break;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
      if (_isLoading) {
      return const CircularProgressIndicator(); // Show loading indicator
    }
      if (_selectedIndex >= navBarItems.length) {
    _selectedIndex = navBarItems.length - 1;
  }
  
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: BrandColors.blackExtraLight,
        unselectedItemColor: BrandColors.blackExtraLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        items: navBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}