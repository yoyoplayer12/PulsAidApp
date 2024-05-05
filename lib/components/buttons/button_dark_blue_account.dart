import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class ElevatedButtonDarkBlueAccount extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;
  final IconData? icon;
  final bool logout;

  const ElevatedButtonDarkBlueAccount(
      {super.key,
      this.onPressed,
      required this.child,
      this.icon,
      this.logout = false
      });

  @override
  State<ElevatedButtonDarkBlueAccount> createState() => _ElevatedButtonBlueState();
}

class _ElevatedButtonBlueState extends State<ElevatedButtonDarkBlueAccount> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      //padding top and bottom to 16
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBackgroundColor: widget.logout ? BrandColors.white : BrandColors.secondaryExtraDark,
      foregroundColor: BrandColors.white,
      backgroundColor: widget.logout ? BrandColors.warning : BrandColors.secondaryExtraDark,
      disabledForegroundColor: widget.logout ? BrandColors.secondaryExtraDark : BrandColors.white,
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
         ElevatedButton(
          style: style,
          onPressed: widget.onPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.icon != null) // If icon is not null, display an icon
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Icon(widget.icon, size: 32), // Display the icon
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 72),
                  child: widget.child,
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 24), // Adjust the padding to position the second icon
                  child: Icon(Icons.keyboard_arrow_right_rounded, size: 32), // Always display a right arrow icon
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}