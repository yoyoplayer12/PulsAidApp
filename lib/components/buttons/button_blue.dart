import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class ElevatedButtonBlue extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;
  final bool arrow;
  final bool textleft;
  final IconData? icon;

  const ElevatedButtonBlue(
      {super.key,
      this.onPressed,
      required this.child,
      this.icon,
      this.arrow = false,
      this.textleft = false,});

  @override
  State<ElevatedButtonBlue> createState() => _ElevatedButtonBlueState();
}

class _ElevatedButtonBlueState extends State<ElevatedButtonBlue> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      //padding top and bottom to 16
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBackgroundColor: BrandColors.secondaryExtraLight,
      foregroundColor: BrandColors.white,
      backgroundColor: BrandColors.secondary,
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
                if (widget.arrow) // If arrow is true, display an arrow icon
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.arrow_forward_rounded, size: 30),
                    ),
                  ),
                Align(
                  alignment:
                      widget.textleft ? Alignment.centerLeft : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: widget.textleft ? 16 : 0),
                    child: widget.child,
                  ),
                ),
                if(widget.icon != null) // If icon is not null, display an icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(widget.icon, size: 24), // Display the icon
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