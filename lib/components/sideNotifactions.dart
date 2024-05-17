import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';


class SideNotifications extends StatelessWidget {
  final String title;
  final DateTime date;
  final VoidCallback onButtonPressed;
  final String action;
  final List<String> strong;

  const SideNotifications({
    super.key,
    required this.title,
    required this.date,
    required this.onButtonPressed,
    required this.action,
    required this.strong,
  });

  @override
  Widget build(BuildContext context) {
  Duration difference = DateTime.now().difference(date).abs();  
  int totalDays = difference.inDays;
    String timeSinceNotification;
      if (totalDays >= 365) {
        int years = (totalDays / 365).round();
        timeSinceNotification = AppLocalizations.of(context).translate('received_years_ago').replaceAll('{years}', '$years');
      } else if (totalDays >= 30) {
        int months = (totalDays / 30).round();
        timeSinceNotification = AppLocalizations.of(context).translate('received_months_ago').replaceAll('{months}', '$months');
      } else if (totalDays >= 1) {
        timeSinceNotification = AppLocalizations.of(context).translate('received_days_ago').replaceAll('{days}', '$totalDays');
      } else {
        int hours = difference.inHours;
        timeSinceNotification = AppLocalizations.of(context).translate('received_hours_ago').replaceAll('{hours}', '$hours');
      }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
                          children: AppLocalizations.of(context).translate(title).split(" ").map((word) {
                            return TextSpan(
                              text: "$word ",
                              style: strong.map((s) => AppLocalizations.of(context).translate(s)).contains(word) ? const TextStyle(fontWeight: FontWeight.bold) : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8.0), // Add some space between the title and the dates
                Text(
                  timeSinceNotification,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: BrandColors.grayMid),
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
                              AppLocalizations.of(context).translate(action),
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