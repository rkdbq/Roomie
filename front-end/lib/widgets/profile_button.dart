import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
  final Color backgroundColor;
  final IconData iconData;
  final String labelText;
  const ProfileButton({
    super.key,
    required this.backgroundColor,
    required this.iconData,
    required this.labelText,
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
      onPressed: () => print(widget.labelText),
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
