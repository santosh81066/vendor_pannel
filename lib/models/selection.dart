import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SelectionModel {
  final bool? isAuth;
  final String? sub;
  final bool checkBox;
  final bool changePassword;
  final String gender;
  final bool isLoading;
  final bool? dashboard;
  final bool addUser;
  final bool editUser;
  final int? userIndex;
  final int? subscriberIndex;
  final bool? loginEmail;
  final bool? subDetails;
  final String? errorMessage;
  final TextEditingController email;
  final TextEditingController useremail;
  final TextEditingController name;
  TextEditingController password; // Made non-final to assign within constructor
  final TextEditingController subName;
  final TextEditingController annualP;
  final TextEditingController location;
  final TextEditingController monthlyP;
  final TextEditingController venderName;
  final TextEditingController venderEmail;
  final TextEditingController venderContact;
  final TextEditingController venderAD1;
  final TextEditingController venderAD2;
  final TextEditingController venderState;
  final TextEditingController venderCity;
  final TextEditingController vendeerPincode;
  final TextEditingController adminEmail;
  final TextEditingController adminPassword;

  SelectionModel({
    this.isAuth = false,
    this.sub = "d",
    this.checkBox = false,
    this.changePassword = false,
    this.gender = "m",
    this.isLoading = false,
    this.dashboard = true,
    this.addUser = false,
    this.editUser = false,
    this.userIndex,
    this.subscriberIndex,
    this.loginEmail,
    this.subDetails = false,
    this.errorMessage,
    TextEditingController? email,
    TextEditingController? useremail,
    TextEditingController? name,
    TextEditingController? password, // Removed the default value
    TextEditingController? subName,
    TextEditingController? annualP,
    TextEditingController? location,
    TextEditingController? monthlyP,
    TextEditingController? venderName,
    TextEditingController? venderEmail,
    TextEditingController? venderContact,
    TextEditingController? venderAD1,
    TextEditingController? venderAD2,
    TextEditingController? venderState,
    TextEditingController? venderCity,
    TextEditingController? vendeerPincode,
    TextEditingController? adminEmail,
    TextEditingController? adminPassword,
  })  : email = email ?? TextEditingController(),
        useremail = useremail ?? TextEditingController(),
        name = name ?? TextEditingController(),
        // Assign a default value within the constructor body
        password =  TextEditingController(),
        subName = subName ?? TextEditingController(),
        annualP = annualP ?? TextEditingController(),
        location = location ?? TextEditingController(),
        monthlyP = monthlyP ?? TextEditingController(),
        venderName = venderName ?? TextEditingController(),
        venderEmail = venderEmail ?? TextEditingController(),
        venderContact = venderContact ?? TextEditingController(),
        venderAD1 = venderAD1 ?? TextEditingController(),
        venderAD2 = venderAD2 ?? TextEditingController(),
        venderState = venderState ?? TextEditingController(),
        venderCity = venderCity ?? TextEditingController(),
        vendeerPincode = vendeerPincode ?? TextEditingController(),
        adminEmail = adminEmail ?? TextEditingController(),
        adminPassword = adminPassword ?? TextEditingController();

  SelectionModel copyWith(
      {bool?isAuth,String?sub, bool? checkBox,bool?changePassword,String?gender, bool? isLoading,bool?dashboard,bool?addUser,bool? editUser,  int?userIndex,int?subscriberIndex, bool?loginEmail,
      bool?subDetails,String? errorMessage,TextEditingController? email,
      TextEditingController? useremail,
      TextEditingController? name,
      TextEditingController? password,
      TextEditingController? subName,
      TextEditingController? annualP ,TextEditingController? location,
      TextEditingController? monthlyP,
      TextEditingController? venderName,
      TextEditingController? venderEmail,
      TextEditingController? venderContact,
      TextEditingController? venderAD1,
      TextEditingController? venderAD2,
      TextEditingController? venderState,
      TextEditingController? venderCity,
      TextEditingController? vendeerPincode,
       TextEditingController? adminEmail,
      TextEditingController? adminPassword
}) {
    return SelectionModel(
      isAuth: isAuth??this.isAuth,
      sub: sub??this.sub,
        checkBox: checkBox ?? this.checkBox,
        changePassword: changePassword??this.changePassword,
        gender: gender??this.gender,
        isLoading: isLoading ?? this.isLoading,
        dashboard: dashboard??this.dashboard,
        addUser: addUser??this.addUser,
        editUser: editUser??this.editUser,
        userIndex: userIndex??this.userIndex,
        subscriberIndex: subscriberIndex??this.subscriberIndex,
        loginEmail:loginEmail??this.loginEmail,
        subDetails: subDetails??this.subDetails,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        useremail: useremail??this.useremail,
        name: name ?? this.name,
        password: password??this.password,
        subName: subName??this.subName,
        annualP: annualP??this.annualP,
        location: location??this.location,
        monthlyP: monthlyP??this.monthlyP,
        venderName: venderName??this.venderName,
        venderEmail: venderEmail??this.venderEmail,
        venderContact: venderContact??this.venderContact,
        venderAD1: venderAD1??this.venderAD1,
        venderAD2: venderAD2??this.venderAD2,
        venderState: venderState??this.venderState,
        venderCity: venderCity??this.venderCity,
        vendeerPincode: vendeerPincode??this.vendeerPincode,
        adminEmail: adminEmail??this.adminEmail,
        adminPassword: adminPassword??this.adminPassword

        // Preserve the original controller
        );
  }
}
