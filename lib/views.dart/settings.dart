// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/usersprovider.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/widgets/stackwidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Settings extends ConsumerStatefulWidget {
//   const Settings({super.key});

//   @override
//   ConsumerState<Settings> createState() => _SettingsState();
// }

// class _SettingsState extends ConsumerState<Settings> {
 
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final logout=ref.watch(authProvider.notifier);
//     final usersData=ref.watch(authProvider);
    
//     print("$usersData");
//     return Scaffold(body: Column(children: [
//       StackWidget( text: "Settings"),
//       Container(padding: EdgeInsets.fromLTRB(30,20,30,30),color: Color(0xFFf5f5f5),height: screenHeight*0.675,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//         Container(padding: EdgeInsets.all(13),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(12),
//                                           color: Colors.white,
//                                         ),
//                                         child: Row(children: [
                                          
//                                       Stack(
                                    
//                                     alignment: Alignment.bottomRight,
//                                     children: <Widget>[
//                                       Container(
//                                        decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(8),
//                                           color: Color.fromARGB(255, 235, 221, 221),
//                                           border: Border.all(
//       color: Color(0xFF6418c3), // Border color
//       width: 1.0, // Border width
//     ),
//                                         ),
//                                         child: Icon(
//                                           Icons.person,
//                                           color: Color(0xFF6418c3),
//                                           size: 50.0,
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
                                          
//                                         ),
//                                         child: Icon(
//                                           Icons.local_police_sharp,
//                                           color: Colors.purple,
//                                           size: 20.0,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
                                     
//                                     SizedBox(width: 15,),
//                                      Text("No data")   ],),),
//                                     SizedBox(height: 20,),
//                                     TextButton(onPressed: (){
//                                       Navigator.of(context).pushNamed("editprofile");
//                                     },  child: Text("EditProfile",style: TextStyle(color: Color(0xff000000),fontSize: 15),)),
//                                     SizedBox(height: 20,),
//                                     TextButton( onPressed: (){},  child: Text("Wallet",style: TextStyle(color: Color(0xff000000),fontSize: 15),)),
//                                     SizedBox(height: 20,),
//                                     TextButton( onPressed: ()async{
//                                        await logout. logoutUser();
                                            
//                                     },  child: Text("Logout",style: TextStyle(color: Color(0xff000000),fontSize: 15),))
//       ],),)
//     ],));
//   }
// }