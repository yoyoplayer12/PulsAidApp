import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';


class Certificate extends StatelessWidget {
  final String title;
  final DateTime endDate;
  final VoidCallback onButtonPressed;
  final VoidCallback onButtonPressed2;

  const Certificate({
    super.key,
    required this.title,
    required this.endDate,
    required this.onButtonPressed,
    required this.onButtonPressed2,
  });

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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          color: BrandColors.whiteDark,
          elevation: 0.0, // No drop shadow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).translate('certificate2').replaceAll("{title}", title),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: onButtonPressed,
                        child: const Icon(Icons.visibility_outlined), // The eye icon                         // De functie die wordt aangeroepen wanneer erop wordt geklikt
                      ),
                    ],
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
                        onPressed: onButtonPressed2, // Call the onButtonPressed function when the button is pressed
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
    );
  }
}