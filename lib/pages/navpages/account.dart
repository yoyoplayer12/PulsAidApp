import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_dark_blue_account.dart';
import 'package:theapp/components/navbar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name = '';
  IconData icon = Icons.volunteer_activism_outlined;
  String rank = 'helper';
  Color rankColor = BrandColors.primaryGreen;
  String role = '';

  //logincheck
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedin', false);
    await prefs.setString('user', '');
    await prefs.setString('language', '');
    await prefs.setString('role', '');
    OneSignal.logout();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/language', (Route<dynamic> route) => false);
    });
  }

  Future<void> getUserInfo() async {
    final userInfo = await ApiManager().userInfo();
    setState(() {
      name = userInfo['user']['firstname'] + ' ' + userInfo['user']['lastname'];
      role = userInfo['user']['role'];
    });
    final amountofemergencies = await ApiManager().amountOfEmergencies();
    setState(() {
      if (amountofemergencies['amount'] >= 5) {
        icon = Icons.stars_outlined;
        rank = 'hero';
        rankColor = BrandColors.primaryGreenDark;
      }
      if (amountofemergencies['amount'] >= 10) {
        icon = Icons.verified_outlined;
        rank = "champion";
        rankColor = BrandColors.primaryOcean;
      }
    });
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
          selectedIndex: 3,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 300, // Set the height to the height of the screen
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background_header_login.png'), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width - 64,
                margin: const EdgeInsets.only(top: 100, left: 32, right: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32.5,
                          backgroundColor: rankColor,
                          child: Icon(
                            icon,
                            color: BrandColors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          // Add this
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  color: BrandColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              Text(
                                AppLocalizations.of(context).translate(rank),
                                style: const TextStyle(
                                  color: BrandColors.greyExtraLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(top: 250),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 16, right: 48, left: 48),
                      width: MediaQuery.of(context).size.width - 96,
                      child: ElevatedButtonDarkBlueAccount(
                        icon: Icons.account_circle_outlined,
                        child: const Text(
                          "Account",
                          style:
                              TextStyle(color: BrandColors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/accountSettings");
                        },
                      ),
                    ),
                    (role == 'EHBO' || role == 'AED')
                        ? Container(
                            margin: const EdgeInsets.only(
                                bottom: 16, right: 48, left: 48),
                            width: MediaQuery.of(context).size.width - 96,
                            child: ElevatedButtonDarkBlueAccount(
                              icon: Icons.notifications_none_outlined,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("notifications"),
                                style: const TextStyle(
                                    color: BrandColors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/notifications");
                              },
                            ),
                          )
                        : Container(),
                    (role == 'EHBO')
                        ? Container(
                            margin: const EdgeInsets.only(
                                bottom: 16, right: 48, left: 48),
                            width: MediaQuery.of(context).size.width - 96,
                            child: ElevatedButtonDarkBlueAccount(
                              icon: Icons.verified_user_outlined,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("certificates"),
                                style: const TextStyle(
                                    color: BrandColors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/certificates");
                              },
                            ),
                          )
                        : Container(),
                    (role == 'ListeningEar')
                        ? Container(
                            margin: const EdgeInsets.only(
                                bottom: 16, right: 48, left: 48),
                            width: MediaQuery.of(context).size.width - 96,
                            child: ElevatedButtonDarkBlueAccount(
                              icon: Icons.verified_user_outlined,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("contact_info"),
                                style: const TextStyle(
                                    color: BrandColors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/contactInfo");
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 16, right: 48, left: 48),
                      width: MediaQuery.of(context).size.width - 96,
                      child: ElevatedButtonDarkBlueAccount(
                        icon: Icons.lock_outline,
                        child: const Text(
                          "privacy",
                          style:
                              TextStyle(color: BrandColors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/privacy");
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 16, right: 48, left: 48),
                      width: MediaQuery.of(context).size.width - 96,
                      child: ElevatedButtonDarkBlueAccount(
                        icon: Icons.translate_rounded,
                        child: Text(
                          AppLocalizations.of(context).translate("language"),
                          style: const TextStyle(
                              color: BrandColors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/languageSettings");
                        },
                      ),
                    ),
                    (role == 'EHBO' || role == 'AED')
                        ? Container(
                            margin: const EdgeInsets.only(
                                bottom: 16, right: 48, left: 48),
                            width: MediaQuery.of(context).size.width - 96,
                            child: ElevatedButtonDarkBlueAccount(
                              icon: Icons.location_on_outlined,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("location"),
                                style: const TextStyle(
                                    color: BrandColors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/location");
                              },
                            ),
                          )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(
                      bottom: 16, right: 48, left: 48),
                      width: MediaQuery.of(context).size.width - 64,
                      child: ElevatedButtonDarkBlueAccount(
                        logout: true,
                        icon: Icons.logout,
                        onPressed: _logout,
                        child: Text(
                          AppLocalizations.of(context).translate("logout"),
                          style: const TextStyle(
                              color: BrandColors.secondaryExtraDark,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
