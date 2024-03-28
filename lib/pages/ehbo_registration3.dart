import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';
import 'package:theapp/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theapp/classes/dash_rect_painter.dart';


class EhboRegistration3Page extends StatefulWidget {
  const EhboRegistration3Page({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _EhboRegistrationPage3State createState() => _EhboRegistrationPage3State();
}

class _EhboRegistrationPage3State extends State<EhboRegistration3Page> {

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
    
  Future<void> _pickImage() async {
    // ignore: deprecated_member_use
    final PickedFile? selectedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = selectedImage;
    });
  }

  final ScrollController _scrollController = ScrollController();
  final FocusNode _typeFocus = FocusNode();
  final FocusNode _beginDateFocus = FocusNode();
  final FocusNode _endDateFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _beginDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeFocus.addListener(() {
      if (_typeFocus.hasFocus) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _beginDateFocus.addListener(() {
      if (_beginDateFocus.hasFocus) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _endDateFocus.addListener(() {
      if (_endDateFocus.hasFocus) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _numberFocus.addListener(() {
      if (_numberFocus.hasFocus) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
  }

    @override
  void dispose() {
    _typeFocus.dispose();
    _beginDateFocus.dispose();
    _endDateFocus.dispose();
    _numberFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      resizeToAvoidBottomInset: false,
      body:  SafeArea(child:
      Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        height: MediaQuery.of(context).size.height,
        child:
          Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child:
            Column(
              mainAxisSize : MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context).translate('registration'),
                  style: const TextStyle(
                    color: BrandColors.secondaryNight,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  AppLocalizations.of(context).translate('certification_information'),
                  style: const TextStyle(
                    color: BrandColors.blackExtraLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      CustomInputField(
                        labelText: 'Type_certification',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _typeController,
                        focusNode: _typeFocus,
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                        onSubmitted: (String value) {
                          _beginDateFocus.requestFocus();
                        },
                      ),
                      Row(            
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5 - 8 - 32,
                            margin: const EdgeInsets.only(
                              right: 8,
                              left: 32,
                            ),
                              child: CustomInputField(
                                labelText: 'begin_date',
                                small: true,
                                hintText: 'dd/mm/yyyy',
                                isPassword: false,
                                keyboardType: TextInputType.datetime,
                                controller: _beginDateController,
                                focusNode: _beginDateFocus,
                                inputFormatters: [ DateInputFormatter() ],
                                onSubmitted: (String value) {
                                  _numberFocus.requestFocus();
                                },
                            ),
                          ),
                           Container(
                            width: MediaQuery.of(context).size.width * 0.5 - 8 - 32,
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 32,
                            ),
                              child: CustomInputField(
                                labelText: 'end_date',
                                small: true,
                                hintText: 'dd/mm/yyyy',
                                isPassword: false,
                                keyboardType: TextInputType.datetime,
                                controller: _endDateController,
                                focusNode: _endDateFocus,
                                inputFormatters: [ DateInputFormatter() ],
                                onSubmitted: (String value) {
                                  _numberFocus.requestFocus();
                                },
                            ),
                          )
                        ],
                      ),
                      CustomInputField(
                        labelText: 'number_certification',
                        hintText: '',
                        isPassword: false,
                        keyboardType: TextInputType.text,
                        controller: _numberController,
                        focusNode: _numberFocus, onSubmitted: (String value) {  },
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp('.*'))],
                      ), 
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 16,
                              left: 32,
                              right: 32,
                            ),
                            height: 140, // Set the size of the square box
                            width: 140, // Set the size of the square box
                            child: CustomPaint(
                              painter: DashRectPainter(),
                              child: _imageFile == null
                                  ? const Icon(Icons.add_photo_alternate_outlined, weight: 200, color: BrandColors.grayLightDark,) // Show camera icon if no image is selected
                                  : Image.file(
                                      File(_imageFile!.path),
                                      fit: BoxFit.cover, // Use BoxFit.cover to make the image fill the box
                                    ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                  
              ],
            ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.10,
              child:
            Container(
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
                            SizedBox(
                              width: 88,
                              child: ElevatedButtonGreyBack(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/ehbo_registration2');
                                },
                                child: const Text(''),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: ElevatedButtonBlue(
                                onPressed: 
                                  _typeController.text.isNotEmpty &&
                                  _beginDateController.text.isNotEmpty &&
                                  _endDateController.text.isNotEmpty &&
                                  _numberController.text.isNotEmpty &&
                                  _imageFile != null
                                  ? () {
                                    Navigator.pushNamed(context, '/ehbo_registration3');
                                  } : null,
                                arrow: true,
                                textleft: true,
                                child: Builder(
                                  builder: (BuildContext context) {
                                    return Text(
                                      AppLocalizations.of(context).translate('done'),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            ),
            Positioned(
            bottom: 32,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                alignment: Alignment.center,
                child: const DotProgressBar(currentStep: 4),
              ),
            ),
          ),
          ], 
          ),
      ),
    ),
    );
  }
}