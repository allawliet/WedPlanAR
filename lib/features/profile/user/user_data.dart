import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static UserModel myUser = UserModel(
    image:
        "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    username: 'admin',
    password: 'P@ssw0rd',
    name: 'Test Test',
    email: 'test@gmail.com',
    phone: '(60) 11110273111',
    about:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quist...',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserModel user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static UserModel getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : UserModel.fromJson(jsonDecode(json));
  }
}
