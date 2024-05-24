import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/components/radio_button.dart';

class DoNotDisturbRepeat extends StatefulWidget {
  final String selected;
  const DoNotDisturbRepeat({super.key, required this.selected});

  @override
  // ignore: library_private_types_in_public_api
  _DoNotDisturbRepeatState createState() => _DoNotDisturbRepeatState();
}

class _DoNotDisturbRepeatState extends State<DoNotDisturbRepeat> {
  String repeat = 'no_repeat';

  @override
  void initState() {
    super.initState();
    repeat = widget.selected;
  }
 


//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: Container(
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
      decoration: BoxDecoration(
        color: BrandColors.white,
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
      ),
      child: const CustomNavBar(
        selectedIndex: 1,
      ),
    ),
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context).translate('do_not_disturb'),
                style: const TextStyle(
                  color: BrandColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32, color: BrandColors.grey, semanticLabel: 'Exit'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0, left: 0.0, right: 0.0),
              width: MediaQuery.of(context).size.width,
              child:Column(
              children: [
                RadioButton(
                  text: "no_repeat",
                  groupValue: repeat,
                  borderColor: repeat == "no_repeat" ? BrandColors.secondaryNight : BrandColors.greyLight.withOpacity(0.2),
                  value: "no_repeat",
                  onChanged: (String? value) {
                    setState(() {
                      repeat = value!;
                    });
                  },
                ),
                RadioButton(
                  text: "daily",
                  groupValue: repeat,
                  borderColor: repeat == "daily" ? BrandColors.secondaryNight : BrandColors.greyLight.withOpacity(0.2),
                  value: "daily",
                  onChanged: (String? value) {
                    setState(() {
                      repeat = value!;
                    });
                  },
                ),
                RadioButton(
                  text: "weekly",
                  borderColor: repeat == "weekly" ? BrandColors.secondaryNight : BrandColors.greyLight.withOpacity(0.2),
                  groupValue: repeat,
                  value: "weekly",
                  onChanged: (String? value) {
                    setState(() {
                      repeat = value!;
                    });
                  },
                ),
                RadioButton(
                  text: "monthly",
                  borderColor: repeat == "monthly" ? BrandColors.secondaryNight : BrandColors.greyLight.withOpacity(0.2),
                  groupValue: repeat,
                  value: "monthly",
                  onChanged: (String? value) {
                    setState(() {
                      repeat = value!;
                    });
                  },
                ),
                RadioButton(
                  text: "yearly",
                  borderColor: repeat == "yearly" ? BrandColors.secondaryNight : BrandColors.greyLight.withOpacity(0.2),
                  groupValue: repeat,
                  value: "yearly",
                  onChanged: (String? value) {
                    setState(() {
                      repeat = value!;
                    });
                  },
                )
              ],
              ),
            ),
          ],
        ),
         Positioned(
          bottom: 32,
          left: 32,
          child: SizedBox(
            width: 88,
            child: ElevatedButtonGreyBack(
              onPressed: () {
                Navigator.pushNamed(context, '/doNotDisturbAdd', arguments: repeat);
              },
            child: const Text(''),
            ),
          ),
        ),
      ],
    ),
  );
}
}