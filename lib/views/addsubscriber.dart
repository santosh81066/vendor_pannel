// import 'package:banquetbookingz/providers/authprovider.dart';
// import 'package:banquetbookingz/providers/bottomnavigationbarprovider.dart';
// import 'package:banquetbookingz/providers/filtersprovider.dart';
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/subcsribersprovider.dart';
// import 'package:banquetbookingz/widgets/button.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AddSubscriber extends StatefulWidget {
//   const AddSubscriber({super.key});

//   @override
//   State<AddSubscriber> createState() => _AddSubscriberState();
// }

// class _AddSubscriberState extends State<AddSubscriber> {
//    final FocusNode _focusNodeName = FocusNode();
//   final FocusNode _focusNodeAnnual = FocusNode();
//   final FocusNode _focusNodeQuaterly = FocusNode();
//   final FocusNode _focusNodeMonthly = FocusNode();
  
//   bool _isFocusedName = false;
//   bool _isFocusedAnnual = false;
//   bool _isFocusedQuaterly = false;
//   bool _isFocusedMonthly = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNodeName.addListener(_handleFocusChangeName);
//     _focusNodeAnnual.addListener(_handleFocusChangeAnnual);
//     _focusNodeQuaterly.addListener(_handleFocusChangeQuaterly);
//     _focusNodeMonthly.addListener(_handleFocusChangeMonthly);
//   }

//   void _handleFocusChangeName() {
//     if (_focusNodeName.hasFocus != _isFocusedName) {
//       setState(() {
//         _isFocusedName = _focusNodeName.hasFocus;
//       });
//     }
//   }

//   void _handleFocusChangeAnnual() {
//     if (_focusNodeAnnual.hasFocus != _isFocusedAnnual) {
//       setState(() {
//         _isFocusedAnnual = _focusNodeAnnual.hasFocus;
//       });
//     }
//   }
//    void _handleFocusChangeQuaterly() {
//     if (_focusNodeQuaterly.hasFocus != _isFocusedQuaterly) {
//       setState(() {
//         _isFocusedQuaterly = _focusNodeQuaterly.hasFocus;
//       });
//     }
//   }

//   void _handleFocusChangeMonthly() {
//     if (_focusNodeMonthly.hasFocus != _isFocusedMonthly) {
//       setState(() {
//         _isFocusedMonthly = _focusNodeMonthly.hasFocus;
//       });
//     }
//   }
  
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
    
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(key: _formKey,
//           child: Container(padding: EdgeInsets.all(15),color: Color(0xFFf5f5f5),
//             child: Column(children: [
//               Container(child: Consumer(builder: (context, ref, child) {
//                 final addSub=ref.watch(selectionModelProvider.notifier);
//                 return AppBar(leading: IconButton(onPressed: (){
//                   Navigator.of(context).pop();
                  
//                 }, icon: Icon(Icons.arrow_back,color: Color(0xff6418c3),)),
//                 backgroundColor: Color(0xfff5f5f5),
//                 title: Text("Subcsription",style: TextStyle(color: Color(0xff6418c3),fontSize: 20),),);}
//               )),
//               SizedBox(height: 20,),
//               Container(
//               padding: EdgeInsets.all(15),
//                                                     decoration: BoxDecoration(
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       color: Colors.white,
//                                                     ),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                   Text("Subscription details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                   SizedBox(height: 20,),
//                   Text("name",style: TextStyle(fontSize: 18,),),
//                   SizedBox(height: 10,),
//                   Consumer(builder: (context, ref, child) {
//                     final controller=ref.watch(selectionModelProvider.notifier);
//                     return CustomTextFormField(width: screenWidth*0.8,
//                      focusNode: _focusNodeName,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedName ? Colors.white : Colors.grey[300],
//                     keyBoardType: TextInputType.text,
//                     validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                     hintText: 'name',onChanged: (newValue){
//                   controller.updateSubname(newValue);
//                     },);}
//                   ),
//                      SizedBox(height: 12,),
//                      Text("Annual pricing",style: TextStyle(fontSize: 18,),),
//                   SizedBox(height: 10,),
//                   Consumer(builder: (context, ref, child) {
//                     final controller=ref.watch(selectionModelProvider.notifier);
//                     return CustomTextFormField(width: screenWidth*0.8,
//                     focusNode: _focusNodeAnnual,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedAnnual ? Colors.white : Colors.grey[300],
//                     keyBoardType: TextInputType.number,
//                     validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                     hintText: 'Annual pricing',onChanged: (newValue){
//                   controller.updateAnnualP(newValue);
//                     },);}
//                   ),
//                   SizedBox(height: 12,),
//                      Text("Quarterly pricing",style: TextStyle(fontSize: 18,),),
//                   SizedBox(height: 10,),
//                   Consumer(builder: (context, ref, child) {
//                     final controller=ref.watch(selectionModelProvider.notifier);
//                     return CustomTextFormField(width: screenWidth*0.8,
//                     focusNode: _focusNodeQuaterly,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedQuaterly ? Colors.white : Colors.grey[300],
//                     keyBoardType: TextInputType.number,
//                     validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                     hintText: 'Queterly picing',onChanged: (newValue){
//                   controller.updateQuaterlyP(newValue);
//                     },);}
//                   ),
                  
//                   SizedBox(height: 12,),
//                      Text("Monthly pricing",style: TextStyle(fontSize: 18,),),
//                   SizedBox(height: 10,),
//                   Consumer(builder: (context, ref, child) {
//                     final controller=ref.watch(selectionModelProvider.notifier);
//                     return CustomTextFormField(width: screenWidth*0.8,
//                     focusNode: _focusNodeMonthly,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedMonthly ? Colors.white : Colors.grey[300],
//                     keyBoardType: TextInputType.number,
//                     validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                     hintText: 'monthly pricing',onChanged: (newValue){
//                   controller.updateMonthlyP(newValue);
//                     },);}
//                   ),
                  
//                   SizedBox(height: 12,),
//                   //    Text("Subcription tags",style: TextStyle(fontSize: 18,),),
//                   // SizedBox(height: 10,),
//                   // CustomTextFormField(width: screenWidth*0.8,
//                   // hintText: 'Subcription tags',),
//                   //  SizedBox(height: 8,),
//                   //           Consumer(builder: (context, ref, child) {
//                   //   final options= ref.watch(filterOptionsProvider).options['Subscription Type'] ?? [];
//                   //             return Wrap(
//                   //               spacing: 8.0,
//                   //               children: options.map((option) => Chip(backgroundColor: Color(0xffeee1ff),
//                   //                 label: Text(option),
//                   //                 deleteIcon: Icon(Icons.close),
//                   //                 onDeleted: () {
//                   //                   // Handle delete (removal) of the filter option
//                   //                   ref.read(filterOptionsProvider.notifier).removeOption('Subscription Type', option);
//                   //                 },
//                   //               )).toList(),
//                   //             );}
//                   //           ),
//                 ],),),
//                 SizedBox(height: 20,),
//                 Consumer(builder: (context, ref, child) {
                
//                   final selection=ref.watch(selectionModelProvider);
//                   final loading=ref.watch(loadingProvider);
//                    return CustomElevatedButton(text: "Add Subscriber", borderRadius:10,foreGroundColor: Colors.white,
//                    width: double.infinity,
//                    backGroundColor: Color(0XFF6418C3),
//                    isLoading: loading,onPressed: loading
//                                 ? null
//                                 : () async {
//                                     if(_formKey.currentState!.validate()){
//                                       // If the form is valid, proceed with the login process
                                      
//                                       final SubscriberResult result= await ref.read(subscribersProvider.notifier).addSubscrier(selection.subName.text,
//                                       selection.annualP.text,selection.quaterlyP.text,selection.monthlyP.text, ref);
//                                       if(result.statusCode==201){
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
//                     'Suresh Ramesh has been successfully added as a user.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'Login details have been mailed to the user.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Consumer(builder: (context, ref, child){
//                     final addUser=ref.watch(selectionModelProvider.notifier);
//                     return CustomElevatedButton(text: "OK", borderRadius:20,width: 100,foreGroundColor: Colors.white,
//                     backGroundColor: Color(0XFF6418C3),onPressed: (){
//                        ref.read(pageIndexProvider.notifier).setPage(0);
//                     },);}
//                   )
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
//                                      } }
//                                   ,);}
//                  )
                     
//             ],),
//           ),
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     _focusNodeName.removeListener(_handleFocusChangeName);
//     _focusNodeName.dispose();
//     _focusNodeAnnual.removeListener(_handleFocusChangeAnnual);
//     _focusNodeAnnual.dispose();
//     _focusNodeQuaterly.removeListener(_handleFocusChangeQuaterly);
//     _focusNodeQuaterly.dispose();
//     _focusNodeMonthly.removeListener(_handleFocusChangeMonthly);
//     _focusNodeMonthly.dispose();
    
//     super.dispose();
//   }
// }