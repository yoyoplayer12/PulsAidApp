import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class ElevatedButtonDarkBlue extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;
  final IconData? icon;

  const ElevatedButtonDarkBlue(
      {super.key,
      this.onPressed,
      required this.child,
      this.icon,
      });

  @override
  State<ElevatedButtonDarkBlue> createState() => _ElevatedButtonBlueState();
}

class _ElevatedButtonBlueState extends State<ElevatedButtonDarkBlue> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      //padding top and bottom to 16
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBackgroundColor: BrandColors.secondaryExtraDark,
      foregroundColor: BrandColors.white,
      backgroundColor: BrandColors.secondaryExtraDark,
      disabledForegroundColor: BrandColors.white,
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
                if (widget.icon != null) // If icon is true, display an icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(widget.icon, size: 24, weight: 300),
                    ),
                  ),
                Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: widget.child,
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