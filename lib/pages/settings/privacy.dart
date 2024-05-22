import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_dark_blue_account.dart';
import 'package:theapp/components/navbar.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  late String _userId = '';
  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

    void _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (_userId != "")?Container(
        margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
        decoration: BoxDecoration(
          color: BrandColors.offWhiteLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const CustomNavBar(
          selectedIndex: 3,
        ),
      ): null,
      body: Column(
        children: [
          AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('privacy'),
              style: const TextStyle(
                color: BrandColors.grayMid,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 65,
          ),
          Container(
          margin: const EdgeInsets.only(bottom: 16, right: 48, left: 48),
          width: MediaQuery.of(context).size.width - 96,                  
          child: ElevatedButtonDarkBlueAccount(
            icon: Icons.lock_outline ,
            child:  Text(
              AppLocalizations.of(context).translate("privacy_policy"),
              style: const TextStyle(color: BrandColors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/privacypolicy");
            },
          ),
        ),
        const SizedBox(
            height: 24,
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 16, right: 48, left: 48),
          width: MediaQuery.of(context).size.width - 96,                  
          child: ElevatedButtonDarkBlueAccount(
            icon: Icons.verified_user_outlined ,
            child:  Text(
              AppLocalizations.of(context).translate("terms_of_service"),
              style: const TextStyle(color: BrandColors.white, fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/termsofuse");
            },
          ),
        ),
        ],
      ),
    );
  }
}