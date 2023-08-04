import 'package:flutter/cupertino.dart';
import 'package:go_marche/screens/profile/components/update_language.dart';
import 'package:go_marche/screens/profile/components/update_location.dart';
import 'package:go_marche/screens/profile/components/update_name.dart';
import 'package:go_marche/screens/profile/components/update_phone_number.dart';
import 'package:go_marche/screens/profile/components/update_store_name.dart';

class ProfileTile {
  final String title;
  final String subtitle;
  final Widget page;

  ProfileTile({
    required this.title,
    required this.subtitle,
    required this.page,
  });
}

List<ProfileTile> profileTiles = [
  ProfileTile(
    title: 'Name',
    subtitle: 'Mohammad Azeez',
    page: UpdateName(),
  ),
  ProfileTile(
    title: 'Phone Number',
    subtitle: '+964 750 371 78 34',
    page: UpdatePhoneNumber(),
  ),
  ProfileTile(
    title: 'Language',
    subtitle: 'English',
    page: UpdateLanguage(),
  ),
  ProfileTile(
    title: 'Location',
    subtitle: 'Rzgari, Erbil - Iraq',
    page: UpdateLocation(),
  ),
  ProfileTile(
    title: 'Store Name',
    subtitle: 'Rzgari SuperMarket',
    page: UpdateStoreName(),
  ),
];
