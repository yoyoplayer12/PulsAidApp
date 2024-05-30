import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:theapp/classes/registration_data.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/components/progressbar.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';
import 'package:theapp/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theapp/classes/dash_rect_painter.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';


Map<String, dynamic> _formData = {
      'type': '',
      'number': '',
      'begindate': '',
      'enddate': '',
      'certification': '',
      'privacy': false,
};


class EhboRegistration3Page extends StatefulWidget {
  const EhboRegistration3Page({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _EhboRegistrationPage3State createState() => _EhboRegistrationPage3State();
}

class _EhboRegistrationPage3State extends State<EhboRegistration3Page> {

  final ImagePicker _picker = ImagePicker();
  String _imageFile = "";
  String _image = '';
    
  Future<void> _pickImage() async {
    // ignore: deprecated_member_use
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    try {
      CloudinaryResponse response = await CloudinaryPublic('duzf7rh6t', 'hxpue88d').uploadFile(
        CloudinaryFile.fromFile(selectedImage!.path, resourceType: CloudinaryResourceType.Image),
      );
      setState(() {
        _imageFile = response.secureUrl;
        _image= response.secureUrl;
      });
    } catch (e) {

        if (e is DioException) {
      } else {
     }
    }
    _onImageFocusChange();
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

  bool _checkedType = false;
  bool _typeNotFilled = false;
  bool _checkedBeginDate = false;
  bool _beginDateNotFilled = false;
  bool _checkedEndDate = false;
  bool _endDateNotFilled = false;
  bool _checkedNumber = false;
  bool _numberNotFilled = false;
  bool _allChecked = false;
  bool _checkedImage = false;
  bool _imageNotFilled = false;
  bool checkedValue = false;
  String _beginDateError = '';
  String _endDateError = '';


  @override
  void initState() {
    super.initState();
    _typeFocus.addListener(() {
      if (_typeFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _beginDateFocus.addListener(() {
      if (_beginDateFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _endDateFocus.addListener(() {
      if (_endDateFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(50.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _numberFocus.addListener(() {
      if (_numberFocus.hasFocus && _scrollController.hasClients) {
        _scrollController.animateTo(100.0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    });
    _typeFocus.addListener(_onTypeFocusChange);
    _beginDateFocus.addListener(_onBeginDateFocusChange);
    _endDateFocus.addListener(_onEndDateFocusChange);
    _numberFocus.addListener(_onNumberFocusChange);
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

  void _onTypeFocusChange() {
    if (!_typeFocus.hasFocus) {
      if(_typeController.text.trim().isEmpty) {
        setState(() {
          _checkedType = false;
        });
      }else{
        setState(() {
          _checkedType = true;
        });
        _formData['type'] = _typeController.text.trim();
        Provider.of<RegistrationData>(context, listen: false).updateCertificationData(0, 'certification_type', _typeController.text.trim());
      }
    }
  }

void _onBeginDateFocusChange() {
  if (!_beginDateFocus.hasFocus) {
    if(_beginDateController.text.trim().isEmpty) {
      setState(() {
        _checkedBeginDate = false;
      });
    } else {
        DateTime enteredDate = DateFormat('dd/MM/yyyy').parse(_beginDateController.text.trim());

        DateTime tenYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 10));

        if (enteredDate.isAfter(tenYearsAgo) && enteredDate.isBefore(DateTime.now())) {
          setState(() {
            _checkedBeginDate = true;
            _beginDateError = '';
            _formData['begin_date'] = _beginDateController.text.trim();
        Provider.of<RegistrationData>(context, listen: false).updateCertificationData(0, 'certification_begindate', _beginDateController.text.trim());
        checkFields();
          });
        } else {
          setState(() {
            _checkedBeginDate = false;
            _beginDateError = AppLocalizations.of(context).translate("invalid_date");
          });
        }
    }
  }
}

void _onEndDateFocusChange() {
  if (!_endDateFocus.hasFocus) {
    if(_endDateController.text.trim().isEmpty) {
      setState(() {
        _checkedEndDate = false;
      });
    } else {
        DateTime enteredDate = DateFormat('dd/MM/yyyy').parse(_endDateController.text.trim());
        DateTime beginDate = DateFormat('dd/MM/yyyy').parse(_beginDateController.text.trim());


        DateTime tenYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 10));
        DateTime tenYearsFromNow = DateTime.now().add(const Duration(days: 365 * 10));

        if (enteredDate.isAfter(tenYearsAgo) && enteredDate.isAfter(beginDate) && enteredDate.isBefore(tenYearsFromNow)) {
          setState(() {
            _endDateError = '';
            _checkedEndDate = true;
            _formData['end_date'] = _endDateController.text.trim();
            Provider.of<RegistrationData>(context, listen: false).updateCertificationData(0, 'certification_enddate', _endDateController.text);
            checkFields();
          });
        } else {
          setState(() {
            _endDateError = AppLocalizations.of(context).translate("invalid_date");
            _checkedEndDate = false;
          });
        }
    }
  }
}

void _onNumberFocusChange() {
  if (!_numberFocus.hasFocus) {
    if(_numberController.text.trim().isEmpty) {
      setState(() {
        _checkedNumber = false;
      });
    } else {
      setState(() {
        _checkedNumber = true;
      });
      _formData['number'] = _numberController.text.trim();
      Provider.of<RegistrationData>(context, listen: false).updateCertificationData(0, 'certification_number', _numberController.text);
    }
  }
}

void _onImageFocusChange() {
  if (_imageFile == "") {
    setState(() {
      _checkedImage = false;
    });
  } else {
    setState(() {
      _checkedImage = true;
    });
    _formData['image'] = _image;
    Provider.of<RegistrationData>(context, listen: false).updateCertificationData(0, 'certification', _image);
  }
}

  void checkFieldsAndNavigate() {
  setState(() {
    _typeNotFilled = !_checkedType;
    _beginDateNotFilled = !_checkedBeginDate;
    _endDateNotFilled = !_checkedEndDate;
    _numberNotFilled = !_checkedNumber;
    _imageNotFilled = !_checkedImage;
  });

  if (_typeNotFilled || _beginDateNotFilled || _endDateNotFilled || _numberNotFilled || _imageNotFilled || !checkedValue) {
    return;
  } else {
    setState(() => _allChecked = true);
    Navigator.pushNamed(context, '/saveRegistration');
  }
}

  void checkFields() {
    if(!_checkedType || !_checkedBeginDate || !_checkedEndDate || !_checkedNumber || !_checkedImage || !checkedValue) {
      setState(() {
        _allChecked = false;
      });
    } else {
      setState(() {
        _allChecked = true;
      });
    }
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
            Container(
              padding: const EdgeInsets.only(
                bottom: 150,
              ),
              child: 
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
                          checked: _checkedType,
                          hasError: _typeNotFilled,
                          errorMessage: _typeNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
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
                                child:
                                CustomInputField(
                                  labelText: 'begin_date',
                                  small: true,
                                  hintText: 'dd/mm/yyyy',
                                  isPassword: false,
                                  keyboardType: TextInputType.datetime,
                                  controller: _beginDateController,
                                  focusNode: _beginDateFocus,
                                  checked: _checkedBeginDate,
                                  hasError: _beginDateNotFilled || _beginDateError.isNotEmpty,
                                  errorMessage: _beginDateError.isNotEmpty ? _beginDateError : _beginDateNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                                  inputFormatters: [DateInputFormatter()],
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
                              child: 
                                CustomInputField(
                                  labelText: 'end_date',
                                  small: true,
                                  hintText: 'dd/mm/yyyy',
                                  isPassword: false,
                                  keyboardType: TextInputType.datetime,
                                  checked: _checkedEndDate,
                                  controller: _endDateController,
                                  focusNode: _endDateFocus,
                                  hasError: _endDateNotFilled || _endDateError.isNotEmpty,
                                  errorMessage: _endDateError.isNotEmpty ? _endDateError : _endDateNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                                  inputFormatters: [DateInputFormatter()],
                                  onSubmitted: (String value) {
                                    _numberFocus.requestFocus();
                                  },
                                ),
                            ),
                          ],
                          ),
                          CustomInputField(
                            labelText: 'number_certification',
                            hintText: '',
                            isPassword: false,
                            keyboardType: TextInputType.text,
                            controller: _numberController,
                            focusNode: _numberFocus,
                            checked: _checkedNumber,
                            hasError: _numberNotFilled,
                            errorMessage: _numberNotFilled ? AppLocalizations.of(context).translate("required_field") : null,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('.*'))],
                            onSubmitted: (String value) {},
                          ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 32,
                            right: 32,
                          ),
                          child: Stack(
                          alignment: Alignment.topLeft,
                          children:[
                          Text(
                            AppLocalizations.of(context).translate('upload_certificate'),
                            style: const TextStyle(
                              color: BrandColors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: _pickImage,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 32,
                                ),
                                height: 140, // Set the size of the square box
                                width: 140, // Set the size of the square box
                                child: CustomPaint(
                                painter: DashRectPainter(color: _checkedImage ? Colors.green : _imageNotFilled? Colors.red : Colors.grey),                              
                                child: _imageFile == ""
                                      ? const Icon(Icons.add_photo_alternate_outlined, size: 44, color: BrandColors.greyLight,) // Show camera icon if no image is selected
                                      :Image.network(_imageFile, width: 140, height: 140, fit: BoxFit.cover), // Show the selected image
                                ),
                              ),
                            ),
                          ),
                          if(_imageNotFilled)
                          Container(
                            margin: const EdgeInsets.only( top: 180),
                            child: Text(
                              AppLocalizations.of(context).translate("required_field"),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32,),
                    Theme(
                       data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                  color: states.contains(MaterialState.selected)
                                      ? BrandColors.secondaryNight
                                      : BrandColors.secondaryNight, // Change this to your desired unselected border color
                                ),
                              ),
                              checkColor: MaterialStateProperty.all(BrandColors.white),
                            ),
                        unselectedWidgetColor: BrandColors.secondaryNight, // Change this to your desired color
                        ), 
                      child:
                      CheckboxListTile(
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: BrandColors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Proxima-Soft'
                              ),
                            children: <TextSpan>[
                              TextSpan(text:  AppLocalizations.of(context).translate( 'i_agree_to_the')),
                              TextSpan(
                                text: AppLocalizations.of(context).translate('privacy_policy_and_terms_of_use'),
                                style: const TextStyle(fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/privacy');
                                  },
                              ),
                            ],
                          ),
                        ),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            _formData['privacy'] = newValue!;
                            Provider.of<RegistrationData>(context, listen: false).updateFormData('privacy', newValue.toString() );
                            checkedValue = newValue;
                            checkFields();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        activeColor: BrandColors.secondaryNight,
                      ),
                    ),
                ]),
                    
                ],
              ),
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
                                  Navigator.pushNamed(context, '/ehboRegistration2');
                                },
                                child: const Text(''),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: GestureDetector(
                              onTap: checkFieldsAndNavigate,
                              child: ElevatedButtonBlue(
                                onPressed: 
                                  _allChecked
                                  ? () {
                                    Navigator.pushNamed(context, '/saveRegistration');
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
                child: const DotProgressBar(totalSteps: 4, currentStep: 4),
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