import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElevatedButtonDarkBlue extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;
  final IconData? icon;
  final String? svgIcon;
  final Color background;
  final Color foreground;
  final Color? border;
  final Alignment alignment;

  const ElevatedButtonDarkBlue(
    {super.key,
    this.onPressed,
    required this.child,
    this.icon,
    this.svgIcon,
    this.background = BrandColors.secondaryExtraDark,
    this.foreground = BrandColors.whiteLight,
    this.border,
    this.alignment = Alignment.centerLeft
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
      disabledBackgroundColor: widget.background,
      foregroundColor: widget.foreground,
      backgroundColor: widget.background,
      disabledForegroundColor: widget.foreground,
      side: widget.border != null ? BorderSide(color: widget.border!, width: 2) : BorderSide.none,
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
                if (widget.svgIcon != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(widget.svgIcon!, height: 20, width: 20),
                    ),
                  ),
                if (widget.icon != null) // If icon is true, display an icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(widget.icon, size: 32, weight: 300),
                    ),
                  ),
                Align(
                  alignment:
                  widget.alignment,
                  child: Padding(
                    padding:  widget.alignment == Alignment.centerLeft ? widget.icon != null ?  const EdgeInsets.only(left: 24, top: 8, bottom: 8): const EdgeInsets.only(left: 24, top: 8, bottom: 8, right: 24) :  const EdgeInsets.only(left: 0, top: 8, bottom: 8),
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