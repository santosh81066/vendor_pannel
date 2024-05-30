import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import '../models/authstate.dart' as auth;
import '../models/subscriptionmodel.dart';
import '../providers/authprovider.dart';

import '../providers/loader.dart';
import '../utils/banquetbookzapi.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/retry.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class PropertyNotifier extends StateNotifier<subscription> {
  PropertyNotifier() : super(subscription());

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     print('trylogin is false');
  //     return false;
  //   }

  //   final extractData =
  //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
  //   final profile = prefs.getBool('profile') ?? false;
  //   final expiryDate = DateTime.parse(extractData['refreshExpiry']);
  //   final accessExpiry = DateTime.parse(extractData['accessTokenExpiry']);
  String generateRandomLetters(int length) {
    var random = Random();
    var letters = List.generate(length, (_) => random.nextInt(26) + 97);
    return String.fromCharCodes(letters);
  }


  Future<SubscriberResult> addSubscrier(
      String subname, String annualprice,String quaterlyprice,String monthlyprice, WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;
      var response = await http.post(Uri.parse(Api.subscriptions),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'name': subname,'annualpricing': annualprice,
          'quaterlypricing': quaterlyprice,'monthlypricing': monthlyprice,}));

      var userDetails = json.decode(response.body);
      var statuscode = response.statusCode;
      print('$statuscode');
      responseCode = statuscode;
      print('server response:$userDetails');
      switch (response.statusCode) {
        case 201:
          state = subscription.fromJson(userDetails);
          loadingState.state = false;

          //print('this is from Auth response is:$accessToken');

          // // final prefs = await SharedPreferences.getInstance();
          // // final userData = json.encode({
          // //   'refreshToken': userDetails['data']['refresh_token'],
          // //   'accessToken': userDetails['data']['access_token'],
          // //   'firstName': userDetails['data'][''],
          // //   'userRole': userDetails['data']['userRole'],
          // //   'password': userDetails['data']['password']
          // });

          //autologout();

          // await prefs.setString('userData', userData);
          // await prefs.setBool('isLoggedIn', true);
          break;
        default:
          if (statuscode != 201) {
            loadingState.state = false;
          }
          // Optionally set a message to show to the user why the login failed
          break;
      }
      if (statuscode == 201) {
        // Handle successful login...
      } else {
        // Any other status code means something went wrong
        // Extract error message from response
        // Assuming 'messages' is a List of messages and we take the first one.
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
        // Alternatively, if 'message' is a single String with the error message:
        // errorMessage = responseJson['message'];
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("cathe:$errorMessage");
    }
    return SubscriberResult(responseCode, errorMessage: errorMessage);
  }


  Future<SubscriberResult> updateSubscriber(int id, String subname, String annualprice,String quaterlyprice,String monthlyprice,
      WidgetRef ref) async {
    final loadingState = ref.watch(loadingProvider.notifier);
    

 final prefs = await SharedPreferences.getInstance();
 
    final extractData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
        var access=extractData['accessToken'];
         print("accesstoken:$access");

    int responseCode = 0;
    String? errorMessage;
    try {
      loadingState.state = true;
    
      var response = await http.patch(Uri.parse(Api.subscriptions),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':access
          },
          body: json.encode({"id":id.toString(),"name":subname,"annualpricing":annualprice,
          "quaterlypricing":quaterlyprice,"monthlypricing":monthlyprice}));

      var userDetails = json.decode(response.body);
      var statuscode = response.statusCode;
      print('$statuscode');
      responseCode = statuscode;
      print('server response:$userDetails');
      switch (response.statusCode) {
        case 200:
          state = subscription.fromJson(userDetails);
          loadingState.state = false;

          //print('this is from Auth response is:$accessToken');

          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode({
            'refreshToken': userDetails['data']['refresh_token'],
            'accessToken': userDetails['data']['access_token'],
            'firstName': userDetails['data'][''],
            'userRole': userDetails['data']['userRole'],
            'password': userDetails['data']['password']
          });

          //autologout();

          await prefs.setString('userData', userData);
          await prefs.setBool('isLoggedIn', true);
          break;
        default:
          if (statuscode != 201) {
            loadingState.state = false;
          }
          // Optionally set a message to show to the user why the login failed
          break;
      }
      if (statuscode == 200) {
        // Handle successful login...
      } else {
        // Any other status code means something went wrong
        // Extract error message from response
        // Assuming 'messages' is a List of messages and we take the first one.
        errorMessage =
            userDetails['messages']?.first ?? 'An unknown error occurred.';
        // Alternatively, if 'message' is a single String with the error message:
        // errorMessage = responseJson['message'];
      }
    } catch (e) {
      loadingState.state = false;
      errorMessage = e.toString();
      print("cathe:$errorMessage");
    }
    return SubscriberResult(responseCode, errorMessage: errorMessage);
  }

  Future<void> getProperty() async{
  try{
final response = await http.get(Uri.parse(Api.getProperty));
var res=json.decode(response.body);
var userData=subscription.fromJson(res);
state=userData;
print(userData.data);
print(res);
 
  }catch(e){};
}


Data? getSubById(int id) {
  return state.data?.firstWhere((user) => user.id == id, );
}



}

final propertyProvider = StateNotifierProvider<PropertyNotifier, subscription>((ref) {
  return PropertyNotifier();
});

class SubscriberResult {
  final int statusCode;
  final String? errorMessage;

  SubscriberResult(this.statusCode, {this.errorMessage});
}
