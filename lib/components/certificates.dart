import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/pages/settings/certificate_detail.dart';


class Certificate extends StatelessWidget {
  final String title;
  final DateTime endDate;
  final VoidCallback onButtonPressed;

  const Certificate({
    Key? key,
    required this.title,
    required this.endDate,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Duration difference = endDate.difference(DateTime.now());    
  int totalDays = difference.inDays;
    String timeSinceEndDate;
    if (endDate.isBefore(DateTime.now())) {
      timeSinceEndDate = AppLocalizations.of(context).translate('expired');
    } else {
      if (totalDays >= 365) {
        int years = (totalDays / 365).round();
        timeSinceEndDate = AppLocalizations.of(context).translate('expires_in_years').replaceAll('{years}', '$years');
      } else if (totalDays >= 30) {
        int months = (totalDays / 30).round();
        timeSinceEndDate = AppLocalizations.of(context).translate('expires_in_months').replaceAll('{months}', '$months');
      } else {
        timeSinceEndDate = AppLocalizations.of(context).translate('expires_in_days').replaceAll('{days}', '$totalDays');
      }
    } 

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onButtonPressed,
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
                Text(
                  AppLocalizations.of(context).translate('certificate').replaceAll("{title}", title),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0), // Add some space between the title and the dates
                Text(
                  timeSinceEndDate,
                  style: const TextStyle(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 143,
                    height: 48,
                    child: GestureDetector(
                      child: ElevatedButtonBlue(
                        onPressed: onButtonPressed, // Call the onButtonPressed function when the button is pressed
                        arrow: false,
                        icon: Icons.restart_alt_rounded,
                        textleft: true,
                        child: Builder(
                          builder: (BuildContext context) {
                            return Text(
                              AppLocalizations.of(context).translate('renew'),
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
      ),
    );
  }
}