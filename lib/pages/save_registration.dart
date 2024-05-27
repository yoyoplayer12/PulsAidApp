import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';

class SaveRegistrationPage extends StatefulWidget {
  const SaveRegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SaveRegistrationPageState createState() => _SaveRegistrationPageState();
}

class _SaveRegistrationPageState extends State<SaveRegistrationPage> {
  int _currentIndex = 0;
  bool _saved = false; // Updated to track saved status

  @override
  Widget build(BuildContext context) {
    final registrationData = Provider.of<RegistrationData>(context).formData;

    if(_saved == false) { // Check if data is not saved
      ApiManager apiManager = ApiManager();
      apiManager.createUser(registrationData as Map<String, dynamic>).then((result) {
        if (result['status'] == 200) {
          setState(() {
            _saved = true; // Update saved status
          });
        } 
      });
    }

    TextSpan parseText(String text) {
      final List<TextSpan> spans = [];
      final RegExp regExp = RegExp(r'\*\*(.*?)\*\*');
      final matches = regExp.allMatches(text);

      int lastMatchEnd = 0;
      for (final match in matches) {
        if (match.start > lastMatchEnd) {
          spans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: const TextStyle(
              color: BrandColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ));
        }
        spans.add(TextSpan(
          text: match.group(1),
          style: const TextStyle(
            color: BrandColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ));
        lastMatchEnd = match.end;
      }
      if (lastMatchEnd < text.length) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd),
          style: const TextStyle(
            color: BrandColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ));
      }

      return TextSpan(children: spans);
    }

    List<Map<String, String>> pages = [
      {
        'image': 'assets/images/tutorial1.png',
        'text': 'get_a_notification_and_start_resuscitation',
        'width': '220',
      },
      {
        'image': 'assets/images/tutorial2.png',
        'text': 'adjust_your_availability_to_“do_not_disturb”,_so_you_will_not_receive_a_notification_at_these_times.',
        'width': '270',
      },
      {
        'image': 'assets/images/tutorial3.png',
        'text': 'refresh_your_first_aid_knowledge_with_the_instructions.',
        'width': '220',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: pages.length,
                  options: CarouselOptions(
                    height: 483,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Image.asset(
                      pages[index]['image']!,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.parse(pages[_currentIndex]['width']!),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: parseText(AppLocalizations.of(context).translate(pages[_currentIndex]['text']!)),
                  ),
                ),
                _saved // Check if data is saved
                    ? const SizedBox(height: 40)
                    : const SizedBox.shrink(), // Use SizedBox.shrink() to remove empty space
                _saved
                    ? Container(
                        margin: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                        ),
                        width: MediaQuery.of(context).size.width - 64,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 88,
                                  child: Text(''),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: ElevatedButtonBlue(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    arrow: true,
                                    textleft: true,
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        return Text(
                                          AppLocalizations.of(context).translate('login'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(), // Use SizedBox.shrink() to remove empty space
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: DotProgressBar(
                currentStep: _currentIndex + 1,
                totalSteps: pages.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
