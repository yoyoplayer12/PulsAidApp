import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';

class DoNotDisturb extends StatefulWidget {
  const DoNotDisturb({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoNotDisturbState createState() => _DoNotDisturbState();
}

class _DoNotDisturbState extends State<DoNotDisturb> {
  bool calledUp = true;
  List<Map<String, String>> formattedAvailabilityData = [];
    final Completer<void> _busyDataCompleter = Completer();



  @override
  void initState() {
    super.initState();
    _busyDataCompleter.complete(getBusyData());
  }

  

  Future<void> getBusyData() async {
    var result = await ApiManager().fetchDoNotDisturb();
    if (result['status'] == 200) {
      for (var availability in result['availability']) {
        String startdate = formatDateTime(DateTime.parse(availability['startdate']), availability['repeat'], true);
        String enddate = formatDateTime(DateTime.parse(availability['enddate']), availability['repeat'], false);
        formattedAvailabilityData.add({
          'Start': startdate,
          'End': enddate,
          'Repeat': availability['repeat'],
        });
      }
    }
  }

  String formatDateTime(DateTime date, String repeat, bool isStartDate) {
    final String locale = Localizations.localeOf(context).languageCode; // Get the current locale
    final DateFormat timeFormat = DateFormat('HH:mm', locale);
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd', locale);
    final DateFormat dayFormat = DateFormat('EEEE', locale);
  
    String formattedDate;
  
    switch (repeat) {
      case 'daily':
        formattedDate = isStartDate ? '${dayFormat.format(date)} ${timeFormat.format(date)}' : timeFormat.format(date);
        break;
      case 'weekly':
        formattedDate = isStartDate ? '${dayFormat.format(date)} ${timeFormat.format(date)}' : timeFormat.format(date);
        break;
      case 'monthly':
        formattedDate = isStartDate ? '${dayFormat.format(date)} ${timeFormat.format(date)}' : timeFormat.format(date);
        break;
      case 'yearly':
        formattedDate = isStartDate ? '${dayFormat.format(date)} ${timeFormat.format(date)}' : timeFormat.format(date);
        break;
      case 'no_repeat':
      default:
        formattedDate = '${dateFormat.format(date)} ${timeFormat.format(date)}';
        break;
    }
  
    return formattedDate;
  }

void changed(bool? value) {
  if (value != null) {
    setState(() {
      calledUp = !calledUp;
    });
  }
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
    floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/doNotDisturbAdd',
            );
          },
          backgroundColor: BrandColors.secondaryExtraDark,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32, color: BrandColors.white,),
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
                    icon: const Icon(Icons.notifications_none_sharp, size: 32, color: BrandColors.grey, semanticLabel: 'notifications'), // replace with your desired icon
                    onPressed: () {
                      // handle the icon tap here
                      Navigator.pushNamed(
                        context,
                        '/notifications',
                      );
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 32, right: 32),
              width: MediaQuery.of(context).size.width-64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate('active'),
                  style: const TextStyle(
                    color: BrandColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    changed(calledUp);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: BrandColors.secondaryNightDark, // Set the border color
                        width: 2, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context).translate("i_can_be_called_up"),
                              style: const TextStyle(
                                color: BrandColors.greyLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Radio<bool>(
                              value: true,
                              groupValue: calledUp,
                              onChanged: changed,
                              fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                  Text(
                  AppLocalizations.of(context).translate('busy_on'),
                  style: const TextStyle(
                    color: BrandColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ],
            ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 270, left: 16, right: 32),
          height: MediaQuery.of(context).size.height - 400,
          child: FutureBuilder(
            future: _busyDataCompleter.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(); // show a loading spinner while waiting for the data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // show an error message if there's an error
              } else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: formattedAvailabilityData.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 50, // Adjust the height as needed
                      child: ListTile(
                        dense: false, // Reduce spacing between items
                        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16), // Adjust padding as needed
                        title: Row(
                          children: <Widget>[
                            Text(formattedAvailabilityData[index]['Start']!),
                            const Text(' - '),
                            Text(formattedAvailabilityData[index]['End']!),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
}