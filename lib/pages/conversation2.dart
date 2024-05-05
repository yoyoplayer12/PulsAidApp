import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_dark_blue.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/pages/navpages/home.dart';

class Conversation2 extends StatefulWidget {
  final String option;

  const Conversation2({super.key, required this.option});

  @override
  // ignore: library_private_types_in_public_api
  _Conversation2State createState() => _Conversation2State();
}

class _Conversation2State extends State<Conversation2> {
  final TextEditingController controller = TextEditingController(); // Add this line

  String? errorMessage;
  bool error = false;
  void send(BuildContext context) {
    String input = controller.text;

    if (widget.option == 'email') {
      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)) {
        setState(() {
          errorMessage = 'invalid_email';
          error = true;
        });
        return;
      }
    } else if (widget.option == 'phone') {
      if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(input)) {
        setState(() {
          errorMessage = 'Invalid_phone_number';
          error = true;
        });
        return;
      }
    }
     ApiManager apiManager = ApiManager();
    apiManager.sendConversation(widget.option, input).then((response) {
      if (response['status'] == 'success') {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
      }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 300, // adjust the value as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_header_login.png'), // replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
          child: Stack(
            children:[
              Positioned(
              top: 100,
              child: Container(
                margin: const EdgeInsets.only(left: 32, right: 32),
                width: MediaQuery.of(context).size.width - 64,
                child: Text(
                  AppLocalizations.of(context).translate('information_request_message'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            )],
          ),
          ),
          AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('enter_your_information'),
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
                  icon: const Icon(Icons.close_rounded, size: 32, color: BrandColors.grayMid, semanticLabel: 'close'), // replace with your desired icon
                  onPressed: () {
                    // handle the icon tap here
                    Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
                    ));
                  },
                ),
              ),
            ],
            backgroundColor: Colors.transparent, // make the AppBar background transparent
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 50,
            child: Container(
              width: MediaQuery.of(context).size.width - 64,
              margin: const EdgeInsets.only(right: 32, left: 32), // adjust the value as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate(widget.option),
                      style: const TextStyle(
                        color: BrandColors.grayMid,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                      if (errorMessage != null)
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context).translate( errorMessage!),
                            style: const TextStyle(color: BrandColors.warning),
                          ),
                        ),
                      ),
                  ]),
                      TextField(
                      controller: controller, // Add this line
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: BrandColors.white,
                        hintText: '${AppLocalizations.of(context).translate('enter_your')} ${AppLocalizations.of(context).translate(widget.option)}',
                        hintStyle: const TextStyle(
                          color: BrandColors.grayMid,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: error? const BorderSide(color: BrandColors.warning) : BorderSide(color: BrandColors.grayMid.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: error? const BorderSide(color: BrandColors.warning) : BorderSide(color: BrandColors.grayMid.withOpacity(0.2)),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButtonDarkBlue(
                    icon: Icons.arrow_forward_rounded,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('send'),
                      style: const TextStyle(color: BrandColors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      send(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    );
  }
}
