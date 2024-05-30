import 'package:flutter/material.dart';

class ManageCard extends StatelessWidget {
  final IconData? leadingIcon;
  final String? title;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  const ManageCard(
      {super.key, this.leadingIcon, this.title, this.trailingIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
         shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Increased radius
                  ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              leadingIcon,
              size: 50,
              color: Color(0xFF6418c3)
            ),
            title: Text(title!),
            trailing: Icon(
              trailingIcon,
              size: 50,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
