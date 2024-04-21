// import 'dart:io';




// import '/providers/selectionmodal.dart';
// import '/providers/usersprovider.dart';







// import '/widgets/stackwidget.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';


// class ManageBookings extends ConsumerStatefulWidget {
//   const ManageBookings({super.key});

//   @override
//   ConsumerState<ManageBookings> createState() => _UsersState();
// }

// class _UsersState extends ConsumerState<ManageBookings> {
//   @override
//   void initState() {
//     super.initState();
//     // Call getUsers() when the widget is inserted into the widget tree
//     ref.read(usersProvider.notifier).getUsers();
//     // ref.read(getUserProvider.notifier).getProfilePic();
//     Future.microtask(() {
//       // Get the ID passed via arguments
     
//       final id = ModalRoute.of(context)?.settings.arguments as int?;
//       print(id);
//       final ids=ref.read(selectionModelProvider).userIndex;
//       print(ids);
//       // Get user details from your state notifier
//       final user = ref.read(usersProvider.notifier).getUserById(ids!);

//       if (user != null) {
//         // Update the controllers with the user's data
//         ref.read(selectionModelProvider.notifier).updateEnteredemail(user.emailId ?? '');
//         ref.read(selectionModelProvider.notifier).updateEnteredName(user.firstName ?? '');
//       //    if (user.profilepic != null) {
//       //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
//       // }
//         // ... do the same for other fields
//       }
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     List<bool> isSelected = [true, false, false, false];
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     final usersData=ref.watch(usersProvider);
    

//     return Scaffold(body:  Consumer(builder: (context, ref, child) {

//       final selection=ref.watch(selectionModelProvider.notifier);
//     ref.watch(usersProvider);
//       return SingleChildScrollView(
//         child:  Column(children: [
//           StackWidget(hintText: "Search users", text: "Users",onTap: (){
//             Navigator.of(context).pushNamed("adduser");
//           },arrow: Icons.arrow_back,),
//           Container(width: screenWidth,
          
//           padding: EdgeInsets.all(30),color: Color(0xFFf5f5f5),
//             child: Column(children: [
//               Container(padding: EdgeInsets.all(5),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(50),
//                                           color: Colors.white,
//                                         ),
//                                         child: ToggleButtons(
//           borderColor: Colors.white,
//           fillColor: Colors.transparent,
//           borderWidth: 0.0,
//           selectedBorderColor: Colors.white,
//           isSelected: isSelected,
//           onPressed: (index) {
//             setState(() {
//         for (int i = 0; i < isSelected.length; i++) {
//           isSelected[i] = i == index;
//         }
//             });
//           },
//           children: [
//             _buildToggleButton('New', isSelected[0]),
//             _buildToggleButton('Admin', isSelected[1]),
//             _buildToggleButton('Moderator', isSelected[2]),
//             _buildToggleButton('All', isSelected[3]),
//           ],
//         ),
//         ),SizedBox(height: 20,),
//               Consumer(builder: (con, ref, child) {
                
                
//                 return usersData.data==null?Container(height: screenHeight,width: screenWidth,color:Color(0xfff5f5f5),
//                 child: Center(child: Text("No data available",style: TextStyle(color: Color(0xffb4b4b4),fontSize: 17),)),): 
//                  Container(padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white,
//                                       ),
//                    child: SingleChildScrollView(
//                      child: Column(
//                        children: [
//                          ListView.builder(
//                            shrinkWrap: true, // Important to work inside a Column
                            
//                                 itemCount: usersData.data!.length,
//                                 itemBuilder: (context, index) {
//                                   final user = usersData.data![index];
//                                   return SingleChildScrollView(
//                                     child: Column(
//                                       children: [
//                                         Column(
//                                           children: [
//                                             InkWell(
//                                               onTap: (){
//                                                 ref.watch(selectionModelProvider.notifier).subDetails(true);
//                                               },
//                                               child: ListTile(
//                                           leading: InkWell(
//                                             onTap: () {
//                                                 ref.read(usersProvider.notifier).getUserPic(context, ref, user.id!);
//                                             },
//                                             child: Stack(
//                                                   alignment: Alignment.center,
//                                                 children: [
//                                                   CircleAvatar(
//   radius: 35,
//   child: Stack(
//     alignment: Alignment.center,
//     children: [
//       user.xfile != null 
//         ? Container() // Empty container when xfile is not null
//         : Icon(Icons.person, size: 35), // replace with your preferred icon
//       Text('View Profile Pic',style: TextStyle(fontSize: 8)), // Your existing Text widget
//     ],
//   ),
//   backgroundImage: user.xfile != null 
//     ? FileImage(File(user.xfile!.path)) 
//     : null, // No background image when xfile is null
// ),
//                                                   // InkWell(
//                                                   //   onTap: () {
//                                                   //     ref.read(usersProvider.notifier).getUserPic(context, ref, user.id!);
//                                                   //     // Call the function to show the user's profile picture.
//                                                   //     // Assuming `fetchUserProfilePic` is a function that you define to make the API call.
//                                                   //     // fetchUserProfilePic();
//                                                   //   },
//                                                   //   child: Text('View Profile Pic',style: TextStyle(fontSize: 8),),
//                                                   // ),
//                                                 ],
//                                               ),
//                                           ),// Placeholder for profile picture
//                                                 title: Text(user.firstName!??"no name"),
//                                                 subtitle: Text(user.userrole=="m"?"manager":"user"),
//                                                 trailing: IconButton(
//                                                      icon: Icon(Icons.edit,color: Colors.purple,),
//                                                      onPressed: () {
//                                                                int? userId = usersData.data![index].id;
//                                                          selection.userIndex(userId);
//                                                          Navigator.of(context).pushNamed("edituser");
//                                                 //  Navigator.of(context).pushNamed("edituser",arguments: userId);  
//                                                 //  ref.watch(getUserProvider.notifier).getProfilePic(userId.toString());        // Add action for edit icon press
//                                                      },
//                                                 ),
//                                               ),
//                                             ),
//                                             Divider(thickness: 1,)
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                        ],
//                      ),
//                    ),
//                  );}
//               ),],),
//           )
//         ],)
//        ,
//       );}
//     ),
//     //
//     );
//   }
// }
// Widget _buildToggleButton(String text, bool isSelected) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 8),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 16,
//         color: isSelected ? Colors.purple : Colors.black,
//         decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
//       ),
//     ),
//   );
// }
