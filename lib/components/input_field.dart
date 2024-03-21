import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/app_localizations.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  // ignore: use_key_in_widget_constructors
  const CustomInputField({
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        margin: const EdgeInsets.only(
          top: 12,
          left: 32,
          right: 32,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate(labelText),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 4,
            ),// You can adjust this value as needed
            child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

