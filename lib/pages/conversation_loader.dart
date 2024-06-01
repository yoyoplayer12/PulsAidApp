import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';

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
    body: Center(
      child: Text('Received argument: ${widget.platform}'),
    ),
  );
}
void getEars(String platform) async =>
  // ApiManager apiManager = ApiManager();
  // apiManager.fetchEars()

  //TODO: check if the platform is messenger or whatsapp
  // send platform to api
  // response should be 5 user id's
  // send those 5 users a push notification (with the platform as argument, and the user id as hidden argument)
  // if user clicks on push notification, create new conversation (api)
  // send this user to the conversation page
  // no response after 30 seconds?
  // show button to try another platform


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