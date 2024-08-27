import 'dart:convert';
import 'dart:io';
import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Models/registrationstatemodel.dart';
import 'package:banquetbookz_vendor/Providers/registrationnotifier.dart';
import 'package:banquetbookz_vendor/Providers/stateproviders.dart';
import 'package:banquetbookz_vendor/Providers/textfieldstatenotifier.dart';
import 'package:banquetbookz_vendor/Widgets/elevatedbutton.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:banquetbookz_vendor/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

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
  final TextEditingController add1 = TextEditingController();
  final TextEditingController add2 = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pin = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController propertyName =
      TextEditingController(); // New field
  final TextEditingController category = TextEditingController(); // New field
  final TextEditingController startTime = TextEditingController(); // New field
  final TextEditingController endTime = TextEditingController(); // New field

  final registrationProvider =
      StateNotifierProvider<RegistrationNotifier, RegistrationState>(
    (ref) => RegistrationNotifier(),
  );

  final _validationKey = GlobalKey<FormState>();
  final MapController _mapController = MapController();
  final ImagePicker _picker = ImagePicker();

  void _searchLocation(WidgetRef ref) async {
    final response = await http.get(Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=${location.text}&format=json&addressdetails=1&limit=1',
    ));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.isNotEmpty) {
        double lat = double.parse(data[0]['lat']);
        double lon = double.parse(data[0]['lon']);
        ref.read(latlangs.notifier).state = LatLng(lat, lon);
        print("Location: ${LatLng(lat, lon)}");
        _mapController.move((ref.watch(latlangs)), 15.0);
      }
    }
  }

  Future<void> _pickImage(
      BuildContext context, ImageSource source, bool isProfile) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      if (isProfile) {
        ref
            .read(registrationProvider.notifier)
            .setProfileImage(File(pickedFile.path));
      } else {
        ref
            .read(registrationProvider.notifier)
            .setPropertyImage(File(pickedFile.path));
      }
    }
  }

  Widget _buildImageUploadSection(
      String label, File? imageFile, bool isProfile) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () => _pickImage(context, ImageSource.gallery, isProfile),
        child: Container(
          width: double.infinity,
          height: 150,
          color: CoustColors.colrButton1,
          child: Center(
            child: imageFile == null
                ? coustText(sName: "Upload photo", align: TextAlign.center)
                : Image.file(imageFile),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilePic = ref.watch(registrationProvider).profileImage;
    final propertyPic = ref.watch(registrationProvider).propertyImage;

    return Scaffold(
        backgroundColor: CoustColors.colrFill,
        appBar: AppBar(
          backgroundColor: CoustColors.colrFill,
          title: const coustText(
            sName: 'Register',
            txtcolor: CoustColors.colrEdtxt2,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: CoustColors.colrHighlightedText),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CoustColors.colrMainbg,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        const coustText(
                          sName: "Vendor Cover Page",
                          textsize: 24,
                          fontweight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        _buildImageUploadSection(
                            "Property Image", propertyPic, false),
                        const SizedBox(height: 10),
                        const coustText(
                          sName: "Field Required",
                          textsize: 14,
                          fontweight: FontWeight.bold,
                          txtcolor: CoustColors.colrStrock2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer(builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final textFieldStates = ref.watch(textFieldStateProvider);
                    return Form(
                      key: _validationKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: CoustColors.colrMainbg,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: coustText(
                                    sName: "Vendor Details",
                                    textsize: 24,
                                    fontweight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildImageUploadSection(
                                    "Profile Image", profilePic, true),
                                regform(
                                    "User Name",
                                    name,
                                    "Please Enter User Name",
                                    ref,
                                    0,
                                    textFieldStates),
                                regform(
                                    "Email Id",
                                    emailid,
                                    "Please Enter Email Id",
                                    ref,
                                    1,
                                    textFieldStates),
                                regform(
                                    "Password",
                                    pwd,
                                    "Please Enter Password",
                                    ref,
                                    2,
                                    textFieldStates),
                                regform(
                                    "Contact Number",
                                    mobile,
                                    "Please Enter Contact Number",
                                    ref,
                                    3,
                                    textFieldStates),
                                regform(
                                    "Vendor Address Line 1",
                                    add1,
                                    "Please Enter Address 1",
                                    ref,
                                    4,
                                    textFieldStates),
                                regform(
                                    "Vendor Address Line 2",
                                    add2,
                                    "Please Enter Address 2",
                                    ref,
                                    5,
                                    textFieldStates),
                                regform("State", state, "Please Enter State",
                                    ref, 6, textFieldStates),
                                regform("City", city, "Please Enter City", ref,
                                    7, textFieldStates),
                                regform(
                                    "Pincode",
                                    pin,
                                    "Please Enter Pin Number",
                                    ref,
                                    8,
                                    textFieldStates),
                                regform(
                                    "Property Name",
                                    propertyName,
                                    "Please Enter Property Name",
                                    ref,
                                    9,
                                    textFieldStates),
                                regform(
                                    "Category",
                                    category,
                                    "Please Enter Category",
                                    ref,
                                    10,
                                    textFieldStates),
                                regform(
                                    "Start Time",
                                    startTime,
                                    "Please Enter Start Time",
                                    ref,
                                    11,
                                    textFieldStates),
                                regform(
                                    "End Time",
                                    endTime,
                                    "Please Enter End Time",
                                    ref,
                                    12,
                                    textFieldStates),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CoustTextfield(
                                    filled: textFieldStates[9],
                                    radius: 8.0,
                                    width: 10,
                                    isVisible: true,
                                    iconwidget:
                                        const Icon(Icons.location_searching),
                                    suficonColor: CoustColors.colrMainText,
                                    hint: "Location",
                                    title: "Location",
                                    controller: location,
                                    onChanged: (location) {
                                      ref
                                          .read(textFieldStateProvider.notifier)
                                          .update(9, false);
                                      _searchLocation(ref);
                                    },
                                    validator: (txtController) {
                                      if (txtController == null ||
                                          txtController.isEmpty) {
                                        return "Enter location or point in maps";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: FlutterMap(
                                    mapController: _mapController,
                                    options: MapOptions(
                                      initialCenter: (ref.watch(latlangs)),
                                      initialZoom: 15,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            width: 80.0,
                                            height: 80.0,
                                            point: (ref.watch(latlangs)),
                                            child: Container(
                                              child: const Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return CoustElevatedButton(
                                  buttonName: "Register",
                                  width: double.infinity,
                                  bgColor: CoustColors.colrButton3,
                                  radius: 8,
                                  FontSize: 20,
                                  onPressed: () {
                                    if (_validationKey.currentState!
                                        .validate()) {
                                      var loc =
                                          (ref.read(latlangs.notifier).state);
                                      String sLoc =
                                          '${loc.latitude.toStringAsFixed(7)},${loc.longitude.toStringAsFixed(7)}';
                                      ref
                                          .read(registrationProvider.notifier)
                                          .register(
                                            context,
                                            ref,
                                            name.text.trim(),
                                            emailid.text.trim(),
                                            pwd.text.trim(),
                                            mobile.text.trim(),
                                            add1.text.trim(),
                                            add2.text.trim(),
                                            sLoc,
                                            state.text.trim(),
                                            city.text.trim(),
                                            pin.text.trim(),
                                            profilePic!.path,
                                            propertyPic!.path,
                                            propertyName.text
                                                .trim(), // New field
                                            category.text.trim(), // New field
                                            startTime.text.trim(), // New field
                                            endTime.text.trim(), // New field
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            )));
  }

  Widget regform(String name, TextEditingController txtController,
      String erromsg, WidgetRef ref, int index, List<bool> textFieldStates) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CoustTextfield(
        filled: textFieldStates[index],
        radius: 8.0,
        width: 10,
        isVisible: true,
        hint: name,
        title: name,
        controller: txtController,
        onChanged: (txtController) {
          ref.read(textFieldStateProvider.notifier).update(index, false);
          return null;
        },
        validator: (txtController) {
          if (txtController == null || txtController.isEmpty) {
            return erromsg;
          }
          return null;
        },
      ),
    );
  }
}
