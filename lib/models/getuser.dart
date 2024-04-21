import 'package:image_picker/image_picker.dart';

class User {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<UserData>? data;

User({this.statusCode, this.success, this.messages, this.data});

  User.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add( UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? profilepic;
  String? firstName;
  String? lastName;
  String? height;
  String? weight;
  String? dob;
  String? location;
  String? address;
  String? address2;
  String? city;
  String? zip;
  String? emailId;
  String? password;
  int? mobileNo;
  String? gender;
  String? userrole;
  Null? userstatus;

   XFile? xfile;

  UserData(
      {this.id,
      this.profilepic,
      this.firstName,
      this.lastName,
      this.height,
      this.weight,
      this.dob,
      this.location,
      this.address,
      this.address2,
      this.city,
      this.zip,
      this.emailId,
      this.password,
      this.mobileNo,
      this.gender,
      this.userrole,
       this.xfile, 
      this.userstatus});



 

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilepic = json['profilepic'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    location = json['location'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    zip = json['zip'];
    emailId = json['emailId'];
    password = json['password'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    userrole = json['userrole'];
    userstatus = json['userstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profilepic'] = this.profilepic;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['emailId'] = this.emailId;
    data['password'] = this.password;
    data['mobileNo'] = this.mobileNo;
    data['gender'] = this.gender;
    data['userrole'] = this.userrole;
    data['userstatus'] = this.userstatus;
    return data;
  }
}
