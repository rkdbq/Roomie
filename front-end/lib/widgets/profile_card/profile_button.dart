import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
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
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      onPressed: widget.onPressed,
      icon: Icon(
        widget.iconData,
        color: Colors.white,
      ),
      label: Text(
        widget.labelText,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
