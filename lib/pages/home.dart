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
      appBar: AppBar(
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
      ),
      body: numberOfCalls > 0 ? _buildContentForCalls() : _buildContentForNoCalls(),
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