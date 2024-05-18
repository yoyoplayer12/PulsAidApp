import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/classes/location_permission.dart';
import 'package:geolocator/geolocator.dart';
import 'package:theapp/components/conversation.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> callDates = [];
  List<Map<String, dynamic>> conversationRequest = [];
  PermissionHandler permissionHandler = PermissionHandler();
  String? role;
  LatLng? _currentPosition;
  bool _isLoading = true;
  final Completer<GoogleMapController> _controllerCompleter = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    getEmergencies();
    permissionHandler.requestLocationPermission(context);
    getLocation();  
    }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng location = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
  }

    void _onMapCreated(GoogleMapController controller) {
    if (!_controllerCompleter.isCompleted) {
      _controllerCompleter.complete(controller);
    }
  }
  
  void getEmergencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user');
    role = prefs.getString('role');
    
    if(role == 'AED' || role == 'EHBO'){
      ApiManager apiManager = ApiManager();
      apiManager.fetchEmergencies().then((emergencies) {
        var filteredEmergencies = emergencies['emergencies'].where((emergency) {
          return emergency['userId'] is List && emergency['userId'].contains(userId);
        }).toList();

        setState(() {
          callDates = filteredEmergencies.map<Map<String, dynamic>>((emergency) {
            String formattedTimestamp = emergency['timestamp'].replaceFirstMapped(RegExp(r"(\d{2})/(\d{2})/(\d{2})"), (match) => "${match[1]}:${match[2]}:${match[3]}");
            DateFormat format = DateFormat("dd-MM-yyyy HH:mm:ss");
            DateTime timestamp = format.parse(formattedTimestamp);
            return {
              'date': DateFormat('dd-MM-yyyy').format(timestamp),
              'id': emergency['_id'],
            };
          }).toList();
        });
      });
    }
    else {
      ApiManager apiManager = ApiManager();
      apiManager.fetchConversations().then((conversations) {
        var filteredConversations = conversations['conversations'].where((conversation) {
          return conversation['userId'] == userId && conversation['open'] == true;
        }).toList();
        setState(() {
          conversationRequest = filteredConversations.map<Map<String, dynamic>>((conversation) {
            return {
              'option': conversation['option'],
              'applicantContact': conversation['applicantContact'],
            };
          }).toList();
        });
      });
    }
    }

  @override
  void dispose() {
    _controllerCompleter.future.then((controller) {
      controller.dispose();
    }).catchError((error) {
      // Handle any errors if necessary
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
        decoration: BoxDecoration(
          color: BrandColors.offWhiteLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const CustomNavBar(
          selectedIndex: 0,
        ),
      ),
      body: Stack(
        children: <Widget>[
        (role == 'AED')?
          _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
              margin: const EdgeInsets.only(top: 180, bottom: 32, left: 32, right: 32),
              height: 180,
              width: MediaQuery.of(context).size.width - 64,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _currentPosition!,
                  zoom: 14.4746,
                ),
                onMapCreated: _onMapCreated,
              ),
            ) : Container(),
          callDates.isEmpty
              ? conversationRequest.isEmpty ? (role == 'EHBO' || role == 'ListiningEar')
                  ? AspectRatio(
                      aspectRatio: 377 / 307,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/background_header_login.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
              : Container()
              : Container(),
           (role == 'AED')?
           Positioned(
            top: 392, left: 32, right: 32, bottom: 0,
            child: Text(
              AppLocalizations.of(context).translate('completed_calls'),
              style: const TextStyle(
                color: BrandColors.grayMid,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            ) 
           : Container(),
          callDates.isEmpty
              ? conversationRequest.isEmpty
              ? Positioned(
                  bottom: (role == 'AED')? 100 : 180,
                  top: (role == 'AED')? 424 : 180,
                  left: MediaQuery.of(context).size.width / 2 - 125,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ehbokit.png', width: 200, height: 200, fit: BoxFit.fitWidth),
                      Text(
                        AppLocalizations.of(context).translate('you_have_no_calls'),
                        style: const TextStyle(
                          color: BrandColors.blackMid,
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Container(
                margin: const EdgeInsets.only(top: 72),
                child: ListView.builder(
                  itemCount: conversationRequest.length,
                  itemBuilder: (context, index) {
                    return Conversation(
                      option: conversationRequest[index]['option'],
                      applicantContact: conversationRequest[index]['applicantContact'],
                      onButtonPressed: () {
                        Navigator.pushNamed(context, '/conversation');
                      },
                    );
                  },
                ),
              )
              :Container(
                  margin: EdgeInsets.only(top: (role == 'AED')? 408 : 140),
                  child: ListView.builder(
                    itemCount: callDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8, right: 32, left: 32),
                          child: Material(
                            color: Colors.transparent,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: BrandColors.offWhiteDark,
                              surfaceTintColor: BrandColors.offWhiteDark,
                              elevation: 0,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                title: Text(
                                  AppLocalizations.of(context).translate('rate_the_process'),
                                  style: const TextStyle(
                                    color: BrandColors.blackMid,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                subtitle: Text(
                                  "${AppLocalizations.of(context).translate(DateFormat.EEEE().format(DateFormat('dd-MM-yyyy').parse(callDates[index]['date'])))}: ${callDates[index]['date']}",
                                  style: const TextStyle(
                                    color: BrandColors.blackMid,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/rateProcess',
                                      arguments: {
                                        'date': callDates[index]['date'],
                                        'id': callDates[index]['id'],
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit_square,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Column(
            children: <Widget>[
              AppBar(
                centerTitle: (role == 'AED') ? false : true,
                title: Text(
                  (role == 'EHBO')
                      ? AppLocalizations.of(context).translate('completed_calls')
                      : (role == 'AED')
                          ? AppLocalizations.of(context).translate("aed's_in_your_area")
                          : AppLocalizations.of(context).translate('open_requests'),
                  style: const TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: <Widget>[
                  if (role == 'AED')
                    Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.map_outlined,
                          size: 32,
                          color: BrandColors.grayMid,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ),
                  if (role == 'AED' || role == 'EHBO')  
                  Container(
                    margin: const EdgeInsets.only(right: 30.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none_sharp,
                        size: 32,
                        color: BrandColors.grayMid,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                  ),
                ],
                backgroundColor: BrandColors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
              ),
              if (role == 'AED' || role == 'EHBO')
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
