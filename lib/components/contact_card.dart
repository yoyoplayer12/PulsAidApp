import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';


class ContactCard extends StatelessWidget {
  final String option;
  final String applicantContact;

  const ContactCard({
    super.key,
    required this.option,
    required this.applicantContact,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
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
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate(option),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Flexible( // Wrap the Text widget with a Flexible widget
                        child: Text(
                          applicantContact,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
    );
  }
}