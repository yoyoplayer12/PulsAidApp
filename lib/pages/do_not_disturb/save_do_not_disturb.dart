import 'dart:math';
import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theapp/components/buttons/button_dark_blue.dart';


class SaveDoNotDisturbPage extends StatefulWidget {
  final Map<String, dynamic> formData;

  const SaveDoNotDisturbPage({super.key, required this.formData});

  @override
  // ignore: library_private_types_in_public_api
  _SaveDoNotDisturbPageState createState() => _SaveDoNotDisturbPageState();
}

class _SaveDoNotDisturbPageState extends State<SaveDoNotDisturbPage> with SingleTickerProviderStateMixin {
  final String ambuSvg = 'assets/images/ambu.svg';
  final String weelsSvg = 'assets/images/wheels.svg';

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  bool isUploadSuccessful = false; // Nieuwe variabele om de status van de upload bij te houden

  @override
  void initState() {
    super.initState();
    ApiManager().addDoNotDisturb(widget.formData).then((result) {
      if (result['status'] == 200) {
        _controller.stop(); // Stop de animatie
        setState(() {
          isUploadSuccessful = true; // Update de status
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      ambuSvg,
      semanticsLabel: 'Ambulance',
    );

    return Scaffold(
      backgroundColor: BrandColors.whiteDark,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Transform.rotate(
                            angle: isUploadSuccessful ? 0 : _controller.value * pi / 12 - pi / 24, // Als de upload succesvol is, roteer dan niet
                            child: svg,
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        isUploadSuccessful // Als de upload succesvol is, toon dan een succesbericht
                            ? AppLocalizations.of(context).translate('upload_successful')
                            : AppLocalizations.of(context).translate('saving_certificate'),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(isUploadSuccessful)
              Container(
                height: 71,
                margin: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                child: ElevatedButtonDarkBlue(
                  icon: Icons.arrow_right_alt_rounded,
                  child: Text(AppLocalizations.of(context).translate('go_to_overview'), style: const TextStyle(color: BrandColors.white, fontSize: 16)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/doNotDisturb');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}