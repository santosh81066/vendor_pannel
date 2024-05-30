import 'package:flutter/material.dart';
import 'package:vendor_pannel/widgets/actionscard.dart';

class QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('Quick actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Row(
              children: [
                ActionCard(icon: Icons.person, label: 'Manage\nBookings'),
                ActionCard(icon: Icons.home, label: 'Manage\nProperties'),
                ActionCard(icon: Icons.money, label: 'Manage\nTransactions'),
                // Add more cards as needed
              ],
            ),
          ),
        ),
      ],
    );
  }
}
