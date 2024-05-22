import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';


class Conversation extends StatelessWidget {
  final String option;
  final String applicantContact;
  final VoidCallback onButtonPressed;

  const Conversation({
    super.key,
    required this.option,
    required this.applicantContact,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          color: BrandColors.offWhiteDark,
          elevation: 0.0, // No drop shadow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate(option),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        ":",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Flexible( // Wrap the Text widget with a Flexible widget
                        child: Text(
                          applicantContact,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8.0), // Add some space between the title and the dates
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 143,
                    height: 48,
                    child: GestureDetector(
                      child: ElevatedButtonBlue(
                        onPressed: onButtonPressed, // Call the onButtonPressed function when the button is pressed
                        arrow: false,
                        icon: Icons.forum_outlined,
                        textleft: true,
                        child: Builder(
                          builder: (BuildContext context) {
                            return Text(
                              AppLocalizations.of(context).translate('answer'),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}