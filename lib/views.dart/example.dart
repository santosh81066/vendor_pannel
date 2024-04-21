// import 'package:banquetbookingz/models/getuser.dart';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getuserprovider.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/views.dart/dashboard.dart';
// import 'package:banquetbookingz/views.dart/dashboardpage.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/views.dart/mainpage.dart';
// import 'package:banquetbookingz/views.dart/settings.dart';
// import 'package:banquetbookingz/views.dart/subscription.dart';
// import 'package:banquetbookingz/views.dart/subscriptionchart.dart';
// import 'package:banquetbookingz/views.dart/users.dart';
// import 'package:banquetbookingz/widgets/custompaint.dart';

// import 'package:banquetbookingz/widgets/stackwidget.dart';
// import 'package:banquetbookingz/widgets/subscriptions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fl_chart/fl_chart.dart';

// import '../widgets/recentvenders.dart';
// import 'vendors.dart';


// class DashboardWidget extends StatelessWidget {
//   const DashboardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//      List<Widget> _pages = [
//       const DashboardWidget(),
//       const Users(),
//       const VenderWidget(),
//       const Subscription(),
//       const Settings(),
      

//     ];

//     return Scaffold(
        
//         body: Consumer(builder: (context, ref, child) {
//            final _selectedIndex = ref.watch(pageIndexProvider);
//            final dashboard=ref.watch(selectionModelProvider).dashboard;
//           //  final get=ref.watch(getUserProvider.notifier);
//           return _selectedIndex==0 && dashboard==true? SingleChildScrollView(
//             child: Column(children: [const StackWidget(hintText: 'Search with user or vendor name', text: "Banquet Bookz",
//             ),
//             Container(padding: const EdgeInsets.all( 40),color: const Color(0xFFf5f5f5),
//               child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.all(15),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             color: Colors.white,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Container(
//   decoration: const BoxDecoration(
//     color: Color(0xffdfecf2), // Container's background color
//     shape: BoxShape.circle, // Making the container circular
//   ),padding: const EdgeInsets.all(10),
//   child: const Icon(
//     Icons.person, // The person icon
//     color: Color(0xff5dcfff), // Icon color
//     size: 30.0, // Icon size
//   ),),
//                                               const Text(
//                                                 "12",
//                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                               ),
//                                               const Text(
//                                                 "new vendors",
//                                                 style: TextStyle(fontSize: 15),
//                                               )
//                                             ],
//                                           ),
//                                         ),
                                        
//                                         Container(
//                                           padding: const EdgeInsets.all(15),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             color: Colors.white,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Container(
//   decoration: const BoxDecoration(
//     color: Color(0xffffcff2), // Container's background color
//     shape: BoxShape.circle, // Making the container circular
//   ),
//   child: const Icon(
//     Icons.person, // The person icon
//     color: Color(0xffe328af), // Icon color
//     size: 30.0, // Icon size
//   ),
//   padding: const EdgeInsets.all(10), // Padding to create space around the icon inside the container
// ),

//                                               const Text(
//                                                 "42",
//                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                               ),
//                                               const Text(
//                                                 "subscribed",
//                                                 style: TextStyle(fontSize: 15),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 15),
//                                     Container(
//                                       padding: const EdgeInsets.all(20),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: const Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "14 subscriptions",
//                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                                               ),
//                                               Text(
//                                                 "in last month",
//                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                                               ),
//                                               Text(
//                                                 "Total earned ₹10000 in",
//                                                 style: TextStyle(fontSize: 15),
//                                               ),
//                                               Text(
//                                                 "last 30 days",
//                                                 style: TextStyle(fontSize: 15),
//                                               )
//                                             ],
//                                           ),
//                                           Icon(
//                                             Icons.person,
//                                             size: 50,
//                                             color: Color(0XFF6418C3),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
                                   
//                                     const SizedBox(height: 15),
//                                     Container(
//                                       padding: const EdgeInsets.all(15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           const Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   Text("Earnings", style: TextStyle(fontSize: 25)),
//                                                   Text("₹89,928", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
//                                                 ],
//                                               ),
//                                               Text("Last 7 Days", style: TextStyle(fontSize: 15))
//                                             ],
//                                           ),
//                                           const SizedBox(height: 15,),
//                                          SizedBox(
//   height: screenHeight * 0.2,
//   width: screenWidth * 0.7,
//   child: LineChart(
//     LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true, // Enable the vertical grid lines
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Color(0xff37434d), // Color for vertical lines
//             strokeWidth: 1,
//           );
//         },
//         // getDrawingHorizontalLine: (value) {
//         //   return FlLine(
//         //     color: const Color(0xff37434d), // Color for horizontal lines
//         //     strokeWidth: 1,
//         //   );
//         // },
//       ),
//       titlesData: const FlTitlesData(show: false),
//       borderData: FlBorderData(show: false),
//       minX: 0,
//       maxX: 2,
//       minY: 0,
//       maxY: 10,
//       lineBarsData: [
//         LineChartBarData(
//           spots: [
//             const FlSpot(0, 1),
//             const FlSpot(1, 3),
//             const FlSpot(2, 10),
//             // Add other spots here
//           ],
//           isCurved: true,
//           color: Colors.blue, // Line color
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(show: false),
//           belowBarData: BarAreaData(show: false),
//         ),
//       ],
//     ),
//   ),
// )



//                                         ],
//                                       ),
//                                     ),
                                    
//                                     const SizedBox(height: 15),
//                                     Container(
//                                       padding: const EdgeInsets.all(15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               const Text(
//                                                 "Recent Vendors",
//                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   // Your action here
//                                                 },
//                                                child: const Row(children: [
//                                                 Text("View All",style: TextStyle(color: Color(0XFF6418C3)),),
//                                                 Icon(Icons.arrow_forward,color: Color(0XFF6418C3),)
//                                                ],),
//                                                 style: ElevatedButton.styleFrom(
//                                                   foregroundColor: const Color(0XFF6418C3), // Background color
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(10.0), 
//                                                     side: const BorderSide(color: Color(0XFF6418C3),width: 1),
//                                                   // The rounded corners
//                                                   ),
//                                                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(height: 20),
                                          
//                                           const VendersWidget(text1: 'Swagat Grand Banquet Hall',
//                                           text2: 'Bachupally, Hyderabad',text3:'Registered on Aug 25, 2023' ,)
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(height: 15,),
//                                    Container(
//                                       padding: const EdgeInsets.all(15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Center(
//                                         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 const Text(
//                                                   "Recent Vendors",
//                                                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                                 ),
//                                                  ElevatedButton(
//                                                 onPressed: () {
//                                                   // Your action here
//                                                 },
//                                                child: const Row(children: [
//                                                 Text("View All",style: TextStyle(color: Color(0XFF6418C3)),),
//                                                 Icon(Icons.arrow_forward,color: Color(0XFF6418C3),)
//                                                ],),
//                                                 style: ElevatedButton.styleFrom(
//                                                   foregroundColor: const Color(0XFF6418C3), // Background color
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(10.0), 
//                                                     side: const BorderSide(color: Color(0XFF6418C3),width: 1),
//                                                   // The rounded corners
//                                                   ),
//                                                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // The padding inside the button
//                                                 ),
//                                               )
//                                               ],
//                                             ),
//                                             const SizedBox(height: 20),
                                           
//                                            const SubscriptionsWidget(text1: 'Swagat Grand Banquet Hall', text2: 'Bachupally, Hyderabad', text3: 'Start:25th Feb, 2024', text4: 'End:25th Mar, 2024')
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 15,),
//                                      Container(
//                                       padding: const EdgeInsets.all(15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child:
//                                     Column(
//                                       children: [const Row(mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           Text("Subscription Ratio",style: TextStyle(fontWeight: FontWeight.bold,
//                                           fontSize: 20),),
//                                         ],
//                                       ),
//                                         SizedBox(height: 310,
//                                         width: screenWidth*0.8,
//                                           child: MySubscriptionRatioChart()),
//                                           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                             children: [
//                                           Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Row(children: [
//                                                 Container(height: 20,width: 20,
//                                                 color: const Color(0xFF6418C3),),const SizedBox(width: 10,),
//                                                 const Text("Pro-25%",style: TextStyle(fontWeight: FontWeight.bold,
//                                                 ),)
//                                               ],),
//                                               const SizedBox(height: 15,),
//                                                Row(children: [
//                                                 Container(height: 20,width: 20,
//                                                 color: const Color(0XFF5DCFFF),),const SizedBox(width: 10,),
//                                                 const Text("Expert-25%",style:  TextStyle(fontWeight: FontWeight.bold,
//                                                 ))
//                                               ],),
//                                             ],
//                                           ),
                                          
//                                           Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Row(children: [
//                                                 Container(height: 20,width: 20,
//                                                 color: const Color(0XFFE328AF),),const SizedBox(width: 10,),
//                                                 const Text("Basic-25%",style: TextStyle(fontWeight: FontWeight.bold,
//                                                 ),)
//                                               ],),const SizedBox(height: 15,),
//                                                Row(children: [
//                                                 Container(height: 20,width: 20,
//                                                 color: const Color(0xFFC4C4C4),),const SizedBox(width: 10,),
//                                                 const Text("Pro-Plus-25%",style:  TextStyle(fontWeight: FontWeight.bold,
//                                                 ))
//                                               ],),
//                                             ],
//                                           )])

//                                       ],
//                                     )
//                                     ),
//                                     const SizedBox(height: 15,),
//                                      Container(
//                                       padding: const EdgeInsets.all(15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                                       child: Center(
//                                         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             const Row(mainAxisAlignment: MainAxisAlignment.start,
//                                               children: [
//                                                 Text("Top Subscriptions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 10),
//                                             Center(
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                  Container(padding: const EdgeInsets.all(10),
//                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                                    color: const Color(0XFFEEE1FF),),
                                                
//                                                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                   Text("Basic(54%)",style: TextStyle(color: Color(0XFF6418C3))),
//                                                   Text("50",style: TextStyle(color: Color(0XFF6418C3)),)
//                                                  ],),),
//                                                  const SizedBox(height: 5,),
//                                                   Container(padding: const EdgeInsets.all(10),
//                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                                    color: const Color(0XFFEEE1FF),),
                                                
//                                                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                   Text("Pro(11%)",style: TextStyle(color: Color(0XFF6418C3))),
//                                                   Text("21",style: TextStyle(color: Color(0XFF6418C3)),)
//                                                  ],),),
//                                                  const SizedBox(height: 5,),
//                                                   Container(padding: const EdgeInsets.all(10),
//                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                                    color: const Color(0XFFEEE1FF),),
                                                
//                                                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                   Text("Pro Plus(20%)",style: TextStyle(color: Color(0xff6418c3))),
//                                                   Text("18",style: TextStyle(color: Color(0xff6418c3)),)
//                                                  ],),),
//                                                  const SizedBox(height: 5,),
//                                                   Container(padding: const EdgeInsets.all(10),
//                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//                                                    color: const Color(0xffeee1ff),),
                                                
//                                                  child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                   Text("Bsic(20%)",style: TextStyle(color: Color(0xff6418c3))),
//                                                   Text("18",style: TextStyle(color: Color(0xff6418c3)),)
//                                                  ],),)
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   const SizedBox(height: 30,),
//                                   const Column(children: [
//                                     Text("BanquetBookz Admin Dashboard",style: TextStyle(color: Color(0xFFb4b4b4,),
//                                     fontWeight: FontWeight.bold,fontSize: 18),),
//                                      Text("Made with in india by GoCode Creations",style: TextStyle(color: Color(0xFFb4b4b4,),
//                                     fontSize: 13),)
//                                   ],)
                                
//                                   ],
//                                 ),
//             ) 
              
//             ],),
//           ):_pages.elementAt(_selectedIndex);}
//         ),
//         bottomNavigationBar: Consumer(builder: (context, ref, child){
//              final _selectedIndex = ref.watch(pageIndexProvider);
//               return BottomNavigationBar(
//                       items: const <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               label: 'Dashboard',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.people),
//               label: 'Users',
//                         ),
//               //           BottomNavigationBarItem(
//               // icon: Icon(Icons.business),
//               // label: 'Vendors',
//               //           ),
//               BottomNavigationBarItem(
//               icon: Icon(Icons.store),
//               label: 'Vendors',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.subscriptions),
//               label: 'Subs',
//                         ),
//                         BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//                         ),
//                       ],
//                       onTap: (index) {
//           // This is where you update the index
          
//           ref.read(pageIndexProvider.notifier).setPage(index);
//         },
//                       currentIndex: _selectedIndex,
//                       selectedItemColor: const Color(0xff6418c3),
//                       unselectedItemColor: Colors.grey,
                      
//                       type: BottomNavigationBarType.fixed,
//                     );}
//             ),
//       );
//   }
// }