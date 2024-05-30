import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../providers/authprovider.dart';

import '../providers/connectivityprovider.dart';
import '../providers/loader.dart';

import '../providers/selectionmodal.dart';
import '../widgets/customelevatedbutton.dart';
import '../widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _enterEmail = TextEditingController();
  final TextEditingController _enteredPassword = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();

  bool _isFocusedPassword = false;
  bool _isFocusedEmail = false;

  @override
  void initState() {
    super.initState();
    _focusNodePassword.addListener(_handleFocusChangePassword);
    _focusNodeEmail.addListener(_handleFocusChangeEmail);
  }

  void _handleFocusChangePassword() {
    if (_focusNodePassword.hasFocus != _isFocusedPassword) {
      setState(() {
        _isFocusedPassword = _focusNodePassword.hasFocus;
      });
    }
  }

  void _handleFocusChangeEmail() {
    if (_focusNodeEmail.hasFocus != _isFocusedEmail) {
      setState(() {
        _isFocusedEmail = _focusNodeEmail.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            Consumer(builder: (context, ref, child) {
              var textfield = ref.watch(selectionModelProvider);
              print("password field:${textfield.loginEmail}");
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          width: screenWidth * 0.8,
                          hintText: "Email/mobile",
                          focusNode: _focusNodeEmail,
                          keyBoardType: TextInputType.emailAddress,
                          suffixIcon:Icon(Icons.person_outline) ,
                          textController: _enterEmail,
                          validator: (value) {
                             bool emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!);
      // Check if the entered text is a 10-digit number
      bool mobileValid = RegExp(r'^\d{10}$').hasMatch(value);
                                   if (value == null || value.isEmpty) {
                              return 'Field is required';
                            }else if (!emailValid && !mobileValid){
      // Regex pattern to check if the entered text is a valid email
     

       
        return 'Enter a valid email or a 10-digit mobile number';
      }
                            // Add more conditions here if you need to check for numbers, special characters, etc.
                            return null; // Return null if the entered password is valid
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (textfield.loginEmail == null)
                    Container()
                  else if (textfield.loginEmail == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          width: screenWidth * 0.8,
                          hintText: "Password",
                          keyBoardType: TextInputType.text,
                          focusNode: _focusNodePassword,
                          filled: true,
                          filledColor: _isFocusedPassword
                              ? Colors.white
                              : Colors.grey[300],
                          suffixIcon:Icon(Icons.lock_outline) ,
                          textController: _enteredPassword,
                          validator: (value) {
                  if (value == null || value.isEmpty) {
                              return 'Field is required';
                            }
                            // Add more conditions here if you need to check for numbers, special characters, etc.
                            return null; // Return null if the entered password is valid
                          },
                        ),
                      ],
                    )
                  else if (textfield.loginEmail == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          width: screenWidth * 0.8,
                          hintText: "OTP",
                          keyBoardType: TextInputType.number,
                          focusNode: _focusNodePassword,
                          filled: true,
                          filledColor: _isFocusedPassword
                              ? Colors.white
                              : Colors.grey[300],
                          suffixIcon:Icon(Icons.lock_outline) ,
                          textController: _enteredPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field is required';
                            }
                            // Add more conditions here if you need to check for numbers, special characters, etc.
                            return null; // Return null if the entered password is valid
                          },
                        ),
                      ],
                    )
                ],
              );
            }),
            const SizedBox(
              height: 15,
            ),
            Consumer(builder: (context, ref, child) {
              final login = ref.watch(authProvider.notifier);
              ref.watch(selectionModelProvider);
              final isLoading = ref.watch(loadingProvider);

              return CustomElevatedButton(
                text: "Next",
                borderRadius: 10,
                width: 300,
                onPressed: isLoading
                    ? null
                    : () async {
                        //  final LoginResult result = await login.adminLogin(
                        //         _enterEmail.text, _enteredPassword.text, ref);
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern);
                        if (_formKey.currentState!.validate()) {
                          if (!regex.hasMatch(_enterEmail.text)) {
                            ref.read(selectionModelProvider.notifier).toggleLogin(
                                false); // Call the function if the input is not an email
                          } else {
                            ref
                                .read(selectionModelProvider.notifier)
                                .toggleLogin(true);
                                if(_enteredPassword.text.isNotEmpty || _enteredPassword.text!=""){
                                  login.vendorLogin(ref,password:_enteredPassword.text  ,username:_enterEmail.text );
                                }
                                
                          }
                        }
                      },
                isLoading: isLoading,
                backGroundColor: const Color(0xFF6418C3),
                foreGroundColor: Colors.white,
              );
            }),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(onPressed: () {
              Navigator.of(context).pushNamed("addvendor");
            }, child: const Text('Get Started'))
          ],
        ),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          final isOnline = ref.watch(connectivityProvider);
          return isOnline
              ? Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 120, 62, 230),
                        Color.fromARGB(255, 188, 171, 226),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  height: screenHeight,
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Welcome to\nBanquetBookz",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Enter your Email / Mobile Number\nto sign in your account",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              : const Text("No Internet connection");
        }),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.removeListener(_handleFocusChangePassword);
    _focusNodePassword.dispose();
    _focusNodeEmail.removeListener(_handleFocusChangeEmail);
    _focusNodeEmail.dispose();

    super.dispose();
  }
}
