import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class Navigation extends StatefulWidget {
  final List<Widget> pages;
  final List<NavigationDestination> destinations;

  const Navigation({
    Key? key,
    required this.pages,
    required this.destinations,
  }) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    body: Stack(
      children: [
        widget.pages[currentPageIndex], // This is your body content
        Positioned(
          bottom: 0,
          left: screenWidth * 0.05, // This will center the navigation bar
          child: Container(
            width: screenWidth * 0.9, // 80% of the screen width
            margin: const EdgeInsets.only(bottom: 20), // bottom margin of 40
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)), // Adjust the radius to your liking
              child: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                backgroundColor: BrandColors.offWhiteLight,
                indicatorColor: BrandColors.offWhiteLight,
                surfaceTintColor: BrandColors.offWhiteLight,
                selectedIndex: currentPageIndex,
                destinations: widget.destinations,
                height: 50, // Increase the height
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}