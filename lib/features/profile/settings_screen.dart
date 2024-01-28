import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wed_app/features/profile/profile_screen.dart';
import 'package:wed_app/features/profile/user/user.dart';
import 'package:wed_app/features/profile/user/user_data.dart';
import 'package:wed_app/features/rate_review/add_review_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userData = FirebaseFirestore.instance.collection('users');

  String myName = '';

  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserByEmail(String email) async {
    try {
      // Reference to the 'users' collection
      CollectionReference<Map<String, dynamic>> users = userData;

      // Query for the document with the specified email
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await users.where('email', isEqualTo: email).get();

      // Check if there is a matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Return the first document found
        return querySnapshot.docs.first;
      } else {
        // No matching document found
        return null;
      }
    } catch (e) {
      // Handle errors
      print('Error retrieving user data: $e');
      return null;
    }
  }

  Future getUserData(String email) async {
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();

    var data = await getUserByEmail(email);
    if (data != null && data.exists) {
      // var userDetails = {};
      setState(() {
      myName = data['name'];
      // userDetails = {
      // 'image': data['image'],
      // 'username': data['username'],
      // 'name': data['name'],
      // 'email': data['email'],
      // 'about': data['about'],
      // 'phone': data['phone'],
      // 'password': data['password'],
      // };

      _sharedPreferences.setString('username',data['username']);
      _sharedPreferences.setString('name',data['name']);
      _sharedPreferences.setString('phone',data['phone']);
      _sharedPreferences.setString('image',data['image']);
      _sharedPreferences.setString('email',data['email']);
      _sharedPreferences.setString('about',data['about']);
      });
      // _sharedPreferences.setString('users', jsonEncode(userDetails));
    }
  }

  // void loadData() async {
  //   final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     myName = _sharedPreferences.getString('name') ?? '';
  //   });
  // }

@override
  void initState() {
    // loadData();
    UserData.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getUserData(user.email.toString()),
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(myName,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const Icon(
                          Icons.verified,
                          size: 15,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Account", style: headingStyle),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Personal Information"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.rate_review),
                    title: const Text("Rate App"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddReviewScreen(),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Support", style: headingStyle),
                    ],
                  ),
                  const ListTile(
                    leading: Icon(Icons.file_open_outlined),
                    title: Text("Terms of Service"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.contact_support),
                    title: Text("Contact Us"),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
