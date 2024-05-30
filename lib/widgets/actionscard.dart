import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Card(
        
        elevation: 2,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            // Handle your tap here
            print('Tapped on $label');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Allows the column to size itself to the height of its children
              mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Centers children horizontally
              children: [
                Icon(icon, size: 40,color: Color(0xFF6418C3),), // Icon
                SizedBox(height: 8), // Spacing between icon and text
                Flexible( // Makes the text flexible within the available space
                  child: Text(
                    label,
                    textAlign: TextAlign.center, // Center-align text
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                    softWrap: true, // Allows text wrapping
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
