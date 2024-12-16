import 'dart:convert';
import 'dart:io';
import 'package:vendor_pannel/utils/bbapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_pannel/Models/registrationstatemodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<RegistrationState> {
  RegistrationNotifier() : super(RegistrationState());
  void setProfileImage(File image) {
    state = state.copyWith(profileImage: image);
  }

  void setPropertyImage(File image) {
    state = state.copyWith(propertyImage: image);
  }

  Future<void> register(
    BuildContext context,
    WidgetRef ref,
    String? username,
    String? email,
    String? password,
    String? contactNumber,
    String? address1,
    String? address2,
    String? location,
    String? state,
    String? city,
    String? pincode,
    String? profilepic,
    String? propertypic,
    String? propertyName, // New field
    String? category, // New field
    String? startTime, // New field
    String? endTime, // New field
  ) async {
    Uri url = Uri.parse(Bbapi.registration);

    final request = http.MultipartRequest('POST', url);

    // Add the image files to the request
    if (propertypic != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'property.property_pic',
        propertypic,
      ));
    }
    if (profilepic != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        profilepic,
      ));
    }

    // Add the text fields to the request
    request.fields['username'] = username ?? '';
    request.fields['email'] = email ?? '';
    request.fields['password'] = password ?? '';
    request.fields['mobileno'] = contactNumber ?? '';
    request.fields['property.address_1'] = address1 ?? '';
    request.fields['property.address_2'] = address2 ?? '';
    request.fields['property.location'] = location ?? '';
    request.fields['property.state'] = state ?? '';
    request.fields['property.city'] = city ?? '';
    request.fields['property.pincode'] = pincode ?? '';
    request.fields['property.property_name'] = propertyName ?? '';
    request.fields['property.category'] = category ?? '';

    if (category != null) {
      // Ensure that the category is converted to an integer if required
      request.fields['property.category'] =
          category; // Adjust if it should be an integer
    }
    request.fields['property.start_time'] = startTime ?? '';
    request.fields['property.end_time'] = endTime ?? '';

    try {
      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      if (response.statusCode == 201) {
        // Handle the response data
        print(responseData);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Registration successful'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        Navigator.of(context)
            .pushNamed('/'); // Go to Login page if registered successfully
      } else {
        // Handle the error
        print('Registration failed with status: ${responseBody}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                  'Registration failed: ${responseData['message'] ?? 'Unknown error'}'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
