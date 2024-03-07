import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class ElevatedButtonBlue extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;
  final bool arrow;

  const ElevatedButtonBlue(
      {Key? key, this.onPressed, required this.child, this.arrow = false})
      : super(key: key);

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
                Align(
                  alignment: Alignment.center,
                  child: widget.child,
                ),
                if (widget.arrow) // If arrow is true, display an arrow icon
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.arrow_forward_rounded, size: 30),
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
