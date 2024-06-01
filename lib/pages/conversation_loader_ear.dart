import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class ConversationLoaderEar extends StatefulWidget {
  final String platform;

  const ConversationLoaderEar({Key? key, required this.platform})
      : super(key: key);

  @override
  _ConversationLoaderEarState createState() => _ConversationLoaderEarState();
}

class _ConversationLoaderEarState extends State<ConversationLoaderEar> {
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
          title: Text(AppLocalizations.of(context)
              .translate("initiating_conversation")),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'You should receive a message on ${widget.platform} in a few minutes.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}