import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';
import 'package:theapp/main.dart';
import 'package:theapp/components/certificates.dart';


class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CertificatesState createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  String name = '';
  User? user;

  //logincheck
  @override
  void initState() {
    super.initState();
    if (false == GlobalVariables.loggedin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/language');
      });
    }else{
      getUserInfo();
    }
  }

  Future<void> getUserInfo() async {
    final userInfo = await ApiManager().userInfo();
    setState(() {
      if (userInfo["user"]["certifications"] != null) {
        List<Certificate> certificates = [];

        // Create a User object from the certificates
        user = User(certifications: certificates);
      } else {
        print(userInfo);
        print("No certifications found for the user");
      }
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
          selectedIndex: 3,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addcertificate');
          },
          backgroundColor: BrandColors.secondaryExtraDark,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32, color: BrandColors.offWhiteLight,),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title:  Text(
                  AppLocalizations.of(context).translate('certificates'),
                  style: const TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: Colors.transparent, // make the AppBar background transparent
                elevation: 0, // remove shadow
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: user!.certifications.length,
                  itemBuilder: (context, index) {
                    var certificate = user!.certifications[index];
                    return Certificate(
                      title: certificate.title,
                      endDate: certificate.endDate,
                      onButtonPressed: () {
                        print('Button pressed for certificate ${certificate.title}!');
                      },
                    );
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

class User {
  List<Certificate> certifications;

  User({required this.certifications});
}