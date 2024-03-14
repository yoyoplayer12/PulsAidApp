import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int numberOfCalls = 0;

  @override
  void initState() {
    super.initState();
    if (false == GlobalVariables().loggedin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/language');
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 377 / 307,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background_header_login.png', // replace with your first image asset
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Positioned(
        bottom: 180,
        left: 0, // This and the line below ensure the Text widget is centered horizontally
        right: 0,
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate('you_have_no_calls'),
              style: const TextStyle(
                color: BrandColors.blackMid,
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: SizedBox(
              width: 190,
              height: 190,
              child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/heart.png', // replace with your first image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              ),
            )
        ),
        ),
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context).translate('completed_calls'),
                style: const TextStyle(
                  color: BrandColors.grayMid,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_sharp, size: 32, color: BrandColors.grayMid, semanticLabel: 'notifications'), // replace with your desired icon
                    onPressed: () {
                      // handle the icon tap here
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
            ),
            numberOfCalls > 0 ? (numberOfCalls > 0 ? _buildContentForCalls() : _buildContentForNoCalls()) : Container(),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildContentForCalls() {
    return Center(
      child: Text('You have $numberOfCalls calls'),
    );
  }

  Widget _buildContentForNoCalls() {
    return Center(
      child: Text(AppLocalizations.of(context).translate('you_have_no_calls')),
    );
  }
}