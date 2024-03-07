import 'package:flutter/material.dart';
// import 'package:theapp/colors.dart';
class ElevatedButtonBlue extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;

  const ElevatedButtonBlue({Key? key, this.onPressed, required this.child}) : super(key: key);

  @override
  State<ElevatedButtonBlue> createState() => _ElevatedButtonBlueState();
}

class _ElevatedButtonBlueState extends State<ElevatedButtonBlue> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
