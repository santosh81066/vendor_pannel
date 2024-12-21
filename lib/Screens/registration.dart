// Import necessary packages
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';  // Import the geocoding package
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vendor_pannel/Colors/coustcolors.dart';
import 'package:vendor_pannel/Models/registrationstatemodel.dart';
import 'package:vendor_pannel/Providers/registrationnotifier.dart';
import 'package:vendor_pannel/Providers/stateproviders.dart';
import 'package:vendor_pannel/Providers/textfieldstatenotifier.dart';
import 'package:vendor_pannel/Widgets/elevatedbutton.dart';
import 'package:vendor_pannel/Widgets/text.dart';
import 'package:vendor_pannel/Widgets/textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController pwd = TextEditingController();
  final TextEditingController mobile = TextEditingController();

  final _validationKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }




// Updated method to get timezone based on coordinates using geocoding and timezone package
Future<String> _getTimezoneFromLocation(Position position) async {
  try {
    // Get the address from the latitude and longitude
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    
    // Use the locality or country to try and fetch timezone
    String country = placemarks.first.country ?? "UTC";
    
    // We can manually map the country to a known timezone, e.g., "India" -> "Asia/Kolkata"
    // Consider using a more extensive list or an API for more precise mappings
    if (country == "India") {
      return "Asia/Kolkata";
    } else if (country == "United States") {
      return "America/New_York";
    } else {
      // Fallback to a default timezone, UTC
      return "UTC";
    }
  } catch (e) {
    print('Error getting timezone: $e');
    return 'UTC'; // Default to UTC if there is an error
  }
}

  Future<String> getUserTimezone() async {
    try {
      Position position = await _getCurrentLocation();
      return await _getTimezoneFromLocation(position);
    } catch (e) {
      return 'UTC'; // Default to UTC if location fetch fails
    }
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
  try {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Check the file size (maximum 2MB)
      final fileSizeInBytes = await imageFile.length();
      final maxFileSize = 2 * 1024 * 1024; // 2MB in bytes

      if (fileSizeInBytes > maxFileSize) {
        // File size is too large, show an error
        _showAlertDialog('Error', 'File size exceeds 2MB. Please select a smaller file.');
      } else {
        // Valid image size, proceed
        setState(() {
          _profileImage = imageFile;
        });
      }
    }
  } catch (e) {
    _showAlertDialog('Error', 'Failed to pick image: $e');
  }
}


  Widget _buildImageUploadSection(String label) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () => _pickImage(context, ImageSource.gallery),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: CoustColors.colrButton1,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: _profileImage != null
                ? Image.file(
                    _profileImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt, size: 40, color: Colors.white),
                      SizedBox(height: 10),
                      coustText(
                        sName: "Upload Profile Image",
                        txtcolor: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoustColors.colrFill,
      appBar: AppBar(
        backgroundColor: CoustColors.colrFill,
        title: const coustText(
          sName: 'Register',
          txtcolor: CoustColors.colrEdtxt2,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CoustColors.colrHighlightedText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Form(
                    key: _validationKey,
                    child: Column(
                      children: [
                        _buildImageUploadSection("Profile Image"),
                        regform("User Name", name, "Please Enter User Name", ref, 0),
                        regform("Email Id", emailid, "Please Enter Email Id", ref, 1),
                        regform("Password", pwd, "Please Enter Password", ref, 2),
                        regform("Contact Number", mobile, "Please Enter Contact Number", ref, 3),
                        SizedBox(
                          width: double.infinity,
                          child: CoustElevatedButton(
                            buttonName: "Register",
                            width: double.infinity,
                            bgColor: CoustColors.colrButton3,
                            radius: 8,
                            FontSize: 20,
                            onPressed: () async {
                              if (_validationKey.currentState!.validate()) {
                                String timezone = await getUserTimezone();
                                ref.read(registrationProvider.notifier).register(
                                  context,
                                  ref,
                                  name.text.trim(),
                                  emailid.text.trim(),
                                  pwd.text.trim(),
                                  mobile.text.trim(),
                                  _profileImage,
                                  timezone,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget regform(String label, TextEditingController controller, String errorMsg, WidgetRef ref, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CoustTextfield(
        radius: 8.0,
        width: 10.0,
        isVisible: true,
        hint: label,
        title: label,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMsg;
          }
          return null;
        },
      ),
    );
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              
              if (title == 'Error') {
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

final registrationProvider = StateNotifierProvider<RegistrationNotifier, RegistrationState>(
  (ref) => RegistrationNotifier(),
);
