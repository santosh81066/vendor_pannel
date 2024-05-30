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

// class AddUser extends StatefulWidget {
//   const AddUser({super.key});

//   @override
//   State<AddUser> createState() => _AddUserState();
// }

// class _AddUserState extends State<AddUser> {
//   final FocusNode _focusNodeName = FocusNode();
//   final FocusNode _focusNodeEmail = FocusNode();
  
//   bool _isFocusedName = false;
//   bool _isFocusedEmail = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNodeName.addListener(_handleFocusChangeName);
//     _focusNodeEmail.addListener(_handleFocusChangeEmail);
//   }

//   void _handleFocusChangeName() {
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
//                 leading: Icon(Icons.camera),
//                 title: Text('Camera'),
//                 onTap: () => Navigator.of(context).pop(ImageSource.camera),
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
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
    
//     final TextEditingController _accountType = TextEditingController(text: "Manager");
//     List<Widget> _pages = [
//       DashboardWidget(),
//       Users(),
//       LoginPage()
//     ];
//     return  Scaffold(
//       body: Consumer(builder: (context, ref, child){
//            final _selectedIndex = ref.watch(pageIndexProvider);
//            final AddUser=ref.watch(selectionModelProvider.notifier);
//                final pickedImage = ref.watch(imageProvider).profilePic;
//                 final loading=ref.watch(loadingProvider);
//                   final selection=ref.watch(selectionModelProvider);
//           return SingleChildScrollView(child: Form(key: _formKey,
//             child: Container(width: ScreenWidth,padding: EdgeInsets.all(20),
//             color: Color(0xFFf5f5f5),
//               child: Column(children: [
//                Container(child: AppBar(leading: IconButton(onPressed: (){
//                 Navigator.of(context).pop();
//                }, icon: Icon(Icons.arrow_back,color: Color(0XFF6418C3),)),
//                backgroundColor: Color(0xfff5f5f5),
//             title: Text("Add User",style: TextStyle(color: Color(0XFF6418C3),fontSize: 20),),)),
//                 SizedBox(height: 20,),
//                 Container(
//                                               padding: EdgeInsets.all(15),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 color: Colors.white,
//                                               ),
//                                               child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Row(mainAxisAlignment: MainAxisAlignment.start,
//                                                     children: [Text("Profile Photo",style: TextStyle(fontWeight: FontWeight.bold,
//                                                   fontSize: 20,color: Colors.black),)],),
//                                              SizedBox(height: 15,),
//                                              Consumer(builder: (context, ref, child) {
//                         final pickedImage = ref.watch(imageProvider).profilePic;
//                         return Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).pushNamed("uploadphoto");
//                               },
//                               child: pickedImage != null
//                                   ? Container(
//                                       width: 150,
//                                       height: 150,
//                                       child: Image.file(File(pickedImage.path)))
//                                   : Container(
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: Color(0xFFb0b0b0), width: 2)),
//                                       width: 150,
//                                       height: 150,
//                                       child: Icon(Icons.person,
//                                           color: Colors.grey[700], size: 120),
//                                     ),
//                             ),
//                             SizedBox(height: 10,),
//                             Text(pickedImage!=null?"":"field required",style: TextStyle(color: Colors.red,fontSize: 12),)
//                           ],
//                         );
//                       }),
                                                  
                                                  
                                                 
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(height: 20,),
//                                             Container(padding: EdgeInsets.all(15),
//                                              decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(10),
//                                                 color: Colors.white,
//                                               ),
//                                               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                 Text("UserName",style: TextStyle(fontWeight: FontWeight.bold,
//                                                 fontSize: 20,color: Colors.black),),
//                                                 SizedBox(height: 20,),
//                                                 Text("full Name",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                 SizedBox(height: 10,),
                                
//                                                    CustomTextFormField(width: ScreenWidth*0.8,
//                                                   keyBoardType: TextInputType.text,
//                                                   focusNode: _focusNodeName,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedName ? Colors.white : Colors.grey[300],
//                                                   onChanged: (newVlue){
//                                                     AddUser.updateEnteredName(newVlue);
//                                                   },
//                                                   applyDecoration: true,hintText: "Type here",
//                                                    validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },),
                                           
//                                                 SizedBox(height: 20,),
//                                                  Text("Email ID",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                 SizedBox(height: 10,),
                                          
//                                                    CustomTextFormField(width: ScreenWidth*0.8,
//                                                   keyBoardType: TextInputType.emailAddress,
//                                                   focusNode: _focusNodeEmail,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedEmail ? Colors.white : Colors.grey[300],
//                                                   onChanged: (newValue){
//                                                     AddUser.updateEnteredemail(newValue);
//                                                   },
//                                                   applyDecoration: true,hintText: "Type here",
//                                                    validator: (value) {
//                                                                                 if (value == null || value.isEmpty) {
//                                                                                   return 'Field is required';
//                                                                                 }
//                                                                                 String pattern =
//                                                                                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                                                                 RegExp regex = RegExp(pattern);
//                                                                                 if (!regex.hasMatch(value)) {
//                                                                                   return 'Enter a valid email address';
//                                                                                 }
//                                                                                 return null;
//                                                                               },),
//                                           SizedBox(height: 20,),
//                                                  Text("Password",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                 SizedBox(height: 10,),
                                          
//                                                    CustomTextFormField(width: ScreenWidth*0.8,
//                                                textController: selection.password,
//                                                   readOnly: true,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedEmail ? Colors.white : Colors.grey[300],
                                                 
//                                                   applyDecoration: true
//                                                   ),
//                                                 SizedBox(height: 20,),
//                                                  Text("Gender",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                  SizedBox(height:10),
//                                                  Row(children: [
//                                     ref.watch(selectionModelProvider).gender == 'm'
//                                         ? CustomGenderButton(
//                                             borderRadius: 5,
//                                             text: 'Male',
//                                             onPressed: () {
//                                               AddUser.setGender("m");
//                                             },
//                                           )
//                                         : CustomGenderButton(
//                                             borderRadius: 5,
//                                             text: 'Male',
//                                             onPressed: () {
//                                              AddUser.setGender("m");
//                                             },
//                                             color: Colors.white,
//                                             foreGroundColor: Color(0xFF6418C3),
//                                             borderColor: Color(0xFF6418C3),
//                                           ),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     ref.watch(selectionModelProvider).gender == 'f'
//                                         ? CustomGenderButton(
//                                             borderRadius: 5,
//                                             text: 'Female',
//                                             onPressed: () {
//                                               AddUser.setGender("f");
//                                             },
//                                           )
//                                         : CustomGenderButton(
//                                             borderRadius: 5,
//                                             text: 'Female',
//                                             onPressed: () {
//                                              AddUser.setGender("f");
//                                             },
//                                             color: Colors.white,
//                                             foreGroundColor: Color(0xFF6418C3),
//                                             borderColor: Color(0xFF6418C3),
//                                           ),
                                   
//                                   ]),
                                               
//                           SizedBox(height: 20,),
//                            Text("Account Type",style: TextStyle(color: Colors.black,fontSize: 16),),
//                                                 SizedBox(height: 10,),
//                                                 Consumer(builder: (context, ref, child){
//                                                   final controller=ref.watch(selectionModelProvider.notifier);
//                                                   return CustomTextFormField(width: ScreenWidth*0.8,
//                                                  readOnly: true,
//                                                  textController: _accountType,
//                                                   applyDecoration: true,
//                                                    );}
//                                                 ),
            
//                       ],),),
//                SizedBox(height: 40,),
//                CustomElevatedButton(text: "Add User", borderRadius:10,foreGroundColor: Colors.white,
//                  width: double.infinity,
//                  backGroundColor: Color(0XFF6418C3),
//                  isLoading: loading,onPressed: loading
//                               ? null
//                               : () async {
//                                   if (_formKey.currentState!.validate()&&pickedImage!=null) {
//                                     // If the form is valid, proceed with the login process
                                    
//                                     final UserResult result= await ref.read(usersProvider.notifier).addUser(pickedImage,selection.name.text,
//                                     selection.email.text,selection.gender, ref);
//                                     if(result.statusCode==201){
//                                       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Container(
//               padding: EdgeInsets.all(20),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Icon(Icons.check_circle, size: 50, color: Color(0XFF6418C3)),
//                   SizedBox(height: 15),
//                   Text(
//                     '${selection.name} has been successfully added as a user.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'User has been register',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
//                     backGroundColor: Color(0XFF6418C3),onPressed: (){
//                        ref.read(pageIndexProvider.notifier).setPage(0);
//                     },),
                  
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//                                     }else if (result.statusCode == 400) {
//                                       // If an error occurred, show a dialog box with the error message.
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return AlertDialog(
//                                             title: Text('Login Error'),
//                                             content: Text(result.errorMessage ??
//                                                 'An unknown error occurred.'),
//                                             actions: <Widget>[
//                                               TextButton(
//                                                 child: Text('OK'),
//                                                 onPressed: () {
//                                                   Navigator.of(context)
//                                                       .pop(); // Close the dialog box
//                                                 },
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     }
//                                   }
//                                 },),
              
//               ],),
//             ),
//           ));}
//         ),
//     );
     
//   }
//   @override
//   void dispose() {
//     _focusNodeName.removeListener(_handleFocusChangeName);
//     _focusNodeName.dispose();
//     _focusNodeEmail.removeListener(_handleFocusChangeEmail);
//     _focusNodeEmail.dispose();
    
//     super.dispose();
//   }
// }