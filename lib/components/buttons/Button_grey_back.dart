import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class ElevatedButtonGreyBack extends StatefulWidget {
  final VoidCallback? onPressed; // Make onPressed nullable
  final Widget child;

  const ElevatedButtonGreyBack(
      {super.key, this.onPressed, required this.child});

  @override
  State<ElevatedButtonGreyBack> createState() => _ElevatedButtonGreyBackState();
}

class _ElevatedButtonGreyBackState extends State<ElevatedButtonGreyBack> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      //padding top and bottom to 16
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: BrandColors.greyExtraLight,
      backgroundColor: BrandColors.whiteDark,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: widget.onPressed,
            child: const Stack(
              alignment: Alignment.center,
              children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_back_rounded, size: 30),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// to add:
//           Container(
//             // next button
//             margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.06,
//                 left: 30,
//                 right: 30),
//             width: 100,
//             child: ElevatedButtonGreyBack(
//               onPressed: () {
//                       //add _selectedLanguage to session
//                       Navigator.pushNamed(context, '/language');
//                     },
//               child: const Text(''),
//             ),
//           ),