import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/components/buttons/buttons_socials.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/pages/navpages/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key});

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
        selectedIndex: 0,
      ),
    ),  
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
          Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context).translate('conversation_options'),
                  style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, size: 32, color: BrandColors.grey, semanticLabel: 'close'), // replace with your desired icon
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
            ],
          ),
          Positioned(
            top: 250,
            child: Container(
              width: MediaQuery.of(context).size.width - 64,              
              margin: const EdgeInsets.only(right: 32, left: 32), // adjust the value as needed
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: (MediaQuery.of(context).size.width - 64 ) / 2 - 12.5,                  
                        child: ElevatedButtonDarkBlue(
                          icon: Icons.mail_outline_rounded,
                          child: Text(
                            AppLocalizations.of(context).translate("email"),
                            style: const TextStyle(color: BrandColors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/conversation2", arguments: "email");
                          },
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: (MediaQuery.of(context).size.width - 64 )/ 2 - 12.5,                  
                        child: ElevatedButtonDarkBlue(
                          icon: Icons.phone_outlined,
                          child: Text(
                            AppLocalizations.of(context).translate("phone"),
                            style: const TextStyle(color: BrandColors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/conversation2", arguments: "phone");
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32), // Add some spacing
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16), // Add this line
                        child: SocialButtons(
                          platform: "messenger",  // Replace with the Messenger icon
                          child: "Messenger",
                          onPressed: () async {
                            // open messenger on user
                            Navigator.pushNamed(context, "/conversationLoader", arguments: "facebook");
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16), // Add this line
                        child: SocialButtons(
                          platform: "instagram", // Replace with the Instagram icon
                          child: "Instagram",
                          onPressed: () async {
                            // Handle the button press
                            Navigator.pushNamed(context, "/conversationLoader", arguments: "instagram");
                            
                          },
                        ),
                      ),
                      SocialButtons(
                        platform: "whatsapp", // Replace with the WhatsApp icon
                        child: "WhatsApp",
                        onPressed: () async {
                          // Handle the button press
                          //full international style phonenumber
                          const phonenumber = "32475716186";
                          final Uri instaurl = Uri.parse("https://wa.me/$phonenumber?text=urlencodedtext");
                          if (await canLaunchUrl(instaurl)) {
                            await launchUrl(instaurl);
                          } else {
                            throw 'Could not launch $instaurl';
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}