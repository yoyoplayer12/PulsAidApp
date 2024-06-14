import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationLoader extends StatefulWidget {
  final String platform;

  const ConversationLoader({Key? key, required this.platform}) : super(key: key);

  @override
  _ConversationLoaderState createState() => _ConversationLoaderState();
}

class _ConversationLoaderState extends State<ConversationLoader> {
  //logincheck
  @override
  void initState() {
    super.initState();
    sendNotificationToFiveEars(widget.platform);
  }

  //main content
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context).translate("initiating_conversation")),
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: const Center(
      // child: Text('Received argument: ${widget.platform}'),
      child: Text('Finding someone to talk to...')
    ),
  );
}
void sendNotificationToFiveEars(String platform) async {
  // ApiManager apiManager = ApiManager();
  // apiManager.fetchEars()

  //TODO: check if the platform is messenger or whatsapp
  // send platform to api.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('user');
  if (userId == null) {
    // Handle the case where the user ID is not found in the shared preferences
    return;
  }
  ApiManager apiManager = ApiManager();
  print(userId);
  
  //get 5 user id's from api
  Map<String, dynamic> response = await apiManager.fetchEars(platform, userId);
  // List<dynamic> users = response['users'];
  // List<String> userIds = users.map((user) => user['_id'].toString()).toList();
  
  // send those 5 users a push notification (with the platform as argument, and the user id as hidden argument)
  
  // if user clicks on push notification, create new conversation (api)
  // send this user to the conversation page
  // no response after 30 seconds?
  // show button to try another platform

}
}










// const username = "yorickdevleeschouwer";
// final Uri messengerurl = Uri.parse("https://m.me/$username/");
// if (await canLaunchUrl(messengerurl)) {
//   await launchUrl(messengerurl);
// } else {
//   throw 'Could not launch $messengerurl';
// }





// const username = "zwabber_dnb";
//                             final Uri instaurl = Uri.parse("https://www.instagram.com/$username/");
//                             if (await canLaunchUrl(instaurl)) {
//                               await launchUrl(instaurl);
//                             } else {
//                               throw 'Could not launch $instaurl';
//                             }