import 'dart:convert';
import 'dart:io' as platform;
import 'dart:io';

import 'dart:math';
import 'dart:typed_data';
import '/models/authstate.dart' as auth;
import '/models/getuser.dart';
import '/providers/getsubscribers.dart';
import '/providers/loader.dart';
import '/utils/banquetbookzapi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/retry.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';


class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());
  void setImageFile(XFile? file) {

    }
    Future<platform.File?> getImageFile(BuildContext context) async {
    // if (state.data != null) {
    //   final data = state.data![0];
    //   if (data.xfile == null) {
    //     return null;
    //   }
    //   final platform.File file = platform.File(data.xfile!.path);
    //   return file;
    // }

    return null;
  }

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

  

Future<UserResult> addUser(
  XFile imageFile, 
  String firstName, 
  String emailId, 
  String gender, 
  String mobileNo, 
  String address1, 
  String address2, 
  String location, 
  String state, 
  String city, 
  String pincode, 
  String password, // Add password parameter
  WidgetRef ref
) async {
  var uri = Uri.parse(Api.addUser);
  final loadingState = ref.watch(loadingProvider.notifier);

  int responseCode = 0;
  String? errorMessage;

  try {
    loadingState.state = true;
    var request = http.MultipartRequest('POST', uri);
    
    // Add the image file to your request.
    request.files.add(await http.MultipartFile.fromPath('property_pic', imageFile.path));

    // Add the other form fields to your request.
    request.fields['username'] = firstName;
    request.fields['email'] = emailId;
    request.fields['gender'] = gender;
    request.fields['mobileno'] = mobileNo;
    request.fields['address_1'] = address1;
    request.fields['address_2'] = address2;
    request.fields['location'] = location;
    request.fields['state'] = state;
    request.fields['city'] = city;
    request.fields['pincode'] = pincode;
    request.fields['password'] = password; // Add password to the request

    final send = await request.send();
    final res = await http.Response.fromStream(send);
    var userDetails = json.decode(res.body);
    var statusCode = res.statusCode;
    responseCode = statusCode;
    print("statuscode: $statusCode");
    print("responsebody: ${res.body}");
    
    errorMessage = userDetails['messages']?.first ?? 'An unknown error occurred.';
  } catch (e) {
    errorMessage = e.toString();
    print("catch: $errorMessage");
  } finally {
    loadingState.state = false;
  }

  return UserResult(responseCode, errorMessage: errorMessage);
}

  Future<void> getUsers() async{
  try{
final response = await http.get(Uri.parse(Api.addUser));
var res=json.decode(response.body);
var userData=User.fromJson(res);
state=userData;
print(userData.data);
print(res);
 
  }catch(e){};
}

Future<void> sendEmail(String toEmail, String subject, String body) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: toEmail, // recipient email address
    query: encodeQueryParameters(<String, String>{
      'subject': subject, // subject of the email
      'body': body, // body of the email
    }),
  );

 
}

// Helper function to encode query parameters
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

 Future<void> getUserPic(BuildContext cont, WidgetRef ref,int id) async {
  print("userid:$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "${Api.profilePic}/$id";
    final loadingState = ref.read(loadingProvider.notifier);
    loadingState.state = true;
    // final token = authNotifier.state.accessToken;
    // Check for cached image
    // String? cachedBase64String = prefs.getString('userProfilePic');
    // if (cachedBase64String != null) {
    //   final Uint8List bytes = base64Decode(cachedBase64String);
    //   final tempDir = await getTemporaryDirectory();
    //   final file = File('${tempDir.path}/profile');
    //   await file.writeAsBytes(bytes);
    //   if (state.data != null) {
    //     state.data![id].xfile = XFile(file.path);
    //   }
    //   loadingState.state = false;
    //   return;
    // }
    
    var response = await http.get(
      Uri.parse(url),
     
    );
    //Map<String, dynamic> userResponse = json.decode(response.body);

    switch (response.statusCode) {
      case 200:

        // Attempt to create an Image object from the image bytes
        // final image = Image.memory(resbytes);
        final Uint8List resbytes = response.bodyBytes;
print("image response:$resbytes");
        // Cache image
        String base64String = base64Encode(resbytes);
        await prefs.setString('userProfilePic', base64String);

        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/profile');
        await file.writeAsBytes(resbytes);
        if (state.data != null) {
          final user = state.data!.firstWhere((user) => user.id == id);
user.xfile = XFile(file.path);
        }

        // If the image was created successfully, the bytes are in a valid format

        loadingState.state = false;
    }

    // print(
    //     "this is from getuserPic:${userDetails!.data![0].xfile!.readAsBytes()}");
  }


UserData? getUserById(int id) {
  return state.data?.firstWhere((user) => user.id == id, );
}
  
}

final usersProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserResult {
  final int statusCode;
  final String? errorMessage;

  UserResult(this.statusCode, {this.errorMessage});
}
