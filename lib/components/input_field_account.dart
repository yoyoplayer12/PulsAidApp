import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  bool obscureText;
  final String original;
  final String errorText;
  final List<TextInputFormatter> inputFormatters;

  CustomTextField({super.key, required this.controller, required this.label, required this.hint, this.obscureText = false, required this.original, this.errorText = "", required this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate(label),
                  style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              cursorColor: BrandColors.greyExtraLight,
              cursorRadius: const Radius.circular(10),
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
              decoration: InputDecoration(
                filled: errorText.isNotEmpty,
                fillColor: BrandColors.semanticsTomato.withOpacity(0.1),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: BrandColors.greyExtraLight.withOpacity(0.2),
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: BrandColors.greyExtraLight.withOpacity(0.2),
                    width: 2.0,
                  ),
                ),
                hintText: AppLocalizations.of(context).translate(hint),
                contentPadding: const EdgeInsets.all(10.0),
                suffixIcon: value.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.text = original;
                          FocusScope.of(context).unfocus();
                        },
                      )
                    : null,
              ),
            ),
             if (errorText.isNotEmpty)
              Text(
                AppLocalizations.of(context).translate(errorText),
                style: const TextStyle(color: BrandColors.semanticsTomato),
              ),
          ],
        );
      }
    );
  }
}