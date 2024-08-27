// import 'dart:convert';
// import 'dart:math';
// import 'package:banquetbookz_vendor/models/authstate.dart';
// import 'package:banquetbookz_vendor/providers/loader.dart';
// import 'package:banquetbookz_vendor/utils/banquetbookzapi.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthNotifier extends StateNotifier<AuthState> {
//   AuthNotifier() : super(AuthState());

//   // Check if the user is authenticated by looking for userData in SharedPreferences
//   Future<bool> isAuthenticated() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('userData')) {
//       final extractData =
//           json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
//       if (state.token == null) {
//         state = state.copyWith(
//           token: extractData['token'],
//           username: extractData['username'],
//           email: extractData['email'],
//           mobileno: extractData['mobileno'],
//           usertype: extractData['usertype'],
//         );
//       }
//       return true;
//     } else {
//       print('User not authenticated');
//       return false;
//     }
//   }

//   // Helper function to generate random letters
//   String generateRandomLetters(int length) {
//     var random = Random();
//     var letters = List.generate(length, (_) => random.nextInt(26) + 97);
//     return String.fromCharCodes(letters);
//   }

//   // Admin login function
//   Future<LoginResult> adminLogin(
//       String username, String password, WidgetRef ref) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     int responseCode = 0;
//     String? errorMessage;
//     try {
//       loadingState.state = true;

//       var response = await http.post(
//         Uri.parse(Api.login),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'username': username, 'password': password}),
//       );

//       var userDetails = json.decode(response.body);
//       responseCode = response.statusCode;
//       print('Response Code: $responseCode');
//       print('Server Response: $userDetails');

//       if (responseCode == 200) {
//         loadingState.state = false;

//         state = AuthState.fromJson(userDetails);
//         print('State updated with token: ${userDetails['token']}');

//         final prefs = await SharedPreferences.getInstance();
//         print("SharedPreferences fetched successfully");
//         state = state.copyWith(token: userDetails['Token']);
//         final userData = json.encode({
//           'token': userDetails['token'],
//           'username': userDetails['username'],
//           'email': userDetails['email'],
//           'mobileno': userDetails['mobileno'],
//           'usertype': userDetails['usertype'],
//         });
//         await prefs.setString('userData', userData);

//         bool saveResult = await prefs.setString('userData', userData);
//         if (!saveResult) {
//           print("Failed to save user data to SharedPreferences.");
//         }

//         bool tokenSaveResult =
//             await prefs.setString('accessToken', userDetails['token']);
//         if (!tokenSaveResult) {
//           print("Failed to save access token to SharedPreferences.");
//         }
//       } else {
//         loadingState.state = false;
//         errorMessage =
//             userDetails['messages']?.first ?? 'An unknown error occurred.';
//       }
//     } catch (e) {
//       loadingState.state = false;
//       errorMessage = e.toString();
//       print("Catch: $errorMessage");
//     }
//     return LoginResult(responseCode, errorMessage: errorMessage);
//   }

//   // Function to log out the user
//   Future<void> logoutUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userData');
//     await prefs.remove('accessToken');
//     await prefs.setBool('isLoggedIn', false);
//     state = AdminAuth(); // Clear the state after logout
//   }

//   // Retrieve the access token from SharedPreferences
//   Future<String?> _getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('accessToken');
//     print("Retrieved token: $token");
//     return token;
//   }
// }

// // Riverpod provider for AuthNotifier
// final authProvider = StateNotifierProvider<AuthNotifier, AdminAuth>((ref) {
//   return AuthNotifier();
// });

// // Model class to represent the login result
// class LoginResult {
//   final int statusCode;
//   final String? errorMessage;

//   LoginResult(this.statusCode, {this.errorMessage});
// }