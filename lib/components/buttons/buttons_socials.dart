import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theapp/colors.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String platform;
  final String child;

  const SocialButtons({
    super.key,
    this.onPressed,
    required this.platform,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    // ignore: deprecated_member_use
    IconData icon = FontAwesomeIcons.questionCircle; // Assign a default value

    if (platform == 'instagram') {
      iconColor = Colors.red;
      icon = FontAwesomeIcons.instagram;
    } else if (platform == 'messenger') {
      iconColor = Colors.blue;
      icon = FontAwesomeIcons.facebookMessenger;
    } else if (platform == 'whatsapp') {
      iconColor = Colors.green;
      icon = FontAwesomeIcons.whatsapp;
    } else {
      iconColor = Colors.black;
    }

  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: iconColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Change this
      children: [
        Text(
          "Chat in $child", // Replace with your text variable
          style: const TextStyle(color: BrandColors.grayMid),
        ),
        Icon(
          icon, // Use the FontAwesome icon
          color: iconColor,
        ),
      ],
    ),
  );
  }
}