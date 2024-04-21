import 'package:flutter/material.dart';

import '../widgets/stackwidget.dart';

class VenderWidget extends StatefulWidget {
  const VenderWidget({super.key});

  @override
  State<VenderWidget> createState() => _VendersWidgetState();
}

class _VendersWidgetState extends State<VenderWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(children: [ StackWidget(hintText: "Search with vendor name", text: "Vendors",onTap: (){
            Navigator.of(context).pushNamed("addvendor");
          },arrow: Icons.arrow_back,),],);
  }
}