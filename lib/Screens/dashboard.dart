import 'package:vendor_pannel/Colors/coustcolors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: CoustColors.colrFill,
   );
  }
}