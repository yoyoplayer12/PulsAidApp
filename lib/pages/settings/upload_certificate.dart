import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/components/buttons/button_grey_back.dart';
import 'package:theapp/components/buttons/button_blue.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/components/input_field.dart';
import 'package:theapp/components/input_formatters/date_input_formatter.dart';
import 'package:theapp/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theapp/classes/dash_rect_painter.dart';
import 'package:intl/intl.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';


Map<String, dynamic> _formData = {
  'certification': {
    'certification_type': '',
    'certification_number': '',
    'certification_begindate': '',
    'certification_enddate': '',
    'certification': '',
  },
  'role': '',
};


class UploadCertificate extends StatefulWidget {
  final String role;
  const UploadCertificate({super.key, required this.role});


  @override
  // ignore: library_private_types_in_public_api
  _UploadCertificateState createState() => _UploadCertificateState();
}

class _UploadCertificateState extends State<UploadCertificate> {

  final ImagePicker _picker = ImagePicker();
  late String _imageFile = '';    
  Future<void> _pickImage() async {
    // ignore: deprecated_member_use
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    try {
      CloudinaryResponse response = await CloudinaryPublic('duzf7rh6t', 'hxpue88d').uploadFile(
        CloudinaryFile.fromFile(selectedImage!.path, resourceType: CloudinaryResourceType.Image),
      );
      setState(() {
        _imageFile = response.secureUrl;
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
        _formData['certification']['certification_type'] = _typeController.text.trim();
        _formData['role'] = widget.role;
        checkFields();
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
             _formData['certification']['certification_begindate'] = _beginDateController.text.trim();
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
            _formData['certification']['certification_enddate'] = _endDateController.text.trim();
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
      _formData['certification']['certification_number'] = _numberController.text.trim();
      checkFields();
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
    _formData['certification']['certification'] = _imageFile;
    checkFields();
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

  if (_typeNotFilled || _beginDateNotFilled || _endDateNotFilled || _numberNotFilled || _imageNotFilled) {
    return;
  } else {
    setState(() => _allChecked = true);
    Navigator.pushNamed(
      context,
      '/saveCertificate3',
      arguments: _formData,
    );
  }
}

  void checkFields() {
    if(!_checkedType || !_checkedBeginDate || !_checkedEndDate || !_checkedNumber || !_checkedImage) {
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
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child:
            Column(
              mainAxisSize : MainAxisSize.min,
              children: [
                AppBar(
                centerTitle: true,
                title:  Text(
                  AppLocalizations.of(context).translate('add_certificate'),
                  style: const TextStyle(
                    color: BrandColors.grey,
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
                      icon: const Icon(Icons.close, size: 32, color: BrandColors.grey, semanticLabel: 'Exit'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
              ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 16,
                          left: 32,
                          right: 32,
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('upload_certificate_info'),
                          style: const TextStyle(
                            color: BrandColors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
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
              ]),
                  
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
                                  Navigator.pushNamed(context, '/changeType');
                                },
                                child: const Text(''),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: GestureDetector(
                              onTap: checkFieldsAndNavigate,
                              child: ElevatedButtonBlue(
                                onPressed: _allChecked
                                  ? () {
                                      Navigator.pushNamed(
                                        context,
                                        '/saveCertificate3',
                                        arguments: _formData,
                                      );
                                    }
                                  : null,
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
          ], 
          ),
      ),
    ),
    );
  }
}