
// import 'package:banquetbookingz/providers/loader.dart';
// import 'package:banquetbookingz/providers/selectionmodal.dart';
// import 'package:banquetbookingz/providers/subcsribersprovider.dart';
// import 'package:banquetbookingz/widgets/button.dart';
// import 'package:banquetbookingz/widgets/customelevatedbutton.dart';
// import 'package:banquetbookingz/widgets/customtextfield.dart';
// import 'package:banquetbookingz/widgets/substack.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EditSubscriber extends ConsumerStatefulWidget {
//    EditSubscriber({super.key});

//   @override
//   ConsumerState<EditSubscriber> createState() => _EditSubscriberState();
// }

// class _EditSubscriberState extends ConsumerState<EditSubscriber> {
//    final FocusNode _focusNodeName = FocusNode();
//   final FocusNode _focusNodeAnnual = FocusNode();
//   final FocusNode _focusNodeQuaterly = FocusNode();
//   final FocusNode _focusNodeMonthly = FocusNode();
  
//   bool _isFocusedName = false;
//   bool _isFocusedAnnual = false;
//   bool _isFocusedQuaterly = false;
//   bool _isFocusedMonthly = false;
//    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//    @override
//   void initState() {
//     super.initState();
//  _focusNodeName.addListener(_handleFocusChangeName);
//     _focusNodeAnnual.addListener(_handleFocusChangeAnnual);
//     _focusNodeQuaterly.addListener(_handleFocusChangeQuaterly);
//     _focusNodeMonthly.addListener(_handleFocusChangeMonthly);
//     Future.microtask(() {
//       // Get the ID passed via arguments
     
//       final id = ModalRoute.of(context)?.settings.arguments as int?;
//       print(id);
//       final ids=ref.read(selectionModelProvider).subscriberIndex;
//       print(ids);
//       // Get user details from your state notifier
//       final user = ref.read(subscribersProvider.notifier).getSubById(ids!);

//       if (user != null) {
//         final selection=ref.watch(selectionModelProvider);
//         // Update the controllers with the user's data
//         ref.read(selectionModelProvider.notifier).updateSubname(user.name ?? '');
//         ref.read(selectionModelProvider.notifier).updateAnnualP(user.annualPricing.toString() ?? '');
//         ref.read(selectionModelProvider.notifier).updateQuaterlyP(user.quaterlyPricing.toString() ?? '');
//         ref.read(selectionModelProvider.notifier).updateMonthlyP(user.monthlyPricing.toString() ?? '');
//       //    if (user.profilepic != null) {
//       //   ref.read(imageProvider.notifier).setProfilePic(XFile(user.profilepic!));
//       // }
//         // ... do the same for other fields
//       }
//     });
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
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final subNameController = ref.watch(selectionModelProvider.select((model) => model.subName));
//     final annualController = ref.watch(selectionModelProvider.select((model) => model.annualP));
//     final quaterlyController = ref.watch(selectionModelProvider.select((model) => model.quaterlyP));
//     final monthlyController = ref.watch(selectionModelProvider.select((model) => model.monthlyP));
//     final ids=ref.read(selectionModelProvider).subscriberIndex;
//       print("id:$ids");
//       // Get user details from your state notifier
//       final user = ref.read(subscribersProvider.notifier).getSubById(ids!);
//     return Scaffold(
//       body: Form(key: _formKey,
//         child: Container(padding: EdgeInsets.all(15),color: Color(0xFFf5f5f5),
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Container(child: Consumer(builder: (context, ref, child) {
//                 final addSub=ref.watch(selectionModelProvider.notifier);
//                 return AppBar(leading: IconButton(onPressed: (){
//                   Navigator.of(context).pop();
                  
//                 }, icon: Icon(Icons.arrow_back,color: Color(0xff6418c3),)),
//                 backgroundColor: Color(0xfff5f5f5),
//                 title: Text("Edit Subcsription",style: TextStyle(color: Color(0xff6418c3),fontSize: 20),),);}
//               )),
//               SizedBox(height: 20,),
//               SubStack(width: screenWidth*0.9,text:user!.name,),
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
//                     SizedBox(height: 20,),
//                     Text("name",style: TextStyle(fontSize: 18,),),
//                     SizedBox(height: 10,),
//                     Consumer(builder: (context, ref, child) {
//                       final controller=ref.watch(selectionModelProvider.notifier);
//                       return CustomTextFormField(width: screenWidth*0.8,
//                       keyBoardType: TextInputType.text,
//                        focusNode: _focusNodeName,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedName ? Colors.white : Colors.grey[300],
//                       textController: subNameController,
//                       validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                       hintText: 'name',onChanged: (newValue){
//                     controller.updateSubname(newValue);
//                       },);}
//                     ),
//                        SizedBox(height: 12,),
//                        Text("Annual pricing",style: TextStyle(fontSize: 18,),),
//                     SizedBox(height: 10,),
//                     Consumer(builder: (context, ref, child) {
//                       final controller=ref.watch(selectionModelProvider.notifier);
//                       return CustomTextFormField(width: screenWidth*0.8,
//                       focusNode: _focusNodeAnnual,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedAnnual ? Colors.white : Colors.grey[300],
//                       textController: annualController,
//                       keyBoardType: TextInputType.number,
//                       validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                       hintText: 'Annual pricing',onChanged: (newValue){
//                     controller.updateAnnualP(newValue);
//                       },);}
//                     ),
//                     SizedBox(height: 12,),
//                        Text("Quarterly pricing",style: TextStyle(fontSize: 18,),),
//                     SizedBox(height: 10,),
//                     Consumer(builder: (context, ref, child) {
//                       final controller=ref.watch(selectionModelProvider.notifier);
//                       return CustomTextFormField(width: screenWidth*0.8,
//                       focusNode: _focusNodeQuaterly,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedQuaterly ? Colors.white : Colors.grey[300],
//                       textController: quaterlyController,
//                       keyBoardType: TextInputType.number,
//                       validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                       hintText: 'Queterly picing',onChanged: (newValue){
//                     controller.updateQuaterlyP(newValue);
//                       },);}
//                     ),
                    
//                     SizedBox(height: 12,),
//                        Text("Monthly pricing",style: TextStyle(fontSize: 18,),),
//                     SizedBox(height: 10,),
//                     Consumer(builder: (context, ref, child) {
//                       final controller=ref.watch(selectionModelProvider.notifier);
//                       return CustomTextFormField(width: screenWidth*0.8,
//                       textController: monthlyController,
//                        focusNode: _focusNodeMonthly,
//                                                   filled: true,
//                         filledColor:
//                             _isFocusedMonthly ? Colors.white : Colors.grey[300],
//                       keyBoardType: TextInputType.number,
//                       validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Field is required';
//                                                                           }
                                                  
                                                                          
//                                                                           return null;
//                                                                         },
//                       hintText: 'monthly pricing',onChanged: (newValue){
//                     controller.updateMonthlyP(newValue);
//                       },);}
//                     ),
                    
//                     SizedBox(height: 12,),
//                     //    Text("Subcription tags",style: TextStyle(fontSize: 18,),),
//                     // SizedBox(height: 10,),
//                     // CustomTextFormField(width: screenWidth*0.8,
//                     // hintText: 'Subcription tags',),
//                     //  SizedBox(height: 8,),
//                     //           Consumer(builder: (context, ref, child) {
//                     //   final options= ref.watch(filterOptionsProvider).options['Subscription Type'] ?? [];
//                     //             return Wrap(
//                     //               spacing: 8.0,
//                     //               children: options.map((option) => Chip(backgroundColor: Color(0xffeee1ff),
//                     //                 label: Text(option),
//                     //                 deleteIcon: Icon(Icons.close),
//                     //                 onDeleted: () {
//                     //                   // Handle delete (removal) of the filter option
//                     //                   ref.read(filterOptionsProvider.notifier).removeOption('Subscription Type', option);
//                     //                 },
//                     //               )).toList(),
//                     //             );}
//                     //           ),
//                 ],),),
//                 SizedBox(height: 20,),
//                 Consumer(builder: (context, ref, child) {
                
//                   final selection=ref.watch(selectionModelProvider);
//                   final loading=ref.watch(loadingProvider);
//                    return CustomElevatedButton(text: "Save", borderRadius:10,foreGroundColor: Colors.white,
//                    width: double.infinity,
//                    backGroundColor: Color(0XFF6418C3),
//                    isLoading: loading,onPressed: loading
//                                 ? null
//                                 : () async {
//                                     if(_formKey.currentState!.validate()){
//                                       // If the form is valid, proceed with the login process
                                      
//                                       final SubscriberResult result= await ref.read(subscribersProvider.notifier).updateSubscriber(ids,  subNameController.text,
//                                       annualController.text,quaterlyController.text,monthlyController.text, ref);
//                                        if(result.statusCode==201){
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
                    
//                     },);}
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//                                     }else if (result.statusCode == 400) {
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
//                                     }}
//                                   ,);}
//                  ),
//           SizedBox(height: 20,),
//           CustomElevateButton(text: "Delete Plan", borderRadius:12,backGroundColor: Color(0xffea5455),
//            width:  double.infinity)
           
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