import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/main.dart';
import 'package:theapp/pages/navpages/notifications.dart';
import 'package:theapp/components/animations/heart.dart';
import 'package:theapp/classes/apimanager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> callDates = [];

  @override
  void initState() {
    super.initState();
    if (false == GlobalVariables.loggedin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/language');
      });
    }
    ApiManager apiManager = ApiManager();
    apiManager.fetchEmergencies().then((emergencies) {
      // Extract the timestamps and store them in callDates
      setState(() {
        callDates = emergencies['emergencies'].map<String>((emergency) {
          return emergency['timestamp'].toString();
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: Container(
      margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
      decoration: BoxDecoration(
        color: BrandColors.offWhiteLight,
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
      ),
      child: const CustomNavBar(
        selectedIndex: 0,
      ),
    ),   
body:
      Stack(
        children: <Widget>[
          callDates.isEmpty
              ? AspectRatio(
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
                )
              : Container(),
          callDates.isEmpty
              ? Stack(
                  alignment: Alignment.center, // This will center the children
                  children: [
                    const HeartAnimation(),
                    Positioned(
                      bottom:
                          180, // adjust this value as needed to move the text down
                      child: Text(
                        (AppLocalizations.of(context)
                            .translate('you_have_no_calls')),
                        style: const TextStyle(
                          color: BrandColors.blackMid,
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign
                            .center, // This will center the text horizontally
                      ),
                    ),
                  ],
                )
              : Container(
                  //margin top
                  margin: const EdgeInsets.only(top: 140),
                  child: ListView.builder(
                    itemCount: callDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      // list item
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 8, right: 32, left: 32), // set the margin as needed
                          child: Material(
                              color: Colors.transparent,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // set the border radius as needed
                                ),
                                color: BrandColors.offWhiteDark,
                                surfaceTintColor: BrandColors.offWhiteDark,
                                elevation: 0, // remove shadow
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .translate('rate_the_process'),
                                    style: const TextStyle(
                                      color: BrandColors.blackMid,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  subtitle: Text(
                                    "${AppLocalizations.of(context).translate('date')}: ${callDates[index]}",
                                    style: const TextStyle(
                                      color: BrandColors.blackMid,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  trailing: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons
                                            .edit_square, // use the outlined edit icon
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  )),
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
                    margin: const EdgeInsets.only(
                        right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none_sharp,
                          size: 32,
                          color: BrandColors.grayMid,
                          semanticLabel:
                              'notifications'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Notifications(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ));
                      },
                    ),
                  ),
                ],
                backgroundColor: BrandColors.transparent,
                elevation: 0, // remove shadow
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 32, right: 32),
                child: ElevatedButtonDarkBlue(
                  icon: Icons.question_answer_rounded,
                  child: Text(
                    AppLocalizations.of(context).translate("do_you_want_to_talk"),
                    style: const TextStyle(color: BrandColors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/conversation");
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
