import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';


class HeaderImageWithText extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;

  const HeaderImageWithText({super.key, 
    Key? customKey,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
          children: <Widget>[ AspectRatio(
          aspectRatio: 378 / 227,
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
              top: MediaQuery.of(context).size.height * 0.10,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context).translate(title),
                  style: const TextStyle(
                    color: BrandColors.secondaryNight,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context).translate(subtitle),
                  style: const TextStyle(
                    color: BrandColors.blackExtraLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
  }
}