import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String image;
  String username;
  String name;
  String email;
  String phone;
  String about;
  String password;

  // Constructor
  UserModel({
    this.id,
    required this.image,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.about,
    required this.password,
  });

  UserModel copy({
    String? id,
    String? image,
    String? username,
    String? name,
    String? phone,
    String? email,
    String? about,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        image: image ?? this.image,
        username: username ?? this.username,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        about: about ?? this.about,
        password: password ?? this.password,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        image: json['image'],
        username: json['username'],
        name: json['name'],
        email: json['email'],
        about: json['about'],
        phone: json['phone'],
        password: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'username': username,
        'name': name,
        'email': email,
        'about': about,
        'phone': phone,
        'password': password,
      };

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      id: doc.id,
      image: data['image'],
      username: data['username'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      about: data['about'],
      password: data['password'],
    );
  }
}
