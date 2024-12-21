// import 'dart:async';
// import 'package:vendor_pannel/Models/phoneauthstate.dart';
// import 'package:vendor_pannel/Providers/auth.dart';
// import 'package:vendor_pannel/Providers/stateproviders.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PhoneAuthNotifier extends StateNotifier<PhoneAuthState> {
//   PhoneAuthNotifier() : super(PhoneAuthState());
//   Timer? _timer;

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void restartTimer() {
//     state = state.copyWith(countdown: 45, wait: true);
//     startTimer();
//   }

//   void startTimer() {
//     _timer?.cancel();

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (state.countdown == 0) {
//         waitTime();
//         timer.cancel();
//       } else {
//         updateCountdown();
//       }
//     });
//   }

//   void updateCountdown() {
//     state = state.copyWith(countdown: state.countdown - 1);
//   }

//   void waitTime() {
//     state = state.copyWith(wait: !state.wait);
//   }

//   void updateOtp(String otp) {
//     state = state.copyWith(otp: otp);
//   }

//   Future<void> phoneAuth(
//       BuildContext context, String phoneNumber, WidgetRef ref) async {
//     final loadingState = ref.watch(loadingProvider.notifier);
//     loadingState.state = true;

//     try {
//       const url = 'https://your-backend-api/send-otp'; // Replace with your backend endpoint
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({'phoneNumber': phoneNumber}),
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         final verificationId = responseData['verificationId'];

//         state = state.copyWith(vrfCompleted: true);
//         loadingState.state = false;
//         ref.read(buttonTextProvider.notifier).state = "Login";
//         ref.read(VerifyOtp.notifier).state = true;

//         final prefs = await SharedPreferences.getInstance();
//         prefs.setString('verificationid', verificationId);

//         _showAlertDialog(
//             context, "Code Sent", "Verification code sent on your mobile.");
//       } else {
//         throw Exception('Failed to send OTP. Please try again.');
//       }
//     } catch (e) {
//       loadingState.state = false;
//       _showAlertDialog(context, "Error", e.toString());
//     }
//   }

//   Future<void> signInWithPhoneNumber(
//       String smsCode,
//       BuildContext context,
//       WidgetRef ref,
//       String phoneNumber,
//       bool login,
//       {String? password,
//       String? email,
//       String? username}) async {
//     final prefs = await SharedPreferences.getInstance();
//     final verificationId = prefs.getString('verificationid');

//     if (verificationId == null) {
//       _showAlertDialog(context, "Error", "Verification ID is null.");
//       return;
//     }

//     final loadingState = ref.watch(loadingProvider.notifier);

//     try {
//       loadingState.state = true;

//       const url = 'https://your-backend-api/verify-otp'; // Replace with your backend endpoint
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'verificationId': verificationId,
//           'otp': smsCode,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);

//         if (login) {
//           ref.read(authprovider.notifier).loginOtp(context, responseData['token'], ref);
//         } else {
//           // Handle registration flow
//           // ref.read(authprovider.notifier).registerUser(context, username, email, phoneNumber, password, ref);
//         }
//       } else {
//         throw Exception('OTP verification failed. Please try again.');
//       }
//     } catch (e) {
//       loadingState.state = false;
//       _showAlertDialog(context, "Error", e.toString());
//     }

//     loadingState.state = false;
//   }

//   void _showAlertDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(cleanErrorMessage(message)),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String cleanErrorMessage(String errorMessage) {
//     String cleanedMessage = errorMessage.replaceFirst('ERROR:', '');
//     cleanedMessage = cleanedMessage.replaceAll(RegExp(r'[{}]'), '');
//     cleanedMessage = cleanedMessage.trim();
//     return cleanedMessage;
//   }
// }

// final phoneAuthProvider =
//     StateNotifierProvider<PhoneAuthNotifier, PhoneAuthState>((ref) {
//   return PhoneAuthNotifier();
// });
