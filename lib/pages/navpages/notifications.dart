import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/checkbox.dart';
import 'package:theapp/components/side_notifactions.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late var _checkboxValue = true;
    List<dynamic> _notifications = []; 

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  void getNotifications() async {
    ApiManager apiManager = ApiManager();
    var data = await apiManager.getNotifications();
  
    _notifications = data['sideNotification'];
  
  
    setState(() {});
  }

  updateDatabase(bool value) async {
    ApiManager apiManager = ApiManager();
    await apiManager.updateUsersNotifications(value);
  }
  

//main content
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate('notifications'),
                style: const TextStyle(
                  color: BrandColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
              automaticallyImplyLeading: false,
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
              ]
            ),
            Container(
            margin: const EdgeInsets.only(top: 32, left: 32, right: 32),
            child: Text(
              AppLocalizations.of(context).translate('notification_description'),
              style: const TextStyle(
                color: BrandColors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
            CustomCheckBox(
            text: 'enable_notifications',
            value: _checkboxValue,
            onChanged: (bool? value) {
              setState(() {
                _checkboxValue = value!;
              });
              updateDatabase(_checkboxValue);
            },
          ),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  var notification = _notifications[index];
                  String timestampString = notification['timestamp'] ?? '';
                  int timestampInt = int.parse(timestampString);
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestampInt);
                  return SideNotifications(
                    title: notification['description'] ?? '',
                    date: date,
                    onButtonPressed: () {
                      // Handle button press
                    },
                    action: notification['action'] ?? '',
                    strong: notification['strong'] != null ? List<String>.from(notification['strong']) : [],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}