import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';

class CertificateDetailPage extends StatelessWidget {
  final Map<String, dynamic> certificate;

  CertificateDetailPage({required this.certificate});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
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
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title:  Text(
                  certificate['certification_type'],
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
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           const Text(
                              'Begin datum:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dateFormat.format(DateTime.parse(certificate['certification_begindate'])),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           const Text(
                              'Einddatum:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dateFormat.format(DateTime.parse(certificate['certification_enddate'])),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.network(certificate['certification'], width: MediaQuery.of(context).size.width - 64, height: MediaQuery.of(context).size.height - 413, fit: BoxFit.cover, semanticLabel: 'Certificate image'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}