class authState {
  int? statusCode;
  bool? success;
  List<String>? messages;
  Data? data;

  authState({this.statusCode, this.success, this.messages, this.data});

  authState.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = json['messages'].cast<String>();
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  authState copyWith({
    bool? isLoggedIn,
    int? statusCode,
    bool? success,
    List<String>? messages,
    Data? data,
  }) {
    return authState(
      statusCode: statusCode ?? this.statusCode,
      success: success ?? this.success,
      messages: messages ?? this.messages,
      data: data,
    );
  }

  factory authState.initial() {
    return authState(
      statusCode: 0,
      success: false,
      messages: [],
      data: Data.initial(),
    );
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  int? id;
  String? profilePic;
  String? firstName;
  String? lastName;
  String? height;
  String? weight;
  String? dob;
  String? location;
  String? address;
  String? emailId;
  String? password;
  int? mobileNo;
  String? gender;
  String? address2;
  String? city;
  String? zip;
  String? userRole;

  Data({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.height,
    this.weight,
    this.dob,
    this.location,
    this.address,
    this.emailId,
    this.password,
    this.mobileNo,
    this.gender,
    this.address2,
    this.city,
    this.zip,
    this.userRole,
  });

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    id = json['id'];
    profilePic = json['profilePic'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    location = json['location'];
    address = json['address'];
    emailId = json['emailId'];
    password = json['password'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    address2 = json['address2'];
    city = json['city'];
    zip = json['zip'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['id'] = this.id;
    data['profilePic'] = this.profilePic;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['address'] = this.address;
    data['emailId'] = this.emailId;
    data['password'] = this.password;
    data['mobileNo'] = this.mobileNo;
    data['gender'] = this.gender;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['userRole'] = this.userRole;
    return data;
  }

  Data copyWith({
    String? accessToken,
    String? refreshToken,
    int? id,
    String? profilePic,
    String? firstName,
    String? lastName,
    String? height,
    String? weight,
    String? dob,
    String? location,
    String? address,
    String? emailId,
    String? password,
    int? mobileNo,
    String? gender,
    String? address2,
    String? city,
    String? zip,
    String? userRole,
  }) {
    return Data(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
      profilePic: profilePic ?? this.profilePic,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      dob: dob ?? this.dob,
      location: location ?? this.location,
      address: address ?? this.address,
      emailId: emailId ?? this.emailId,
      password: password ?? this.password,
      mobileNo: mobileNo ?? this.mobileNo,
      gender: gender ?? this.gender,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      userRole: userRole ?? this.userRole,
    );
  }

  factory Data.initial() {
    return Data(
      accessToken: '',
      refreshToken: '',
      id: 0,
      profilePic: '',
      firstName: '',
      lastName: '',
      height: '',
      weight: '',
      dob: '',
      location: '',
      address: '',
      emailId: '',
      password: '',
      mobileNo: 0,
      gender: '',
      address2: '',
      city: '',
      zip: '',
      userRole: '',
    );
  }
}
