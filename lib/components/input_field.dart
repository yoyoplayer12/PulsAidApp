import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool isPassword;
  final bool small;
  final TextCapitalization textCapitalization;
  final bool hasError;
  final bool checked;
  final bool readOnly;
  final String? errorMessage;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.inputFormatters,
    required this.isPassword,
    this.small = false,
    this.textCapitalization = TextCapitalization.none,
    this.hasError = false,
    this.checked = false,
    this.readOnly = false,
    this.errorMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: widget.small ? 0 : 32,
        right: widget.small ? 0 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate(widget.labelText),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: BrandColors.grey,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  readOnly: widget.readOnly,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  cursorColor: BrandColors.greyExtraLight,
                  style: const TextStyle(
                    color: BrandColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  focusNode: widget.focusNode,
                  onSubmitted: widget.onSubmitted,
                  textCapitalization: widget.textCapitalization,
                  obscureText: widget.isPassword ? _obscureText : false,
                  decoration: InputDecoration(
                    fillColor: widget.hasError ? BrandColors.semanticsTomato.withOpacity(0.1) : Colors.white,
                    filled: widget.hasError,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: BrandColors.greyExtraLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.checked ? BrandColors.semanticApple : BrandColors.greyExtraLight.withOpacity(0.2),
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: widget.checked ? BrandColors.semanticApple : BrandColors.greyExtraLight.withOpacity(0.2),
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: BrandColors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : null,
                  ),
                ),
                if (widget.hasError && widget.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.errorMessage!,
                      style: const TextStyle(color: BrandColors.semanticsTomato, fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
