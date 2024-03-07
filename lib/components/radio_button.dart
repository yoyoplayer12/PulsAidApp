import 'package:flutter/material.dart';
import 'package:theapp/colors.dart';

class RadioButton extends StatefulWidget {
  final String text;
  final String groupValue;
  final String value;
  final ValueChanged<String?> onChanged;

  const RadioButton({
    Key? key,
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
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
          border: Border.all(
            color: BrandColors.secondaryExtraDark, // Set the border color
            width: 2, // Set the border width
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  color: BrandColors.grayLight,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<String>(
                value: widget.value,
                groupValue: widget.groupValue,
                onChanged: widget.onChanged,
                fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
              ),
            ],
          ),
        ),
      ),
    );

  
  }
}