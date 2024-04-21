// import 'package:banquetbookingz/providers/imageprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/usersprovider.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//    final FocusNode _focusNodePassword = FocusNode();
//   final FocusNode _focusNodeEmail = FocusNode();
//    final FocusNode _focusNodeCUPassword = FocusNode();
//   final FocusNode _focusNodeChangePass = FocusNode();
//    final FocusNode _focusNodeConfirmPass = FocusNode();
  
  
//   bool _isFocusedPassword = false;
//   bool _isFocusedEmail = false;
//   bool _isFocusedCUPassword = false;
//   bool _isFocusedChangePass = false;

// bool _isFocusedConfirmPass = false;
  
//   @override
//   void initState() {
//     super.initState();
//     _focusNodePassword.addListener(_handleFocusChangePassword);
//     _focusNodeEmail.addListener(_handleFocusChangeEmail);
//      _focusNodePassword.addListener(_handleFocusChangeCUPassword);
//     _focusNodeEmail.addListener(_handleFocusChangeChangePass);
//      _focusNodePassword.addListener(_handleFocusChangeConfirmPass);
    
//   }

//   void _handleFocusChangePassword() {
//     if (_focusNodePassword.hasFocus != _isFocusedPassword) {
//       setState(() {
//         _isFocusedPassword = _focusNodePassword.hasFocus;
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
//    void _handleFocusChangeCUPassword() {
//     if (_focusNodeCUPassword.hasFocus != _isFocusedCUPassword) {
//       setState(() {
//         _isFocusedCUPassword = _focusNodeCUPassword.hasFocus;
//       });
//     }
//   }

//   void _handleFocusChangeChangePass() {
//     if (_focusNodeChangePass.hasFocus != _isFocusedChangePass) {
//       setState(() {
//         _isFocusedChangePass = _focusNodeChangePass.hasFocus;
//       });
//     }
//   }
//    void _handleFocusChangeConfirmPass() {
//     if (_focusNodeConfirmPass.hasFocus != _isFocusedConfirmPass) {
//       setState(() {
//         _isFocusedConfirmPass = _focusNodeConfirmPass.hasFocus;
//       });
//     }
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     final ScreenHeight=MediaQuery.of(context).size.height;
//     final ScreenWidth=MediaQuery.of(context).size.width;
//     return Scaffold(body: SingleChildScrollView(
//       child: Form(key: _formKey,
//         child: Container(
//           width: ScreenWidth,padding: EdgeInsets.all(20),
//                 color: Color(0xFFf5f5f5),
//           child: Column(children: [Container(child: Consumer(builder: (context, ref, child){
//             return AppBar(leading: IconButton(onPressed: (){
//               ref.watch(selectionModelProvider.notifier).changePassword(false);
//                     Navigator.of(context).pop();
//                    }, icon: Icon(Icons.arrow_back,color: Color(0XFF6418C3),)),
//                    backgroundColor: Color(0xfff5f5f5),
//                 title: Text("Edit Profile",style: TextStyle(color: Color(0XFF6418C3),fontSize: 20),),);}
//           )),
//                   SizedBox(height: 20,),
//                    Container(padding: EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(12),
//                                             color: Colors.white,
//                                           ),
//                                           child: Row(children: [
                                            
//                                        Stack(
                                      
//                                       alignment: Alignment.bottomRight,
//                                       children: <Widget>[
//                                         Container(
//                                          decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(8),
//                                             color: Color.fromARGB(255, 235, 221, 221),
//                                             border: Border.all(
//         color: Color(0xFF6418c3), // Border color
//         width: 1.0, // Border width
//             ),
//                                           ),
//                                           child: Icon(
//                                             Icons.person,
//                                             color: Color(0xFF6418c3),
//                                             size: 50.0,
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             shape: BoxShape.circle,
                                            
//                                           ),
//                                           child: Icon(
//                                             Icons.local_police_sharp,
//                                             color: Colors.purple,
//                                             size: 20.0,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
                                       
//                                       SizedBox(width: 15,),
//                                        Text("No data")   ],),),
//                                        SizedBox(height: 20,),
//                                                        Container(padding: EdgeInsets.all(15),
//                                                decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
                                                 
                                                  
//                                                    Text("Email ID",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     keyBoardType: TextInputType.emailAddress,
//                                                      focusNode: _focusNodeEmail,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedEmail ? Colors.white : Colors.grey[300],
//                                                     onChanged: (newValue){
//                                                       controller.updateAdminEmail(newValue);
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
//                                                   SizedBox(height: 20,),
                                                 
//                                                   Text("Password",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                   SizedBox(height: 10,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final controller=ref.watch(selectionModelProvider.notifier);
//                                                     return CustomTextFormField(width: ScreenWidth*0.8,
//                                                     keyBoardType: TextInputType.visiblePassword,
//                                                      focusNode: _focusNodePassword,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedPassword ? Colors.white : Colors.grey[300],
//                                                     onChanged: (newVlue){
//                                                       controller.updateAdminPassword(newVlue);
//                                                     },
//                                                     applyDecoration: true,hintText: "Type here",
//                                                      validator: (value) {
//                                                                             if (value == null || value.isEmpty) {
//                                                                               return 'Field is required';
//                                                                             }
                                                    
                                                                            
//                                                                             return null;
//                                                                           },);}
//                                                   ),
//                                                   SizedBox(height: 20,),
//                                                   Consumer(builder: (context, ref, child){
//                                                     final changePass=ref.watch(selectionModelProvider.notifier);
//                                                     return TextButton(onPressed: (){
//                                                       changePass.changePassword(true);
//                                                     }, child:Text("Change Password",style: TextStyle(color:Color(0xFF6418c3)),));})  
              
//                         ],),),
//                         SizedBox(height: 20,),
//                         Consumer(builder: (context, ref, child){
//                           final changePass=ref.watch(selectionModelProvider).changePassword;
//                           return changePass==true? Container(padding: EdgeInsets.all(15),
//                                                  decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(10),
//                                                     color: Colors.white,
//                                                   ),
//                                                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
                                                   
                                                    
//                                                      Text("Current Password",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                     SizedBox(height: 10,),
//                                                     Consumer(builder: (context, ref, child){
//                                                       final controller=ref.watch(selectionModelProvider.notifier);
//                                                       return CustomTextFormField(width: ScreenWidth*0.8,
//                                                       keyBoardType: TextInputType.emailAddress,
//                                                        focusNode: _focusNodeCUPassword,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedCUPassword? Colors.white : Colors.grey[300],
//                                                       onChanged: (newValue){
//                                                         controller.updateEnteredemail(newValue);
//                                                       },
//                                                       applyDecoration: true,hintText: "Type here",
//                                                        validator:(value) {
//                                                                               if (value == null || value.isEmpty) {
//                                                                                 return 'Field is required';
//                                                                               }
                                                      
                                                                              
//                                                                               return null;
//                                                                             },);}
//                                                     ),
//                                                     SizedBox(height: 20,),
                                                   
//                                                     Text("New Password",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                     SizedBox(height: 10,),
//                                                     Consumer(builder: (context, ref, child){
//                                                       final controller=ref.watch(selectionModelProvider.notifier);
//                                                       return CustomTextFormField(width: ScreenWidth*0.8,
//                                                       keyBoardType: TextInputType.visiblePassword,
//                                                        focusNode: _focusNodeChangePass,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedChangePass ? Colors.white : Colors.grey[300],
//                                                       onChanged: (newVlue){
//                                                         controller.updateEnteredName(newVlue);
//                                                       },
//                                                       applyDecoration: true,hintText: "Type here",
//                                                        validator: (value) {
//                                                                               if (value == null || value.isEmpty) {
//                                                                                 return 'Field is required';
//                                                                               }
                                                      
                                                                              
//                                                                               return null;
//                                                                             },);}
//                                                     ),
//                                                     SizedBox(height: 20,),
//                                                     Text("Conform Password",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                     SizedBox(height: 10,),
//                                                     Consumer(builder: (context, ref, child){
//                                                       final controller=ref.watch(selectionModelProvider.notifier);
//                                                       return CustomTextFormField(width: ScreenWidth*0.8,
//                                                       keyBoardType: TextInputType.visiblePassword,
//                                                        focusNode: _focusNodeConfirmPass,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedConfirmPass ? Colors.white : Colors.grey[300],
//                                                       onChanged: (newVlue){
//                                                         controller.updateEnteredName(newVlue);
//                                                       },
//                                                       applyDecoration: true,hintText: "Type here",
//                                                        validator: (value) {
//                                                                               if (value == null || value.isEmpty) {
//                                                                                 return 'Field is required';
//                                                                               }
                                                      
                                                                              
//                                                                               return null;
//                                                                             },);}
//                                                     ),
                                                     
                                      
//                           ],),):Container();
//                           }
//                         ),
//                         SizedBox(height: 20,),
//                  Consumer(builder: (context, ref, child) {
//                   final pickedImage = ref.watch(imageProvider).profilePic;
//                   final selection=ref.watch(selectionModelProvider);
//                   final loading=ref.watch(loadingProvider);
//                    return CustomElevatedButton(text: "Save", borderRadius:10,foreGroundColor: Colors.white,
//                    width: double.infinity,
//                    backGroundColor: Color(0XFF6418C3),
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
//                 padding: EdgeInsets.all(20),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Icon(Icons.check_circle, size: 50, color: Color(0XFF6418C3)),
//                     SizedBox(height: 15),
//                     Text(
//                       'Suresh Ramesh has been successfully added as a user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text(
//                       'Login details have been mailed to the user.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Consumer(builder: (context, ref, child){
//                       final addUser=ref.watch(selectionModelProvider.notifier);
//                       return CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
//                       backGroundColor: Color(0XFF6418C3),onPressed: (){
                         
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
//                                               title: Text('Login Error'),
//                                               content: Text(result.errorMessage ??
//                                                   'An unknown error occurred.'),
//                                               actions: <Widget>[
//                                                 TextButton(
//                                                   child: Text('OK'),
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
//                         ],)),
//       ),
//     ),);
//   }
//   @override
//   void dispose() {
//     _focusNodePassword.removeListener(_handleFocusChangePassword);
//     _focusNodePassword.dispose();
//     _focusNodeEmail.removeListener(_handleFocusChangeEmail);
//     _focusNodeEmail.dispose();
//     _focusNodeCUPassword.removeListener(_handleFocusChangeCUPassword);
//     _focusNodeCUPassword.dispose();
//     _focusNodeChangePass.removeListener(_handleFocusChangeChangePass);
//     _focusNodeChangePass.dispose();
//     _focusNodeConfirmPass.removeListener(_handleFocusChangeConfirmPass);
//     _focusNodeConfirmPass.dispose();
    
    
//     super.dispose();
//   }
// }