import 'dart:convert';

import 'package:go_marche/models/location_model.dart';

/// phoneNumber : "Phone Number"
/// name : "Name"
/// location : "Location"
/// storeName : "StoreName"
/// language : "English"

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    String? phoneNumber,
    String? name,
    LocationModel? location,
    String? storeName,
    String? language,
  }) {
    _phoneNumber = phoneNumber;
    _name = name;
    _location = location;
    _storeName = storeName;
    _language = language;
  }

  UserModel.fromJson(dynamic json) {
    _phoneNumber = json['phoneNumber'];
    _name = json['name'];
    _location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    _storeName = json['storeName'];
    _language = json['language'];
  }

  String? _phoneNumber;
  String? _name;
  LocationModel? _location;
  String? _storeName;
  String? _language;

  UserModel copyWith({
    String? phoneNumber,
    String? name,
    LocationModel? location,
    String? storeName,
    String? language,
  }) =>
      UserModel(
        phoneNumber: phoneNumber ?? _phoneNumber,
        name: name ?? _name,
        location: location ?? _location,
        storeName: storeName ?? _storeName,
        language: language ?? _language,
      );

  String? get phoneNumber => _phoneNumber;

  String? get name => _name;

  LocationModel? get location => _location;

  String? get storeName => _storeName;

  String? get language => _language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _phoneNumber;
    map['name'] = _name;
    if (this.location != null) {
      map['location'] = this.location!.toJson();
    }
    map['storeName'] = _storeName;
    map['language'] = _language;
    return map;
  }
}
