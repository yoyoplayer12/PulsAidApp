import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/app_localizations.dart';

class RadioButton extends StatefulWidget {
  final String text;
  final String groupValue;
  final String value;
  final ValueChanged<String?> onChanged;
  final Color borderColor;

  const RadioButton({
    super.key,
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.borderColor = BrandColors.secondaryNightDark,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: 32,
          right: 32,
        ),
        decoration: BoxDecoration(
          color: widget.groupValue == widget.value ? BrandColors.secondaryNightExtraLight.withOpacity(0.48) : BrandColors.whiteLight,
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
                  style: TextStyle(
                    color:  widget.groupValue == widget.value? BrandColors.greyDark : BrandColors.greyLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Radio<String>(
                value: widget.value,
                groupValue: widget.groupValue,
                onChanged: widget.onChanged,
                fillColor: MaterialStateProperty.all(BrandColors.secondaryNightDark),
              ),
            ],
          ),
        ),
      ),
    );

  
  }
}