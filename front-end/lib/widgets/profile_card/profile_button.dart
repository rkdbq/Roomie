import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData iconData;
  final String labelText;
  final Function() onPressed;

  const ProfileButton({
    super.key,
    required this.backgroundColor,
    required this.iconData,
    required this.labelText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      label: Text(
        labelText,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
