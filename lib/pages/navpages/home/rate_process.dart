import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:theapp/components/buttons/button_dark_blue.dart';

class RateProcess extends StatefulWidget {
  final String date;
  final String id;
  const RateProcess({super.key, 
  required this.date, 
  required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _RateProcessState createState() => _RateProcessState();
}

class _RateProcessState extends State<RateProcess> {
  double way = 0;
  double usability = 0;
  String feedback = '';

  void send() {
    ApiManager().updateEmergenciesFeedback(way, usability, feedback, widget.id).then((response) {
      if (response['status'] == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
      }
    });
  }
  
//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body:
    Column(
    children: [
      AppBar(
        centerTitle: true,
        title: Container(
        margin: const EdgeInsets.only(left: 16.0), // adjust the value as needed
        child: Text(
          AppLocalizations.of(context).translate('resuscitation'),
          style: const TextStyle(
            color: BrandColors.grayMid,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.transparent, // make the AppBar background transparent
        elevation: 0, // remove shadow
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0), // adjust the value as needed
            child: IconButton(
              icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'), // replace with your desired icon
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ]
      ),
      Container(
        margin: const EdgeInsets.only(top: 16.0),
        child:  Text(
          "${AppLocalizations.of(context).translate(DateFormat.EEEE().format(DateFormat('dd-MM-yyyy').parse(widget.date)))}: ${widget.date}",          
          style: const TextStyle(
            color: BrandColors.grayLight,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 16.0, left: 32.0, right: 32.0),
        width: MediaQuery.of(context).size.width - 64,
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0, left: 0.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('how_easy_did_you_find_your_way'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    wrapAlignment: WrapAlignment.start,
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.only(right: 24.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: BrandColors.primaryGreen,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() => way = rating);
                    },
                  ),
                ],
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 32.0, left: 0.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('what_do_you_think_of_the_way_the_app_works'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.only(right: 24.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: BrandColors.primaryGreen,
                    ),
                    onRatingUpdate: (rating) {
                      setState (() => usability = rating);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32.0, left: 0.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('what_is_your_feedback'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: (text){setState(() {
                      feedback = text;
                    });},
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "aa",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: BrandColors.grayLight.withOpacity(0.2), width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: BrandColors.grayLight.withOpacity(0.2), width: 2.0), // Increased width
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: BrandColors.grayLight.withOpacity(0.2), width: 2.0), // Decreased width
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  ElevatedButtonDarkBlue(
                    icon: Icons.arrow_forward_rounded,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('send'),
                      style: const TextStyle(color: BrandColors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      send();
                    },
                  ),
                ],
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