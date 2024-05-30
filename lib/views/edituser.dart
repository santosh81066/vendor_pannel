// import 'dart:io';

// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/getuserprovider.dart';
// import 'package:banquetbookingz/providers/imageprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/usersprovider.dart';
// import 'package:banquetbookingz/views.dart/example.dart';
// import 'package:banquetbookingz/views.dart/loginpage.dart';
// import 'package:banquetbookingz/views.dart/users.dart';
// import 'package:banquetbookingz/widgets/button2.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class EditUser extends ConsumerStatefulWidget {
//   EditUser({super.key});

//   @override
//   ConsumerState<EditUser> createState() => _EditUserState();
// }

// class _EditUserState extends ConsumerState<EditUser> {
//    final FocusNode _focusNodeName = FocusNode();
//   final FocusNode _focusNodeEmail = FocusNode();
  
//   bool _isFocusedName = false;
//   bool _isFocusedEmail = false;
//     @override
//   void initState() {
//     super.initState();
// _focusNodeName.addListener(_handleFocusChangeName);
//     _focusNodeEmail.addListener(_handleFocusChangeEmail);
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
// void _handleFocusChangeName() {
//     if (_focusNodeName.hasFocus != _isFocusedName) {
//       setState(() {
//         _isFocusedName = _focusNodeName.hasFocus;
//       });
//     }
//   }

//   void _handleFocusChangeEmail() {
//     if (_focusNodeEmail.hasFocus != _isFocusedEmail) {
//       setState(() {
//         _isFocusedEmail = _focusNodeEmail.hasFocus;
//       });
//     }
//   }
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
//     return showModalBottomSheet<ImageSource>(
//       context: context,
//       builder: (BuildContext context) {
      
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.camera),
//                 title: const Text('Camera'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.camera),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.gallery),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ScreenHeight=MediaQuery.of(context).size.height;
//     final ScreenWidth=MediaQuery.of(context).size.width;
//       final emailController = ref.watch(selectionModelProvider.select((model) => model.email));
//   final nameController = ref.watch(selectionModelProvider.select((model) => model.name));  
//     final TextEditingController _accountType = TextEditingController(text: "Manager");
//     List<Widget> _pages = [
//       const DashboardWidget(),
//       const Users(),
//       LoginPage()
//     ];
//     return  Scaffold(
//       body: Consumer(builder: (context, ref, child){
//              final _selectedIndex = ref.watch(pageIndexProvider);
//              final AddUser=ref.watch(selectionModelProvider.notifier);
//             return SingleChildScrollView(child: Form(key: _formKey,
//               child: Container(width: ScreenWidth,padding: const EdgeInsets.all(20),
//               color: const Color(0xFFf5f5f5),
//                 child: Column(children: [const SizedBox(height: 20,),
//                   Row(mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                     InkWell(child: const Icon(Icons.arrow_back),onTap: (){
                      
//                       Navigator.of(context).pop();
//                     },),
//                     const Text("Save User",style: TextStyle(color: Color(0XFF6418C3),fontSize: 18),)
//                   ],),
//                   const SizedBox(height: 20,),
//                   Container(
//                                                 padding: const EdgeInsets.all(15),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     const Row(mainAxisAlignment: MainAxisAlignment.start,
//                                                       children: [Text("Profile Photo",style: TextStyle(fontWeight: FontWeight.bold,
//                                                     fontSize: 20,color: Colors.black),)],),
//                                                const SizedBox(height: 15,),
//                                                Consumer(builder: (context, ref, child) {
//                           final pickedImage = ref.watch(imageProvider).profilePic;
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed("uploadphoto");
//                                 },
//                                 child: pickedImage != null
//                                     ? Container(
//                                         width: 150,
//                                         height: 150,
//                                         child: Image.file(File(pickedImage!.path)))
//                                     : Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: const Color(0xFFb0b0b0), width: 2)),
//                                         width: 150,
//                                         height: 150,
//                                         child: Icon(Icons.person,
//                                             color: Colors.grey[700], size: 120),
//                                       ),
//                               ),
//                               const SizedBox(height: 10,),
//                               Text(pickedImage!=null?"":"field required",style: const TextStyle(color: Colors.red,fontSize: 12),)
//                             ],
//                           );
//                         }),
                                                    
                                                    
                                                   
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 20,),
//                                               Container(padding: const EdgeInsets.all(15),
//                                                decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                   const Text("UserName",style: TextStyle(fontWeight: FontWeight.bold,
//                                                   fontSize: 20,color: Colors.black),),
//                                                   const SizedBox(height: 20,),
//                                                   const Text("full Name",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   const SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     textController: nameController,
//                                                     keyBoardType: TextInputType.text,
//                                                  focusNode: _focusNodeName,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedName ? Colors.white : Colors.grey[300],
//                                                     onChanged: (newVlue){
//                                                       controller.updateEnteredName(newVlue);
//                                                     },
//                                                     applyDecoration: true,hintText: "Type here",
//                                                      validator: (value) {
//                                                                             if (value == null || value.isEmpty) {
//                                                                               return 'Field is required';
//                                                                             }
                                                    
                                                                            
//                                                                             return null;
//                                                                           },);}
//                                                   ),
//                                                   const SizedBox(height: 20,),
//                                                    const Text("Email ID",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   const SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     textController: emailController,
//                                                      focusNode: _focusNodeEmail,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedEmail ? Colors.white : Colors.grey[300],
//                                                     keyBoardType: TextInputType.emailAddress,
//                                                     onChanged: (newValue){
//                                                       controller.updateEnteredemail(newValue);
//                                                     },
//                                                     applyDecoration: true,hintText: "Type here",
//                                                      validator: (value) {
//                                                                                   if (value == null || value.isEmpty) {
//                                                                                     return 'Field is required';
//                                                                                   }
//                                                                                   String pattern =
//                                                                                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                                                                   RegExp regex = RegExp(pattern);
//                                                                                   if (!regex.hasMatch(value)) {
//                                                                                     return 'Enter a valid email address';
//                                                                                   }
//                                                                                   return null;
//                                                                                 },);}
//                                                   ),
//                                                   const SizedBox(height: 20,),
//                                                    const Text("Gender",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                    const SizedBox(height:10),
//                                                    Consumer(
//                               builder: (context, ref, child) {
//                                 var selectGender =
//                                     ref.read(selectionModelProvider.notifier);
              
//                                 return
//                                     Row(children: [
//                                       ref.watch(selectionModelProvider).gender == 'm'
//                                           ? CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Male',
//                                               onPressed: () {
//                                                 selectGender.setGender("m");
//                                               },
//                                             )
//                                           : CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Male',
//                                               onPressed: () {
//                                                 selectGender.setGender("m");
//                                               },
//                                               color: Colors.white,
//                                               foreGroundColor: const Color(0xFF6418C3),
//                                               borderColor: const Color(0xFF6418C3),
//                                             ),
//                                       const SizedBox(
//                                         width: 20,
//                                       ),
//                                       ref.watch(selectionModelProvider).gender == 'f'
//                                           ? CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Female',
//                                               onPressed: () {
//                                                 selectGender.setGender("f");
//                                               },
//                                             )
//                                           : CustomGenderButton(
//                                               borderRadius: 5,
//                                               text: 'Female',
//                                               onPressed: () {
//                                                 selectGender.setGender("f");
//                                               },
//                                               color: Colors.white,
//                                               foreGroundColor: const Color(0xFF6418C3),
//                                               borderColor: const Color(0xFF6418C3),
//                                             ),
                                     
//                                     ])
//                                  ;
//                               },
//                             ),
//                             const SizedBox(height: 20,),
//                              const Text("Account Type",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   const SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                    readOnly: true,
//                                                    textController: _accountType,
//                                                     applyDecoration: true,
//                                                      );}
//                                                   ),
              
//                         ],),),
//                  const SizedBox(height: 40,),
//                  Consumer(builder: (context, ref, child) {
//                   final pickedImage = ref.watch(imageProvider).profilePic;
//                   final selection=ref.watch(selectionModelProvider);
//                   final loading=ref.watch(loadingProvider);
//                    return CustomElevatedButton(text: "Save User", borderRadius:10,foreGroundColor: Colors.white,
//                    width: double.infinity,
//                    backGroundColor: const Color(0XFF6418C3),
//                    isLoading: loading,onPressed: loading
//                                 ? null
//                                 : () async {
//                                     if (_formKey.currentState!.validate()&&pickedImage!=null) {
//                                       // If the form is valid, proceed with the login process
                                      
//                                       final UserResult result= await ref.read(usersProvider.notifier).addUser(pickedImage,selection.name.text,
//                                       selection.email.text,selection.gender, ref);
//                                       if(result.statusCode==201){
//                                         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     const Icon(Icons.check_circle, size: 50, color: Color(0XFF6418C3)),
//                     const SizedBox(height: 15),
//                     const Text(
//                       'Suresh Ramesh has been successfully added as a user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     const Text(
//                       'Login details have been mailed to the user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Consumer(builder: (context, ref, child){
//                       final addUser=ref.watch(selectionModelProvider.notifier);
//                       return CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
//                       backGroundColor: const Color(0XFF6418C3),onPressed: (){
                      
//                         Navigator.of(context).pushNamed("users");
//                       },);}
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//                                       }else if (result.statusCode == 400) {
//                                         // If an error occurred, show a dialog box with the error message.
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               title: const Text('Login Error'),
//                                               content: Text(result.errorMessage ??
//                                                   'An unknown error occurred.'),
//                                               actions: <Widget>[
//                                                 TextButton(
//                                                   child: const Text('OK'),
//                                                   onPressed: () {
//                                                     Navigator.of(context)
//                                                         .pop(); // Close the dialog box
//                                                   },
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }
//                                   },);}
//                  )
//                 ],),
//               ),
//             ));}
//           ),
//     )
//     ;
     
//   }
//    @override
//   void dispose() {
//     _focusNodeName.removeListener(_handleFocusChangeName);
//     _focusNodeName.dispose();
//     _focusNodeEmail.removeListener(_handleFocusChangeEmail);
//     _focusNodeEmail.dispose();
    
//     super.dispose();
//   }
// }