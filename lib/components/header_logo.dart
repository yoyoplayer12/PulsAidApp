import 'package:flutter/material.dart';

class headerLogo extends StatelessWidget {
  const headerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        child: Stack(
          children: <Widget>[ AspectRatio(
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
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: AspectRatio(
              aspectRatio: 158 / 106,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/logo.png', // replace with your first image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        ],  
        ), 
      );  
           
       
  }
}