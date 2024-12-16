import 'package:vendor_pannel/Screens/dashboard.dart';
import 'package:vendor_pannel/Screens/manage.dart';
import 'package:vendor_pannel/Screens/sales.dart';
import 'package:vendor_pannel/Screens/settings.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoustNavigation extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const CoustNavigation({super.key});

  @override
  State<CoustNavigation> createState() => _CoustNavigationState();
}

class _CoustNavigationState extends State<CoustNavigation> {
  final _pageOptions = [
    //
    DashboardScreen(),
    ManageScreen(),
    SalesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> botmnav_list = [];
  int nav_index = 0; // Setting current index to 1 to select search by default

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    botmnav_list = [];
    botmnav_list.add(
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'));
    botmnav_list.add(const BottomNavigationBarItem(
        icon: Icon(Icons.person_2_rounded), label: 'Manage'));
    botmnav_list.add(const BottomNavigationBarItem(
        icon: Icon(Icons.currency_rupee), label: 'Sales'));
    botmnav_list.add(const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: botmnav_list,
          currentIndex: nav_index,
          onTap: (ind) {
            setState(() {
              nav_index = ind;
            });
          }),
      body: _pageOptions[nav_index],
    );
  }
}
