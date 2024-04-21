import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '/models/authstate.dart';

import '/providers/loader.dart';
import '/utils/banquetbookzapi.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AuthNotifier extends StateNotifier<authState> {
  AuthNotifier() : super(authState());



Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
   
    return false;
}

        final extractData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

        state = state.copyWith(
             data: state.data?.copyWith(accessToken: extractData['access_token'], refreshToken: extractData['refresh_token'],
             id: extractData['id'],profilePic: extractData['profilePic'],userRole: extractData['userRole'],
             emailId: extractData['emailId'],password: extractData['password']),
            
          );

          print('email:${extractData['emailId']}');
    // Check if 'isLoggedIn' key exists and if so, return its value
     
   

    return true;
  }



 Future<bool> tryAutoLogin() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('userData')) {
    print('trylogin is false');
    return false;
  }

  final extractedData =
      json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
  final currentData = state.data ?? Data();

  // Check if currentData is not empty and accessToken differs from the new accessToken
  if (state.data == null || extractedData['accessToken'] != state.data!.accessToken
     ) {
    final updatedData = currentData.copyWith(
      accessToken: extractedData['accessToken'],
      refreshToken: extractedData['refreshToken'],
      id: extractedData['id'],
      profilePic: extractedData['profilePic'],
      userRole: extractedData['userRole'],
      emailId: extractedData['emailId'],
      password: extractedData['password'],
    );

    state = state.copyWith(data: updatedData);
    print("Updated state with new access token: ${extractedData["accessToken"]}");
    return true;
  } else {
    print("No need to update state, data is identical.");
    return true;
  }
}

  

  
  String generateRandomLetters(int length) {
    var random = Random();
    var letters = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(letters);
  }

  Future<LoginResult> adminLogin(
      String username, String password, WidgetRef ref) async {
        
         final prefs = await SharedPreferences.getInstance();
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;
      var response = await http.post(Uri.parse(Api.login),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({'email': username, 'password': password}));

      var userDetails = json.decode(response.body);
      var statuscode = response.statusCode;
      print('$statuscode');
      print('$username');
      print('$password');
      responseCode = statuscode;
      print('server response:$userDetails');
      // switch (response.statusCode) {
      //   case 201:
      //     state = authState.fromJson(userDetails);
      //     loadingState.state = false;

      //     //print('this is from Auth response is:$accessToken');

      //     final prefs = await SharedPreferences.getInstance();
      //     final userData = json.encode({
      //       'id':userDetails['data']['id'],
      //       'profilepic':userDetails['data']['profilePic'],
      //       'refreshToken': userDetails['data']['refresh_token'],
      //       'accessToken': userDetails['data']['access_token'],
      //       'firstName': userDetails['data'][''],
      //       'userRole': userDetails['data']['userRole'],
      //       'password': userDetails['data']['password'],
      //       'emailId':userDetails['data']['emailId']
      //     });

      //     //autologout();

      //     await prefs.setString('userData', userData);
      
      //     break;
      //   default:
      //     if (statuscode != 201) {
      //       loadingState.state = false;
      //     }
      //     // Optionally set a message to show to the user why the login failed
      //     break;
      // }
      if (statuscode == 201) {
        
          loadingState.state = false;
        
          //print('this is from Auth response is:$accessToken');

print("SharedPreferences fetched successfully");
            //    state=state.copyWith(data: state.data?.copyWith(accessToken: userDetails['data']['access_token'], refreshToken: userDetails['data']['refresh_token'],
            //  id: userDetails['data']['id'],profilePic: userDetails['data']['profilePic'],userRole:userDetails['data']['userRole'],
            //  emailId:userDetails['data']['emailId'],password: userDetails['data']['password']),);
           
      state=authState.fromJson(userDetails);
print("admin state:${state.data!.accessToken!}");
 

          final userData = json.encode({
            'id':userDetails['data']['id'],
            'profilepic':userDetails['data']['profilePic'],
            'refreshToken': userDetails['data']['refresh_token'],
            'accessToken': userDetails['data']['access_token'],
            
            'userRole': userDetails['data']['userRole'],
            'password': userDetails['data']['password'],
            'emailId':userDetails['data']['emailId']
          });

          //autologout();
 prefs.setString('userData', userData);


      // Assuming `state` and `authState` are part of your state management. 
      // Update them as necessary.
      
      }else if (statuscode != 201) {
            loadingState.state = false;
             errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';

          } 
      
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("cathe:$errorMessage");
    }
    return LoginResult(responseCode, errorMessage: errorMessage);
  }
Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
   prefs.remove('userData');
    state=authState.initial();
 
  }

Future<String> restoreAccessToken() async {
    final url =
        Uri.parse(Api.refreshToken);
    final prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.patch(
        url,
       
        body: json.encode({"refresh_token": state.data!.refreshToken!,"id":state.data!.id}),
      );

      var userDetails = json.decode(response.body);
      print('restore token response $userDetails');
      switch (response.statusCode) {
        case 401:
          // Handle 401 Unauthorized
          // await logout();
          // await tryAutoLogin();

          break;
        case 200:
          final newAccessToken = userDetails['data']['access_token'];
          
          final newRefreshToken = userDetails['data']['refresh_token'];
         

          // Update state
          state = state.copyWith(
             data: state.data?.copyWith(accessToken: newAccessToken, refreshToken: newRefreshToken),
            
          );
     
          final userData = json.encode({
            
            'refreshToken': newRefreshToken,
           
            'accessToken': newAccessToken,
            
          });

          prefs.setString('userData', userData);

        // loading(false); // Update loading state
      }
    } on FormatException catch (formatException) {
      print('Format Exception: ${formatException.message}');
      print('Invalid response format.');
    } on HttpException catch (httpException) {
      print('HTTP Exception: ${httpException.message}');
    } catch (e) {
      print('General Exception: ${e.toString()}');
      if (e is Error) {
        print('Stack Trace: ${e.stackTrace}');
      }
    }
    return state.data!.accessToken!;
  }
  

  
}

final authProvider = StateNotifierProvider<AuthNotifier, authState>((ref) {
  return AuthNotifier();
});

class LoginResult {
  final int statusCode;
  final String? errorMessage;

  LoginResult(this.statusCode, {this.errorMessage});
}
