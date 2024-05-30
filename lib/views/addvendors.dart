import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:vendor_pannel/providers/location.dart';

import '../providers/imageprovider.dart';
import '../providers/usersprovider.dart';
import '/providers/bottomnavigationbarprovider.dart';

import '/providers/loader.dart';
import '/providers/selectionmodal.dart';

import '/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/customelevatedbutton.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({super.key});

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> with TickerProviderStateMixin {
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeContact = FocusNode();
  final FocusNode _focusNodeAD1 = FocusNode();
  final FocusNode _focusNodeAD2 = FocusNode();
  final FocusNode _focusNodeState = FocusNode();
  final FocusNode _focusNodeCity = FocusNode();
  final FocusNode _focusNodePincode = FocusNode();
  FocusNode focusNodeCurrentLocation = FocusNode();
  bool mapcreated = false;
    late AnimationController _animationController;
  late Animation<LatLng> _animation;
MapController mapController = MapController();
  bool _isFocusedName = false;
  bool _isFocusedEmail = false;
  bool _isFocusedContact = false;
  bool _isFocusedAD1 = false;
  bool _isFocusedAD2 = false;
  bool _isFocusedState = false;
  bool _isFocusedCity = false;
  bool _isFocusedPincode = false;

void animateCamera(LatLng targetPosition, double zoom) {
    if (!mapcreated) return; // Do nothing if the map is not created

    LatLng startPosition = LatLng(
      mapController.camera.center.latitude,
      mapController.camera.center.longitude,
    );

    _animation = LatLngTween(
      begin: startPosition,
      end: targetPosition,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Customize the animation curve
      ),
    );

    _animationController.addListener(() {
      LatLng newPos = _animation.value;
      mapController.move(newPos, zoom);
    });
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.reset();
    _animationController.forward();
  }
   void _onFocusChange() {
    // Call setState to rebuild the widget with the changed focus state
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
      _animationController = AnimationController(
        
      vsync: this,
      duration: const Duration(seconds: 2), // Customize the duration
    );
     focusNodeCurrentLocation.addListener(_onFocusChange);
    _focusNodeName.addListener(_handleFocusChangeName);
    _focusNodeEmail.addListener(_handleFocusChangeEmail);
    _focusNodeContact.addListener(_handleFocusChangeContact);
    _focusNodeAD1.addListener(_handleFocusChangeAD1);
    _focusNodeAD2.addListener(_handleFocusChangeAD2);
    _focusNodeState.addListener(_handleFocusChangeState);
    _focusNodeCity.addListener(_handleFocusChangeCity);
    _focusNodePincode.addListener(_handleFocusChangePincode);
  }

  void _handleFocusChangeName() {
    if (_focusNodeName.hasFocus != _isFocusedName) {
      setState(() {
        _isFocusedName = _focusNodeName.hasFocus;
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

  void _handleFocusChangeContact() {
    if (_focusNodeContact.hasFocus != _isFocusedContact) {
      setState(() {
        _isFocusedContact = _focusNodeContact.hasFocus;
      });
    }
  }

  void _handleFocusChangeAD1() {
    if (_focusNodeAD1.hasFocus != _isFocusedAD1) {
      setState(() {
        _isFocusedAD1 = _focusNodeAD1.hasFocus;
      });
    }
  }

  void _handleFocusChangeAD2() {
    if (_focusNodeAD2.hasFocus != _isFocusedAD2) {
      setState(() {
        _isFocusedAD2 = _focusNodeAD2.hasFocus;
      });
    }
  }

  void _handleFocusChangeState() {
    if (_focusNodeState.hasFocus != _isFocusedState) {
      setState(() {
        _isFocusedState = _focusNodeState.hasFocus;
      });
    }
  }

  void _handleFocusChangeCity() {
    if (_focusNodeCity.hasFocus != _isFocusedCity) {
      setState(() {
        _isFocusedCity = _focusNodeCity.hasFocus;
      });
    }
  }

  void _handleFocusChangePincode() {
    if (_focusNodePincode.hasFocus != _isFocusedPincode) {
      setState(() {
        _isFocusedPincode = _focusNodePincode.hasFocus;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<ImageSource?> _showImageSourceSelector(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final controller = ref.watch(selectionModelProvider.notifier);
        final pickedImage = ref.watch(imageProvider).coverPage;
        final selection = ref.watch(selectionModelProvider);
        final loading = ref.watch(loadingProvider);
        return SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
            width: ScreenWidth,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFf5f5f5),
            child: Column(
              children: [
                Container(
                    child: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0XFF6418C3),
                      )),
                  backgroundColor: const Color(0xfff5f5f5),
                  title: const Text(
                    "Register",
                    style: TextStyle(color: Color(0XFF6418C3), fontSize: 20),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Vender Coverpage",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer(builder: (context, ref, child) {
                        final pickedImage = ref.watch(imageProvider).coverPage;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("coverpage");
                              },
                              child: pickedImage != null
                                  ? Container(
                                      width: ScreenWidth * 0.7,
                                      height: 150,
                                      child: Image.file(File(pickedImage.path)))
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xffb4b4b4),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      width: ScreenWidth * 0.7,
                                      height: 150,
                                      alignment: Alignment.center,
                                      child: const Text("Upload Photo"),
                                    ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              pickedImage != null ? "" : "field required",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Vender Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "User Name",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodeName,
                        filled: true,
                        filledColor:
                            _isFocusedName ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderName(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "User Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Email ID",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.emailAddress,
                        focusNode: _focusNodeEmail,
                        filled: true,
                        filledColor:
                            _isFocusedEmail ? Colors.white : Colors.grey[300],
                        onChanged: (newValue) {
                          controller.updateVenderEmail(newValue);
                        },
                        applyDecoration: true,
                        hintText: "Email ID",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          width: ScreenWidth * 0.8,
                          textController: selection.password,
                          hintText: "password",
                          filled: true,
                          onChanged: (newVlue) {
                            controller.updateEnteredPassword(newVlue);
                          },
                          filledColor:
                              _isFocusedEmail ? Colors.white : Colors.grey[300],
                          applyDecoration: true),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Contact Number",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.number,
                        focusNode: _focusNodeContact,
                        filled: true,
                        filledColor:
                            _isFocusedContact ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderContact(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "Contact Number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Vender Adress Line 1",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodeAD1,
                        filled: true,
                        filledColor:
                            _isFocusedAD1 ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderAD1(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "Address line 1",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Vender Adress Line 2",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodeAD2,
                        filled: true,
                        filledColor:
                            _isFocusedAD2 ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderAD2(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "Address line 2",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "State",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodeState,
                        filled: true,
                        filledColor:
                            _isFocusedState ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderState(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "State",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "City",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodeCity,
                        filled: true,
                        filledColor:
                            _isFocusedCity ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderCity(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "City",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Pincode",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodePincode,
                        filled: true,
                        filledColor:
                            _isFocusedPincode ? Colors.white : Colors.grey[300],
                        onChanged: (newVlue) {
                          controller.updateVenderPincode(newVlue);
                        },
                        applyDecoration: true,
                        hintText: "Pin code",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Location of property",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                      suffixIcon:const Icon(Icons.my_location) ,
                      textController: selection.location,
                      onSuffixIconTap: (){
                        ref.read(locationProvider.notifier).getLocation(selection.location,ref);
                           
                      },
                        readOnly: true,
                        width: ScreenWidth * 0.8,
                        keyBoardType: TextInputType.text,
                        focusNode: _focusNodePincode,
                        filled: true,
                        filledColor:
                            _isFocusedPincode ? Colors.white : Colors.grey[300],
                      
                        applyDecoration: true,
                        hintText: "Location",
                        
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: ScreenWidth * 0.8,
                        height: 200,
                        child: Consumer(builder: (context, ref, child) {
                          print("move map");
                          ref.watch(mapControllerProvider);
                          var location=ref.read(locationProvider.notifier);
                          return FlutterMap(
                            mapController: ref.watch(mapControllerProvider),
                            options: const MapOptions(
                               initialCenter: LatLng(
                          17.4065, 78.4772),
                            
                            ),
                            children: [
                              TileLayer(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                 ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point:location.state != null ? LatLng(location.state!.latitude!,location.state!.longitude!):LatLng(0.0,0.0),
                                    child: 
                                    Container(
                                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                         
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                  text: "Register",
                  borderRadius: 10,
                  foreGroundColor: Colors.white,
                  width: double.infinity,
                  backGroundColor: const Color(0XFF6418C3),
                  isLoading: loading,
                  onPressed: loading
                      ? null
                      : () async {
                        print("button pressed");
 bool isFormValid = _formKey.currentState!.validate();
  print("Form valid: $isFormValid");

  // Check if image is picked and print it
  bool isImagePicked = pickedImage != null;
  print("Image picked: $isImagePicked");
                          if (_formKey.currentState!.validate() &&
                              pickedImage != null) {
                                print("form is validated");
                            // If the form is valid, proceed with the login process

                            final UserResult result = await ref
                                .read(usersProvider.notifier)
                                .addUser(
                                    pickedImage,
                                    selection.venderName.text,
                                    selection.venderEmail.text,
                                    selection.gender,
                                    selection.venderContact.text,
                                    selection.venderAD1.text,
                                    selection.venderAD2.text,
                                    "${ref.read(locationProvider.notifier).state!.latitude!},${ref.read(locationProvider.notifier).state!.longitude!}",
                                    selection.venderContact.text,
                                    selection.venderState.text,
                                    selection.venderCity.text,
                                    selection.vendorPincode.text,
                                    ref);
                            if (result.statusCode == 201) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Icon(Icons.check_circle,
                                              size: 50,
                                              color: Color(0XFF6418C3)),
                                          const SizedBox(height: 15),
                                          const Text(
                                            'Registration sucessfull',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                         
                                          const SizedBox(height: 20),
                                          CustomElevatedButton(
                                            text: "OK",
                                            borderRadius: 20,
                                            width: 100,
                                            foreGroundColor: Colors.white,
                                            backGroundColor:
                                                const Color(0XFF6418C3),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (result.statusCode == 400) {
                              // If an error occurred, show a dialog box with the error message.
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Register Error'),
                                    content: Text(result.errorMessage ??
                                        'An unknown error occurred.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog box
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }

  @override
  void dispose() {
    _focusNodeName.removeListener(_handleFocusChangeName);
    _focusNodeName.dispose();
    _focusNodeEmail.removeListener(_handleFocusChangeEmail);
    _focusNodeEmail.dispose();
    _focusNodeContact.removeListener(_handleFocusChangeContact);
    _focusNodeContact.dispose();
    _focusNodeAD1.removeListener(_handleFocusChangeAD1);
    _focusNodeAD1.dispose();
    _focusNodeAD2.removeListener(_handleFocusChangeAD2);
    _focusNodeAD2.dispose();
    _focusNodeState.removeListener(_handleFocusChangeState);
    _focusNodeState.dispose();
    _focusNodeCity.removeListener(_handleFocusChangeCity);
    _focusNodeCity.dispose();
    _focusNodePincode.removeListener(_handleFocusChangePincode);
    _focusNodePincode.dispose();

    super.dispose();
  }
}
