import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/app_localizations.dart';


class CustomCheckBox extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color borderColor;

  const CustomCheckBox({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.borderColor = BrandColors.secondaryExtraDark,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: 32,
          right: 32,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor, // Set the border color
            width: 2, // Set the border width
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context).translate(widget.text),
                  style: const TextStyle(
                    color: BrandColors.grayLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Radio<bool>(
                value: true,
                groupValue: widget.value,
                onChanged: (bool? value) {
                  widget.onChanged(value);
                },
                fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}