import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/colors.dart';

class ConversationLoaderEar extends StatefulWidget {
  final String platform;
  final String userId;

  const ConversationLoaderEar({Key? key, required this.platform, required this.userId})
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
    else{
      //send notification to given userid with username in argument
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
              ? AppLocalizations.of(context)
                  .translate("initiating_conversation")
              : AppLocalizations.of(context)
                  .translate("initiating_conversation")),
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
                      ElevatedButtonDarkBlue(
                        icon: Icons.question_answer_rounded,
                        child: Text(
                          AppLocalizations.of(context).translate("im_available"),
                          style: const TextStyle(
                              color: BrandColors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          _setAvailability(true);
                          ApiManager apiManager = ApiManager();
                          sendUser(widget.userId);
                        },
                      ),
                      TextButton(
                        onPressed: () =>  _setAvailability(false),
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
void sendUser(userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (userId == null) {
    return;
  }
  ApiManager apiManager = ApiManager();
  print(userId);
  Map<String, dynamic> response = await apiManager.sendUser(userId);
}