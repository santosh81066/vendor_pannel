

import 'package:vendor_pannel/widgets/mamagecard.dart';


import '../widgets/stackwidget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class Manage extends ConsumerStatefulWidget {
  const Manage({super.key});

  @override
  ConsumerState<Manage> createState() => _ManageState();
}

class _ManageState extends ConsumerState<Manage> {
  @override
 

   


  @override
  Widget build(BuildContext context) {
 
    
   
    return Scaffold(body:  Consumer(builder: (context, ref, child) {
      
      return Column(children: [
        StackWidget(hintText: "Search users", text: "Manage",onTap: (){
          Navigator.of(context).pushNamed("adduser");
        },arrow: Icons.arrow_back,),
        const ManageCard(leadingIcon: Icons.person,title: "Manage Bookings",trailingIcon: Icons.arrow_right,),
         ManageCard(leadingIcon: Icons.store,title: "Manage Properties",trailingIcon: Icons.arrow_right,onTap: (){Navigator.of(context).pushNamed("manageproperties");},),
        const ManageCard(leadingIcon: Icons.currency_rupee,title: "Manage Transactions",trailingIcon: Icons.arrow_right,),
             const ManageCard(leadingIcon: Icons.calendar_today,title: "Manage Calender",trailingIcon: Icons.arrow_right,)
      ],);}
    ),
    //
    );
  }
}
Widget _buildToggleButton(String text, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: isSelected ? Colors.purple : Colors.black,
        decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
      ),
    ),
  );
}
