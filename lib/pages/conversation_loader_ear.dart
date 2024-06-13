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
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
  }

  void _setAvailability(bool isAvailable) {
    setState(() {
      _isAvailable = isAvailable;
    });

    if (!isAvailable) {
      Navigator.pop(context); // Go home if not available
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent automatic popping of current route
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_isAvailable
              ? AppLocalizations.of(context).translate("initiating_conversation")
              : AppLocalizations.of(context).translate("initiating_conversation")),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _isAvailable
                  ? [
                      Container(
                        margin: const EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          'You should receive a message on ${widget.platform} in a few minutes.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                  : [
                      ElevatedButton(
                        onPressed: () => _setAvailability(true),
                        child: Text(AppLocalizations.of(context).translate("im_available")),
                      ),
                      ElevatedButton(
                        onPressed: () => _setAvailability(false),
                        child: Text(AppLocalizations.of(context).translate("im_not_available")),
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}