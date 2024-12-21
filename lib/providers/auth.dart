import 'dart:convert';
import "package:vendor_pannel/models/authstate.dart";
// import 'package:vendor_pannel/Providers/phoneauthnotifier.dart';
import 'package:vendor_pannel/Providers/stateproviders.dart';
import 'package:vendor_pannel/utils/bbapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<AdminAuth> {
  AuthNotifier() : super(AdminAuth());


  Future<bool> tryAutoLogin() async {
     final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken != null && accessToken.isNotEmpty) {
      return true;
    }

    if (prefs.containsKey('userData')) {
      final extractData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      if (state.data?.accessToken == null) {
        state = AdminAuth.fromJson(extractData);
      }
      return true;
    } else {
      print('User not authenticated');
      return false;
    }
  }

 Future<LoginResult> adminLogin(
  String email, 
  String password, 
  WidgetRef ref
) async {
  final loadingState = ref.watch(loadingProvider.notifier);
  int responseCode = 0;
  String? errorMessage;
  Map<String, dynamic>? responseBody; 

  try {
    loadingState.state = true;

    // Making the API request with email and password in the body
    var response = await http.post(
      Uri.parse(Bbapi.login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'email': email, 'password': password}),
    );

    responseCode = response.statusCode;
    var responseBody = json.decode(response.body);
    print('Response Code: $responseCode');
    print('Server Response: $responseBody');

    if (responseCode == 200 && responseBody['success'] == true) {
      loadingState.state = false;

      // Parse the response body to AdminAuth model
      AdminAuth adminAuth = AdminAuth.fromJson(responseBody);

      // Update the state with the returned data
      state = adminAuth;
      print('State updated with access token: ${adminAuth.data?.accessToken}');

      // Storing data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      print("SharedPreferences fetched successfully");

      // Store the entire AdminAuth object in SharedPreferences
      final userData = json.encode(adminAuth.toJson());
      bool saveResult = await prefs.setString('userData', userData);

      if (!saveResult) {
        print("Failed to save user data to SharedPreferences.");
      }

      // Also saving the access token separately if needed
      bool tokenSaveResult = await prefs.setString(
        'accessToken', 
        adminAuth.data?.accessToken ?? ''
      );
      if (!tokenSaveResult) {
        print("Failed to save access token to SharedPreferences.");
      }
    } else {
      loadingState.state = false;
      errorMessage =
          responseBody['messages']?.first ?? 'An unknown error occurred.';
    }
  } catch (e) {
    loadingState.state = false;
    errorMessage = e.toString();
    print("Catch: $errorMessage");
  }

  // Return the result with the response body included
  return LoginResult(responseCode, errorMessage: errorMessage, responseBody: responseBody);
}
Future<void> logoutUser() async {
    print('Logging out...');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = AdminAuth.initial(); // Clear the state after logout
    print('User logged out and state cleared.');
  }
}


String cleanErrorMessage(String errorMessage) {
  // Remove the "ERROR:" prefix
  String cleanedMessage = errorMessage.replaceFirst('ERROR:', '');

  // Remove the curly brackets
  cleanedMessage = cleanedMessage.replaceAll(RegExp(r'[{}]'), '');

  // Trim any extra whitespace
  cleanedMessage = cleanedMessage.trim();

  return cleanedMessage;
}

final authprovider = StateNotifierProvider<AuthNotifier, AdminAuth>((ref) {
  return AuthNotifier();
});


// Model class to represent the login result
class LoginResult {
  final int statusCode;
  final String? errorMessage;
  final Map<String, dynamic>? responseBody;
  

  LoginResult(this.statusCode, {this.errorMessage,this.responseBody});
}

  // Future<void> numCheck(
  //     BuildContext context, String? phonenum, WidgetRef ref) async {
  //   const url = Bbapi.mobilecheck;
  //   print("NumCheck${phonenum}");
  //   final prefs = await SharedPreferences.getInstance();
  //   final loadingState = ref.read(loadingProvider2.notifier);
  //   loadingState.state = true;
  //   var response = await http.post(Uri.parse(url),
  //       headers: {
  //         'Content-Type':
  //             'application/json', // Set the content type to application/json
  //       },
  //       body: json.encode({"mobileno": phonenum}));
  //   print("username: $phonenum");
  //   var userDetails = json.decode(response.body);
  //   print('booking response:$userDetails');
  //   switch (response.statusCode) {
  //     case 200:
  //       loadingState.state = false;
  //       print('success');
  //       ref.read(enablepasswaorProvider.notifier).state = 1;
  //       ref.read(buttonTextProvider.notifier).state = "Login";
  //       ref
  //           .read(phoneAuthProvider.notifier)
  //           .phoneAuth(context, "$phonenum", ref);

  //       break;
  //     case 400:
  //       loadingState.state = false;
  //       print('success');
  //       showDialog(
  //         context: context!,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: Text(cleanErrorMessage(userDetails)),
  //             actions: [
  //               ElevatedButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );

  //       break;

  //     case 500:
  //       loadingState.state = false;
  //       break;
  //   }
  //   // Handle other status codes as needed
  // }

  // Future<void> loginOtp(
  //     BuildContext context, String? token, WidgetRef ref) async {
  //   const url = Bbapi.login_otp;
  //   //print("Otp check${otp}");
  //   final prefs = await SharedPreferences.getInstance();
  //   String? verificationId = prefs.getString('verificationid');
  //   final loadingState = ref.read(loadingProvider2.notifier);
  //   loadingState.state = true;

  //   var response = await http.post(Uri.parse(url),
  //       headers: {
  //         'Content-Type':
  //             'application/json', // Set the content type to application/json
  //       },
  //       body: json.encode({"token": token}));
  //   print("verificationId: $verificationId");
  //   var userDetails = json.decode(response.body);
  //   print('booking response:$userDetails');
  //   switch (response.statusCode) {
  //     case 200:
  //       loadingState.state = false;
  //       print('success');
  //       state = state.copyWith(
  //           token: userDetails["token"],
  //           username: userDetails["username"],
  //           email: userDetails["email"],
  //           mobileno: userDetails["mobileno"],
  //           usertype: userDetails["usertype"]);
  //       final userData = json.encode({
  //         'token': state.token,
  //         'username': state.username,
  //         'email': state.email,
  //         'mobileno': state.mobileno,
  //         'usertype': state.usertype,
  //       });
  //       await prefs.setString('userData', userData);
  //       print('pushNamed //');
  //       //Navigator.of(context).pushNamed('/');
  //       break;
  //     case 400:
  //       loadingState.state = false;
  //       print('success');
  //       showDialog(
  //         context: context!,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: Text(cleanErrorMessage(userDetails)),
  //             //content: Text("$userDetails"),
  //             actions: [
  //               ElevatedButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );

  //       break;
  //     case 500:
  //       loadingState.state = false;
  //       showDialog(
  //         context: context!,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: Text(cleanErrorMessage(userDetails)),
  //             //content: Text("$userDetails"),
  //             actions: [
  //               ElevatedButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //       break;
  //   }
  //   // Handle other status codes as needed
  // }

  // Future<void> loginwithpassword(BuildContext context, String? username,
  //     String? password, WidgetRef ref) async {
  //   const url = Bbapi.login_pwd;
  //   //print("Otp check${otp}");
  //   final prefs = await SharedPreferences.getInstance();
  //   String? verificationId = prefs.getString('verificationid');
  //   final loadingState = ref.read(loadingProvider2.notifier);
  //   loadingState.state = true;

  //   var response = await http.post(Uri.parse(Bbapi.login_pwd),
  //       headers: {
  //         'Content-Type':
  //             'application/json', // Set the content type to application/json
  //       },
  //       body: json.encode({
  //         "username": username!,
  //         "password": password!,
  //       }));
  //   print("verificationId: $verificationId");
  //   var userDetails = json.decode(response.body);
  //   print('booking response:$userDetails');
  //   switch (response.statusCode) {
  //     case 200:
  //       loadingState.state = false;
  //       print('success');
  //       state = state.copyWith(
  //           token: userDetails["token"],
  //           username: userDetails["username"],
  //           email: userDetails["email"],
  //           mobileno: userDetails["mobileno"],
  //           usertype: userDetails["usertype"]);
  //       final userData = json.encode({
  //         'token': state.token,
  //         'username': state.username,
  //         'email': state.email,
  //         'mobileno': state.mobileno,
  //         'usertype': state.usertype,
  //       });
  //       await prefs.setString('userData', userData);
  //       print('pushNamed //');
  //       //Navigator.of(context).pushNamed('/');
  //       break;
  //     case 400:
  //       loadingState.state = false;
  //       print('success');
  //       showDialog(
  //         context: context!,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: Text(cleanErrorMessage(userDetails)),
  //             //content: Text("$userDetails"),
  //             actions: [
  //               ElevatedButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );

  //       break;
  //     case 500:
  //       loadingState.state = false;
  //       showDialog(
  //         context: context!,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Error'),
  //             content: Text(cleanErrorMessage(userDetails)),
  //             //content: Text("$userDetails"),
  //             actions: [
  //               ElevatedButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //       break;
  //   }
  //   // Handle other status codes as needed
  // }

  // void clear() {
  //   state = state.clear(); // Reset to initial state
  //   state = state.copyWith();
  // }
